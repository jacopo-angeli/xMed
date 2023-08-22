import 'package:dartz/dartz.dart';
import '../entities/license.dart';
import '../repositories/license_repository.dart';
import '../../../../core/network/data_states.dart';

class LicenseDownloadUseCase {
  final LicenseRepository licenseRepository;
  LicenseDownloadUseCase({required this.licenseRepository});
  Future<Either<DataState, License>> execute(
      {required String idClinica, required String institute}) async {
    return await licenseRepository.licenseDownload(idClinica, institute);
  }
}
