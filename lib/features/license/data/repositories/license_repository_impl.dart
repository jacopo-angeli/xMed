import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/error_handling/failures.dart';
import 'package:xmed/core/network/http_custom_client.dart';
import 'package:xmed/features/license/data/models/license_download/license_download_request_dto.dart';
import 'package:xmed/features/license/domain/entities/license.dart';
import 'package:xmed/features/license/domain/repositories/license_repository.dart';

import '../models/license_activate/license_activate_response_dto.dart';
import '../models/license_download/license_download_response_dto.dart';

class LicenseRepositoryImpl implements LicenseRepository {
  @override
  Future<Either<FailureEntity, void>> licenseActivate(
      {required String idClinica, required String idPromoCode}) async {
    final requestBody = LicenseDownloadRequestDto.fromMap(<String, dynamic>{
      idClinica: idClinica,
      idPromoCode: idPromoCode,
    });

    // HTTP CLIENT DEFINITION
    final client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    // POST REQUEST PERFORM
    late Response dioResponse;
    try {
      dioResponse = await client.post('/licenzaActivate');
    } on Exception {
      return const Left(LicenseActivationFailure());
    }

    // ANY STATUS CODE != 200 RETURNS A FAILURE
    if (dioResponse.statusCode != 200) {
      return const Left(ServerFailure());
    }

    // CREATING A RESPONSE DTO FROM DIO RESPONSE TYPE
    late LicenseActivateResponseDto responseDto;
    try {
      responseDto = LicenseActivateResponseDto.fromJson(dioResponse.data);
    } on Exception {
      return const Left((DataParsingFailure()));
    }
    //TODO capire come creare una licenza con Namirial SDK
    return const Right(null);
  }

  // Download di una licenza da attivare
  @override
  Future<Either<FailureEntity, License>> licenseDownload(
      {required String idClinica}) async {
    final requestBody = LicenseDownloadRequestDto.fromMap(<String, dynamic>{
      idClinica: idClinica,
    });

    // HTTP CLIENT DEFINITION
    final client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    // POST REQUEST PERFORM
    late Response response;
    try {
      response = await client.post('/licenzaDownload');
    } on Exception {
      return const Left((LicenseDownloadFailure()));
    }

    // ANY STATUS CODE != 200 RETURNS A FAILURE
    if (response.statusCode != 200) {
      return const Left((LicenseRetrieveFailure()));
    }

    // CREATING A RESPONSE DTO FROM DIO RESPONSE TYPE
    late LicenseDownloadResponseDto data;
    try {
      data = LicenseDownloadResponseDto.fromJson(response.data);
    } on Exception {
      return const Left((DataParsingFailure()));
    }

    // if (data.output.messages.isEmpty) {
    //   return const Left(LicenseSaveFailure());
    // }
    // final License license = License.fromMap(data.toMap());
    // const FlutterSecureStorage().write(key: 'idClinica', value: idClinica);
    return const Right(License(
        idClinica: 1,
        IdPromoCode: 1,
        NamirialLicense: {'NamirialLicense': 'NamirialLicense'},
        content: 'content',
        status: 'content'));
  }

  // La funzione controlla se \e presente nel dispositivo una licenza
  // Se la licenza viene trovata allora viene ritornata
  // Se il recupero della licenza non va a buon fine viene ritornato una FailureEntity dedicata
  // Se la licenza non viene trovata allora viene ritornata una FailureEntity dedicata
  @override
  Future<Either<FailureEntity, String>> retrieveLicense() async {
    // Recupero il path della cartella documents dove viene salvata la licenza
    final Directory appData = await getApplicationDocumentsDirectory();

    // Cerco il file nella cartella assets di flutter
    late File file;
    try {
      // Carico il file dalla cartella assets
      final license = await rootBundle.load('assets/license.afgclic');
      file = await File('${appData.path}/license.afgclic').writeAsBytes(
        license.buffer
            .asUint8List(license.offsetInBytes, license.lengthInBytes),
      );
    } catch (e) {
      debugPrint('Debug license file not found');
      // Errore durante il recupero del file, file non presente
      return const Left(LicenseRetrieveFailure());
    }

    // ? File trovato ???
    return Right(file.path);
  }
}
