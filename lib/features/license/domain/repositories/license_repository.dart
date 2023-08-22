import 'package:dartz/dartz.dart';
import '../../presentation/cubits/license_cubit.dart';
import '../entities/license.dart';
import '../../../../core/network/data_states.dart';

abstract class LicenseRepository {
  Future<Either<DataState, License>> licenseActivate(
      String idClinica, String IdPromoCode, String institute);
  Future<Either<DataState, License>> licenseDownload(
      String idClinica, String institute);
}

//TODO azioni da rendere disponibili (API)
//licenza ACTIVATE: XTHUMBPRINT, INPUT:{ idClinica, IdPromoCode, institute.} OUTPUT: Body{status, messages[code,message,severity], result}
//licenza DOWNLOAD: XTHUMBPRINT INPUT: idClinica institute. OUTPUT: Body{content idClinica, idPromoCode, messages[code, message, severity], result}
