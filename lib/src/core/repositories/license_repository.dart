import '../../data/models/license_activate/license_activate_request_dto.dart';
import '../../data/models/license_download/license_download_request_dto.dart';

abstract class LicenseRepository {
  /// Attivazione di una licenza a partire da un promo code
  Future<void> activateLicense(LicenseActivateRequestDto requestBody);

  /// Download del documento di una licenza
  Future<String> downloadLicense(LicenseDownloadRequestDto requestBody);
}
