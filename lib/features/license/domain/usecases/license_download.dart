import 'package:dartz/dartz.dart';
import '../entities/license.dart';
import '../repositories/license_repository.dart';
import '../../../../core/error_handling/failures.dart';

class LicenseDownloadUseCase {
  final LicenseRepository licenseRepository;
  LicenseDownloadUseCase({required this.licenseRepository});
  Future<Either<FailureEntity, License>> execute(
      {required String idClinica}) async {
    return await licenseRepository.licenseDownload(idClinica: idClinica);
  }
}
