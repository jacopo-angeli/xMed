import 'package:dartz/dartz.dart';
import '../../presentation/cubits/license_cubit.dart';
import '../entities/license.dart';
import '../../../../core/error_handling/failures.dart';

abstract class LicenseRepository {
  // RICHIEDE L'ATTIVAZIONE DI UNA LICENZA
  Future<Either<FailureEntity, void>> licenseActivate(
      {required String idClinica, required String idPromoCode});

  // SCARICA UNA LICENZA DAL BACKOFFICE DI CWBI
  Future<Either<FailureEntity, License>> licenseDownload(
      {required String idClinica});

  // RICERCA UNA LICENZA IN LOCALE E LA RITORNA SE LA TROVA INTERFACCIANDOSI CON NAMIRIAL SDK
  Either<void, Map<String, dynamic>> retrieveLicense();
}

//TODO azioni da rendere disponibili (API)
//licenza ACTIVATE: XTHUMBPRINT, INPUT:{ idClinica, IdPromoCode, institute.} OUTPUT: Body{status, messages[code,message,severity], result}
//licenza DOWNLOAD: XTHUMBPRINT INPUT: idClinica institute. OUTPUT: Body{content idClinica, idPromoCode, messages[code, message, severity], result}
