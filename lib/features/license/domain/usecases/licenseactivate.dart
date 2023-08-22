import 'package:dartz/dartz.dart';
import '../entities/license.dart';
import '../repositories/license_repository.dart';
import '../../../../core/error_handling/failures.dart';

// TODO Comments
class LicenseActivateUseCase {
  final LicenseRepository licenseRepository;
  LicenseActivateUseCase({required this.licenseRepository});

  Future<Either<FailureEntity, void>> execute({
    required String idClinica,
    required String idPromoCode,
  }) async {
    return await licenseRepository.licenseActivate(
        idClinica: idClinica, idPromoCode: idPromoCode);
  }
}
