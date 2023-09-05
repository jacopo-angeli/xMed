import 'package:dartz/dartz.dart';
import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/license/domain/entities/license.dart';

abstract class NamirialSDKLicenseRepository {
  Future<Either<FailureEntity, License>> requireLicense(
      {required String username,
      required String email,
      required String licenseFilePath});
}
