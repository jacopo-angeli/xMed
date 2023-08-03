import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpClientCostants {
  static final String baseUrl = dotenv.get("API_REST_URL");
  static final int connectionLimitTimeout = 6000;
  static final int receiveLimitTimeout = 6000;
}

class ServicesConstants {
  static final String passwordToDecryptEncryptedPrivateKey =
      dotenv.get("PASSWORD_TO_DECRYPT_ENCRYPTED_PRIVATE_KEY");
}

class Endpoints {
  static final String clinicDetailsEndPoint =
      dotenv.get("CLINIC_DETAILS_ENDPOINT");
}
