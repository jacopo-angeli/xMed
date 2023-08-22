import 'package:dartz/dartz.dart';
import '../entities/license.dart';
import '../repositories/license_repository.dart';
import '../../../../core/network/data_states.dart';

class LicenseActivateUseCase {
  final LicenseRepository licenseRepository;
  LicenseActivateUseCase({required this.licenseRepository});
  Future<Either<DataState, License>> execute(
      {required String idClinica,
      required String idPromoCode,
      required String institute}) async {
    return await licenseRepository.licenseActivate(
        idClinica, idPromoCode, institute);
  }
}
