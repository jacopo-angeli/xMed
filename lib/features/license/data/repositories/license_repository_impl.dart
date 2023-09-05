import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xmed/features/license/data/models/license_activate/license_activate_request_dto.dart';
import '../../../../core/error_handling/failures.dart';
import 'package:xmed/core/network/http_custom_client.dart';
import 'package:xmed/features/license/data/models/license_download/license_download_request_dto.dart';
import 'package:xmed/features/license/domain/entities/license.dart';
import 'package:xmed/features/license/domain/repositories/license_repository.dart';

import '../../../../core/utils/constants/strings.dart';
import '../models/license_activate/license_activate_response_dto.dart';
import '../models/license_download/license_download_response_dto.dart';

/// L'api di download ritorna un promoCode che deve essere
/// 'attivato' in seguito all' attivazione da parte dell'SDK
/// di namirial, mediante l'utilizzo dell'api di attivazione

class LicenseRepositoryImpl implements LicenseRepository {
  @override
  Future<Either<FailureEntity, License>> licenseDownload(
      {required String idClinica}) async {
    // CREAZIONE CORPO DELLA RICHIESTA
    final requestBody = LicenseDownloadRequestDto(idClinica: idClinica);

    // DICHIARAZIONE E INIZIALIZZAZIONE CUSTOM CLIENT
    final client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    // DEFINIZIONE VARIABILE RISPOSTA DA (package:Dio)
    late Response response;

    // TENTO LA RICHIESTA AL BACKOFFICE
    try {
      response = await client.post(licenseDownloadEndPoint);
    } on Exception {
      // QUALCOSA è ANDATO STORTO
      return const Left(ServerFailure());
    }

    // COSTRUISCO OGGETTO DTO DALLA RISPOSTA
    late LicenseDownloadResponseDto data;
    try {
      data =
          LicenseDownloadResponseDto.fromMap(response.data['output']['body']);
      debugPrint(data.content);
    } on Exception {
      // QUALCOSA è ANDATO STORTO
      return const Left(ServerFailure());
    }

    // COSTRUZIONE MODELLO DALLA RISPOSTA
    // COSTRUISCE UNA LICENZA CON promoCode, cert
    // E status = DA_ATTIVARE
    final namirialLicense =
        json.decode(utf8.decode(base64.decode(data.content)));
    final License license = License(
        cert: namirialLicense['cert'],
        promoCode: namirialLicense['promoCode'],
        status: "DA_ATTIVARE");

    return Right(license);
  }

  @override
  Future<void> persistLicense(License license) async {
    // RECUPERO CARTELLA DI APP DATA
    final Directory appDataDirectory = await getApplicationDocumentsDirectory();
    final String appDataPath = appDataDirectory.path;

    final Directory licenseDirectory = Directory('$appDataPath/license');
    // SE LA CARTELLA license NON ESISTE LA CREO
    if (!licenseDirectory.existsSync()) {
      licenseDirectory.createSync(recursive: true);
    }
    final String licenseDirectoryPath = licenseDirectory.path;

    // SALVO IL FILE PER SDK
    final file = File("$licenseDirectoryPath/license.afgclic");
    file.writeAsStringSync(
        '{"promoCode": ${license.promoCode}, "cert": ${license.cert}}');
  }

  @override
  Future<Either<FailureEntity, void>> licenseActivate(
      {required String idClinica, required License licenzaNonAttiva}) async {
    // CREAZIONE CORPO DELLA RICHIESTA
    final requestBody = LicenseActivateRequestDto(
        idClinica: idClinica, idPromoCode: licenzaNonAttiva.promoCode);

    // DICHIARAZIONE E INIZIALIZZAZIONE CUSTOM CLIENT
    final client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    // DEFINIZIONE VARIABILE RISPOSTA DA (package:Dio)
    late Response response;

    // TENTO LA RICHIESTA AL BACKOFFICE
    try {
      response = await client.post(licenseActivateEndPoint);
    } on Exception {
      // QUALCOSA è ANDATO STORTO
      return const Left(ServerFailure());
    }

    // COSTRUISCO OGGETTO DTO DALLA RISPOSTA
    late LicenseActivateResponseDto data;
    try {
      data =
          LicenseActivateResponseDto.fromMap(response.data['output']['body']);
    } on Exception {
      // QUALCOSA è ANDATO STORTO
      return const Left(ServerFailure());
    }

    //GESTIONE MESSAGGI DI ERRORE
    // if (data.messages.isNotEmpty) {
    //   return const Left(ValidationFailure());
    // }

    return const Right(null);
  }

  @override
  Future<Either<FailureEntity, License>> getLocalLicense() async {
    // RECUPERO LA DIRECTORY APP DATA
    final Directory appData = await getApplicationDocumentsDirectory();
    final String appDataPath = appData.path;

    // COSTRUISCO IL PATH DEL FILE DELLA LICENZA
    final String licenseFilePath = "$appDataPath/license/license.afgclic";

    // RECUPERO IL FILE
    File file = File(licenseFilePath);

    if (file.existsSync()) {
      // FILE TROVATO
      debugPrint("FILE TROVATO");
      try {
        return Right(License.fromJson(file.readAsStringSync()));
      } on Exception {
        return const Left(DataParsingFailure());
      }
    } else {
      return const Left(MissingLocalLicense());
    }
  }

  @override
  Future<String> getLocalLicenseFilePath() async {
    // RECUPERO CARTELLA DI APP DATA
    final Directory appDataDirectory = await getApplicationDocumentsDirectory();
    final String appDataPath = appDataDirectory.path;

    final Directory licenseDirectory = Directory('$appDataPath/license');
    // SE LA CARTELLA license NON ESISTE LA CREO
    if (!licenseDirectory.existsSync()) {
      licenseDirectory.createSync(recursive: true);
    }
    final String licenseDirectoryPath = licenseDirectory.path;

    // RITONRO PATH DEL FILE
    return "$licenseDirectoryPath/license.afgclic";
  }
}
