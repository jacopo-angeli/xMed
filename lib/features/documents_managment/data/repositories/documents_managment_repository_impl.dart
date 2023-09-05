import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/documents_managment/data/models/document_download/document_download_request_dto.dart';
import 'package:xmed/features/documents_managment/data/models/document_upload/document_upload_request_dto.dart';

import 'package:xmed/features/documents_managment/domain/entities/Document.dart';
import '../../../../core/utils/constants/strings.dart';
import '../../../../core/network/http_custom_client.dart';
import '../../domain/repositories/documents_managment_repository.dart';
import '../models/document_download/document_download_response_dto.dart';
import '../models/document_search/document_search_request_dto.dart';
import '../models/document_search/document_search_response_dto.dart';

class DocumentsManagmentRepositoryImpl implements DocumentsManagmentRepository {
  @override
  Future<Either<FailureEntity, Map<int, Document>>> getRemoteDocuments(
      {required String idClinica}) async {
    // DEFINIZIONE DEL CORPO DELLA RICHISTA
    final requestBody = DocumentSearchRequestDto(
        fromDate: DateTime.fromMicrosecondsSinceEpoch(1490000000000),
        toDate: DateTime.now(),
        idClinica: idClinica,
        status: 'DA_FIRMARE');

    // DEFINIZIONE E INIZIALIZZAZIONE DEL CLIENT
    HttpCustomClient client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    // DEFINIZIONE VARIABILE RISPOSTA DA (package:Dio)
    late Response response;

    // TENTO LA RICHIESTA AL BACKOFFICE
    try {
      response = await client.post(documentoClinicaSearchEndPoint);
    } on Exception {
      // QUALCOSA è ANDATO STORTO
      return const Left(ServerFailure());
    }

    // COSTRUISCO OGGETTO DTO DALLA RISPOSTA
    late DocumentSearchResponseDto data;
    try {
      data = DocumentSearchResponseDto.fromMap(response.data);
    } on Exception {
      // QUALCOSA è ANDATO STORTO
      return const Left(ServerFailure());
    }

    // COSTRUZIONE MAPPA DEI DOCUMENTI
    final Map<int, Document> documentsMap = {};
    for (var documentoDyn in data.body.documenti) {
      final Document documentModel = Document.fromMap(documentoDyn);
      // CHIAVE idDocumento+suadescrizione.length
      documentsMap[documentModel.idDocumento] = documentModel;
    }

    return Right(documentsMap);
  }

  @override
  Future<Either<FailureEntity, void>> documentUpload(
      {required String idClinica, required int idDocumento}) async {
    //FUNZIONE CHE RETRIVA I DATI DEL DOCUMENTO IN BASE64
    String document = await retriveDocumentFromIDs(
        idClinica: idClinica, idDocumento: idDocumento);

    //DEFINIZIONE REQUEST BODY

    final DocumentUploadRequestDto requestBody = DocumentUploadRequestDto(
        content: document,
        dataFirma: DateFormat("yyyy-MM-ddTHH:mm:ssZ")
            .format(DateTime.now())
            .toString(),
        idClinica: int.parse(idClinica),
        idDocumento: idDocumento);
    //DICHIARAZIONE E INIZIALIZZAZIONE DEL CLIENT
    HttpCustomClient client = HttpCustomClient();
    await client.initialize(requestBody.toMap());
    //DICHIARAZIONE DELLA RESPONSE
    late Response response;
    //TENTO DI CARICARE IL DOCUMENTO
    try {
      response = await client.post(documentoClinicaUploadEndPoint);
    } on Exception {
      return const Left(DocumentUploadFailure());
    }
    if (response.statusCode != 200) {
      return const Left((DocumentUploadFailure()));
    }
    //STATUS CODE == 200

    // OPERAZIONE ANDATA A BUON FINE
    return const Right(null);
  }

  @override
  Future<Either<FailureEntity, void>> documentDowload(
      {required int idDocumento,
      required String idClinica,
      required Document remoteDocument}) async {
    // DEFINIZIONE REQUEST BODY
    final DocumentDownloadRequestDto requestBody = DocumentDownloadRequestDto(
        idClinica: idClinica, idDocumento: idDocumento);

    // DICHIARAZIONE DEL CLIENT + SUA INIZIALIZZAZIONE
    HttpCustomClient client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    // DICHIARAZIONE VARIABILE RESPONSE
    late Response response;

    // TENTO IL RECUPERO DEL DOCUMENTO
    try {
      response = await client.post(documentoClinicaDownloadEndPoint);
    } on Exception {
      return const Left((LoginFailure()));
    }

    // RESPONSE STATUS CODE MAP
    // 200
    //    ???
    // 500-403
    //    SIGNATURE O THHUMBPRINT NON VALIDI
    //    ERRORE DI CONNESSIONE CON IL SERVER
    if (response.statusCode != 200) {
      return const Left((LoginFailure()));
    }

    // DICHIARAZIONE DTO
    late DocumentDownloadResponseDto data;

    // CREAZIONE DTO DELLA RISPOSTA DAL RISULTATO DELLA CHIAMATA
    // response.data è DI TIPO Map<string, dynamic>
    try {
      data = DocumentDownloadResponseDto.fromMap(response.data);
    } on Exception {
      return const Left((DataParsingFailure()));
    }

    // TODO : CONTROLLO PER MESSAGGI DI ERRORE
    // if (response.data['output']['messages'].isNotEmpty) {
    //   if (response.data.output.messages[0].code == 'password' ||
    //       response.data.output.messages[0].code == 'username') {
    //     return const Left((LoginFailure()));
    //   }
    // }

    // CREAZIONE DEL MODELLO DEL DOCUMENTO DAL DTO DELLA RISPOSTA
    final Document document =
        remoteDocument.copyWith(content: data.body.content);

    // TODO : SALVATAGGIO IN LOCALE PER UTILIZZO DI NAMIRIAL SDK
    await saveRemoteFileInAppplicationDirectory(document, idClinica);

    // OPERAZIONE ANDATA A BUON FINE
    return const Right(null);
  }

  @override
  Future<Either<FailureEntity, Map<int, Document>>> getLocalDocuments(
      {required String idClinica}) async {
    // Get the application documents directory.
    final clinicDirectoryPath =
        "${(await getApplicationDocumentsDirectory()).path}/clinics/$idClinica";

    Directory clinicDirectory = Directory(clinicDirectoryPath);
    if (clinicDirectory.existsSync()) {
      // Get the list of all files in the directory.
      final files = clinicDirectory.listSync();

      // Create a map to store the PDF documents.
      final pdfDocuments = <int, Document>{};

      // Iterate through the list of files and add the PDF documents to the map.
      for (final file in files) {
        if (file.path.endsWith('.json')) {
          // Get the document data from the file.
          final documentData = File(file.path).readAsStringSync();

          // Create a Document object from the document data.
          final document = Document.fromJson(documentData);

          // Add the document to the map with the `idDocumento` field as the key.
          pdfDocuments[document.idDocumento] = document;
        }
      }

      return Right(pdfDocuments);
    } else {
      // CREO LA REPOSITORY
      // Get the path to the parent folder of the file you want to create.
      String parentFolderPath =
          '${(await getApplicationDocumentsDirectory()).path}/clinics/$idClinica';

      // Create the parent folder if it doesn't exist.
      Directory parentFolder = Directory(parentFolderPath);
      if (!parentFolder.existsSync()) {
        parentFolder.createSync(recursive: true);
      }

      return const Right({});
    }
  }

  @override
  Future<Either<FailureEntity, void>> documentDelete(
      {required int idDocumento, required String idClinica}) async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();

    try {
      // Create a `File` object for the document.
      final file = File(
          '${documentsDirectory.path}/clinics/${idClinica}/${idDocumento}.json');

      // Delete the document.
      file.delete();
    } on Exception {
      return Left(DocumentDownloadFailure());
    }

    return const Right(null);
  }

  Future<void> saveRemoteFileInAppplicationDirectory(
      Document document, String idClinica) async {
    // CONVERTO IL FILE DA BASE64 A "PDF"
    List<int> pdfDataBytes = base64Decode(document.content!);

    String appDataPath = (await getApplicationDocumentsDirectory()).path;
    String fileName = document.idDocumento.toString();
    String folderName = idClinica;
    String folderPath = '$appDataPath/clinics/$folderName';

    // Create the folder if it doesn't exist.
    Directory folderDirectory = Directory(folderPath);
    if (!folderDirectory.existsSync()) {
      folderDirectory.createSync(recursive: true);
    }

    // Save the PDF file.
    File pdfFile = File('$folderPath/$fileName.pdf');
    pdfFile.writeAsBytesSync(pdfDataBytes);

    // SALVO I DATI DEL FILE
    File jsonFile = File('$folderPath/$fileName.json');
    jsonFile.writeAsStringSync(document.toJson());
  }

  @override
  Future<Either<FailureEntity, void>> clearCache(
      {required String idClinica}) async {
    // Get the path to the parent folder of the sub folders you want to clear.
    String currentClinicFolderPath =
        '${(await getApplicationDocumentsDirectory()).path}/clinics/$idClinica';

    // Create a `Directory` object for the parent folder.
    Directory currentClinicFolder = Directory(currentClinicFolderPath);

    // Iterate over the contents of the parent folder.
    currentClinicFolder.listSync().forEach((fileOrFolder) {
      // Check if the file or folder is a file.
      if (fileOrFolder is File) {
        // Delete the file.
        fileOrFolder.deleteSync();
      } else if (fileOrFolder is Directory) {
        // Delete the folder and all of its contents recursively.
        _deleteDirectoryRecursively(fileOrFolder);
      }
    });
    debugPrint("TEST");
    return const Right(null);
  }

  void _deleteDirectoryRecursively(Directory directory) {
    // Iterate over the contents of the directory.
    directory.listSync().forEach((fileOrFolder) {
      // Check if the file or folder is a file.
      if (fileOrFolder is File) {
        // Delete the file.
        fileOrFolder.deleteSync();
      } else if (fileOrFolder is Directory) {
        // Delete the folder and all of its contents recursively.
        _deleteDirectoryRecursively(fileOrFolder);
      }
    });

    // Delete the directory.
    directory.deleteSync();
  }

  @override
  Future<void> clearDevice({required String idClinica}) async {
    // Get the path to the parent folder of the sub folders you want to clear.
    String applicationDocumentsFolderPath =
        "${(await getApplicationDocumentsDirectory()).path}/clinics";

    // Create a `Directory` object for the parent folder.
    Directory applicationDocumentsFolder =
        Directory(applicationDocumentsFolderPath);

    // Iterate over the contents of the parent folder.
    applicationDocumentsFolder.listSync().forEach((fileOrFolder) {
      // Check if the file or folder is a file.
      if (fileOrFolder is File) {
        // Delete the file.
        // fileOrFolder.deleteSync();
      } else if (fileOrFolder is Directory) {
        if (!fileOrFolder.path.contains(idClinica.toString())) {
          debugPrint(
              "TROVATO SOTTOCARTELLE DI ALTRE CLINCHE (${fileOrFolder.path}). ELIMINAZIONE...");
          // Delete the folder and all of its contents recursively.
          _deleteDirectoryRecursively(fileOrFolder);
        }
      }
    });
  }

  @override
  Future<String> getFilePath(
      {required String idDocumento, required String idClinica}) async {
    // RECUPERO CARTELLA DI APP DATA
    final Directory appDataDirectory = await getApplicationDocumentsDirectory();
    final String appDataPath = appDataDirectory.path;

    final Directory clinicRepository =
        Directory('$appDataPath/clinics/$idClinica');
    // SE LA CARTELLA license NON ESISTE LA CREO
    if (!clinicRepository.existsSync()) {
      clinicRepository.createSync(recursive: true);
    }
    final String clinicDirectoryPath = clinicRepository.path;

    // RITONRO PATH DEL FILE
    return "$clinicDirectoryPath/$idDocumento.pdf";
  }

  @override
  Future<void> setDocumentStatus(
      {required String idDocumento,
      required String idClinica,
      required String status}) async {
    // RECUPERO CARTELLA DI APP DATA
    final Directory appDataDirectory = await getApplicationDocumentsDirectory();
    final String appDataPath = appDataDirectory.path;

    final Directory clinicRepository =
        Directory('$appDataPath/clinics/$idClinica');
    // SE LA CARTELLA license NON ESISTE LA CREO
    if (!clinicRepository.existsSync()) {
      clinicRepository.createSync(recursive: true);
    }
    final String clinicDirectoryPath = clinicRepository.path;

    final File oldFile = File("$clinicDirectoryPath/$idDocumento.json");

    Document oldDocumentState = Document.fromJson(oldFile.readAsStringSync());
    Document newDocumentState = oldDocumentState.copyWith(status: status);

    // REWRITE FILE WITH NEW STATE
    oldFile.writeAsStringSync(newDocumentState.toJson());
  }

  @override
  Future<String> retriveDocumentFromIDs(
      {required String idClinica, required int idDocumento}) async {
    //CREO I PARAMETRI RETRIVARE IL FILE
    String appDataPath = (await getApplicationDocumentsDirectory()).path;
    String fileName = idDocumento.toString();
    String folderName = idClinica;
    String folderPath = '$appDataPath/clinics/$folderName';

    // Create the folder if it doesn't exist.
    Directory folderDirectory = Directory(folderPath);
    if (!folderDirectory.existsSync()) {
      folderDirectory.createSync(recursive: true);
    }

    // Save the Base64 file.
    List<int> fileBytesContent = List.empty();
    fileBytesContent = File('$folderPath/$fileName.pdf').readAsBytesSync();
    String base64File = base64Encode(fileBytesContent);
    return base64File;
  }
}
