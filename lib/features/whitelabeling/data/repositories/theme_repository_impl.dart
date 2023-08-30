import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xmed/core/network/http_custom_client.dart';
import 'package:xmed/features/whitelabeling/data/models/clinic_details/clinic_details_request_dto.dart';
import 'package:xmed/features/whitelabeling/data/models/clinic_details/clinic_details_response_dto.dart';
import 'package:xmed/features/whitelabeling/domain/entities/theme.dart';
import 'package:xmed/features/whitelabeling/domain/repositories/theme_repository.dart';

import '../../../../core/error_handling/failures.dart';
import '../../../../core/utils/constants/strings.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  @override
  Future<Either<FailureEntity, XmedTheme>> getRemoteClinicTheme(
      {required int idClinica}) async {
    // DEFINIZIONE DELLA REQUEST BODY
    final requestBody = ClinicDetailsRequestDto(idClinica: idClinica);

    // DICHIARAZIONE DEL CLIENT + SUA INIZIALIZZAZIONE
    HttpCustomClient client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    // DICHIARAZIONE VARIABILE RESPONSE
    late Response response;

    // TENTO IL LOGIN
    try {
      response = await client.post(clinicDetailsEndPoint);
    } on Exception {
      return const Left((LoginFailure()));
    }

    // RESPONSE STATUS CODE MAP
    // 200
    //    CAMPO username VUOTO
    //    CAMPO password VUOTO
    //    CREDENZIALI CORRETTE
    // 500
    //    CREDENZIALI ERRATE
    //    ERRORE DI CONNESSIONE CON IL SERVER
    if (response.statusCode != 200) {
      return const Left((LoginFailure()));
    }

    // DICHIARAZIONE DTO
    late ClinicDetailsReponseDto data;

    // CREAZIONE DTO DELLA RISPOSTA DAL RISULTATO DELLA CHIAMATA
    // response.data è DI TIPO Map<string, dynamic>
    try {
      final responseBodyField = response.data['output']['body'];
      data = ClinicDetailsReponseDto.fromMap(responseBodyField);
    } on Exception {
      return const Left((DataParsingFailure()));
    }

    if (response.data['output']['messages'].isNotEmpty) {
      if (response.data.output.messages[0].code == 'password' ||
          response.data.output.messages[0].code == 'username') {
        return const Left((LoginFailure()));
      }
    }

    final XmedTheme remoteTheme = XmedTheme.fromMap(data.toMap());

    return Right(remoteTheme);
  }

  @override
  Future<Either<FailureEntity, XmedTheme>> getLocalClinicTheme() async {
    // TENTO IL RECUPERO DEL FILE SALVATO IN LOCALE
    final File file = await _getLocalThemeFile();

    // CONTROLLO SE IL RECUPERO è ANDATO A BUON FINE
    if (file.existsSync()) {
      // IL TEMA ESISTE
      // CREO IL MODELLO DA CONTENUTO DEL FILE
      final String fileContents = await file.readAsString();
      try {
        // TENTATIVO DI CONVERTIRE IL FILE IN MODELLO
        final XmedTheme localTheme = XmedTheme.fromJson(fileContents);
        // RITORNO TEMA
        return Right(localTheme);
      } on Exception {
        // TENTATIVO FALLITO
        return const Left(ThemeRetrieveFailure());
      }
    } else {
      // RITORNO IL TEMA DI DEFAULT
      return const Left(ThemeRetrieveFailure());
    }
  }

  /// Ritorna [File?] variabile che potrebbe contenere file
  Future<File> _getLocalThemeFile() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = documentsDirectory.path;
    File file = File('$path/theme.json');
    return file;
  }

  @override
  Future<void> writeLocalClinicTheme(XmedTheme tema) async {
    final File file = await _getLocalThemeFile();
    file.writeAsString(tema.toJson());
  }
}
