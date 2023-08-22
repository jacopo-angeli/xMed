import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:xmed/core/network/data_states.dart';
import 'package:xmed/core/network/http_custom_client.dart';
import 'package:xmed/features/license/data/models/license_activate/license_activate_request_dto.dart';
import 'package:xmed/features/license/data/models/license_download/license_download_request_dto.dart';
import 'package:xmed/features/license/domain/entities/license.dart';
import 'package:xmed/features/license/domain/repositories/license_repository.dart';

import '../../../../utils/exceptions.dart';

class LicenseRepositoryImpl implements LicenseRepository {
  @override
  Future<Either<DataState, License>> licenseActivate(
      {required String idClinica,
      required String IdPromoCode,
      required String institute}) async {}
  // TODO Capire come attivare una licenza su fl_firmagrafometrica
}

@override
Future<Either<DataState, License>> licenseDownload(
    {required String idClinica, required String institute}) async {
  if (idClinica.isEmpty || institute.isEmpty) {
    throw (LicenseDownloadException);
  }
  //TODO Guarda Output delle API x download e attivazione
}
