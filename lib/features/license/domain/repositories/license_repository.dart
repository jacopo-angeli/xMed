import 'package:dartz/dartz.dart';
import '../entities/license.dart';
import '../../../../core/error_handling/failures.dart';

abstract class LicenseRepository {
  // -------------------------- licenseDownload ---------------------------- //

  Future<Either<FailureEntity, License>> licenseDownload(
      {required String idClinica});

  // -------------------------- licenseActivate ---------------------------- //

  // RICHIEDE L'ATTIVAZIONE DI UNA LICENZA
  Future<Either<FailureEntity, void>> licenseActivate(
      {required String idClinica, required License licenzaNonAttiva});

  // -------------------------- getNamirialLicenseData ---------------------------- //
  // RECUPERA LA LICENZA SALVATA NEL DISPOSITIVO SE è PRESENTE
  Future<Either<FailureEntity, License>> getLocalLicense();

  // -------------------------- persistLicense ---------------------------- //
  Future<void> persistLicense(License license);

  // -------------------------- getNamirialLicensePath ---------------------------- //
  Future<String> getLocalLicenseFilePath();
}
