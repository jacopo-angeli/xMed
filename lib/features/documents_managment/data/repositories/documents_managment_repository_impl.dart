import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/documents_managment/data/models/document_download/document_download_request_dto.dart';
import 'package:xmed/features/documents_managment/data/models/document_upload/document_upload_request_dto.dart';

import 'package:xmed/features/documents_managment/domain/entities/Document.dart';
import '../../../../utils/constants/strings.dart';
import '../../../../core/network/http_custom_client.dart';
import '../../domain/repositories/documents_managment_repository.dart';
import '../models/document_download/document_download_response_dto.dart';
import '../models/document_search/document_search_request_dto.dart';
import '../models/document_search/document_search_response_dto.dart';
import '../models/document_upload/document_upload_response.dart';

class DocumentsManagmentRepositoryImpl implements DocumentsManagmentRepository {
  @override
  Future<Either<FailureEntity, List<Document>>> documentSearch(
      {required int idClinica}) async {
    final requestBody = DocumentSearchRequestDto(
        fromDate: DateTime.fromMicrosecondsSinceEpoch(1490000000000),
        toDate: DateTime.now(),
        idClinica: idClinica,
        status: 'DA_FIRMARE');

    print(requestBody);

    HttpCustomClient client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    late Response response;
    try {
      response = await client.post(documentoClinicaSearchEndPoint);
    } on Exception {
      return const Left(ServerFailure());
    }
    late DocumentSearchResponseDto data;
    try {
      data = DocumentSearchResponseDto.fromMap(response.data);
    } on Exception {
      return const Left(ServerFailure());
    }
    print("DOCUMENTI RECUPERATI" + data.body.documenti.toString());

    // DOWNLOAD CONTENUTO DEI DOCUMENTI
    final List<Document> documents = [];
    for (var documento in data.body.documenti) {
      // TENTO IL DOWNLOAD DEL DOCUMENTO
      final Either<FailureEntity, Document> documentDowloadAttemp =
          await documentDowload(
              idDocumento: documento['idDocumento'],
              idClinica: idClinica,
              remoteDocument: Document.fromMap(documento));

      // GESTISCO IL RISULTATO
      documentDowloadAttemp.fold((failure) {
        // FALLIMENTO
        // TODO : Gestisco il fallimento
      }, (document) {
        // TENTATIVO DI SUCCESSO
        // AGGIUNGO IL DOCUMENTO ALLA LISTA DI DOCUMENTI DA RITORNARE
        documents.add(document);
      });
    }
    return Right(documents);
  }

  @override
  Future<Either<FailureEntity, void>> documentUpload(
      {required int idClinica, required Document document}) async {
    final DocumentUploadRequestDto requestBody =
        DocumentUploadRequestDto.fromMap(document.toMap());

    // HTTP CLIENT DEFINITION
    final client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    late Response dioResponse;
    try {
      dioResponse = await client.post('/documentUpload');
    } on Exception {
      return const Left(DocumentUploadFailure());
    }
    if (dioResponse.statusCode != 200) {
      return const Left(DocumentUploadFailure());
    }
    late DocumentUploadResponseDto data;
    try {
      data = DocumentUploadResponseDto.fromMap(dioResponse.data);
    } on Exception {
      return Left(DocumentUploadFailure());
    }
    return const Right(null);
  }

  @override
  Future<Either<FailureEntity, Document>> documentDowload(
      {required int idDocumento,
      required int idClinica,
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
      print(response.data);
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

    // CREAZIONE DEL MODELLO UTENTE DAL DTO DELLA RISPOSTA
    final Document document =
        remoteDocument.copyWith(content: data.body.content);

    // TODO : SALVATAGGIO IN LOCALE PER OTTIMIZZAZIONE

    // RITORNO DOCUMENTO RECUPERATO
    return Right(document);
  }
}
