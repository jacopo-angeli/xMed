import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:xmed/utils/constants/STRINGS.dart';
import 'package:xmed/utils/services/crypto_service.dart';
import 'package:xmed/utils/services/signature_service.dart';

import '../../utils/constants/numbers.dart';

class HttpCustomClient {
  late Dio client;
  late String body;

  HttpCustomClient.builder();

  /// Build headers according to the API authentication scheme
  static Map<String, String> _buildHeaders({
    required String signature,
    required String thumbprint,
    String institute = '2272',
  }) {
    return <String, String>{
      'Content-Type': 'application/json',
      'X-Signature-Type': 'SHA256withRSA',
      'X-Signature': signature,
      'X-Thumbprint': thumbprint,
      'X-Institute': institute,
    };
  }

  /// Builds an http client compliant with API security spec.
  Future<HttpCustomClient> setup(String requestBody) async {
    client = Dio(
      BaseOptions(
        connectTimeout: connectionLimitTimeout,
        receiveTimeout: receiveLimitTimeout,
        baseUrl: baseUrl,
        headers: _buildHeaders(
          signature: await SignatureService.generateSignature(requestBody),
          thumbprint: await CryptoService.generateThumbprint(),
        ),
      ),
    )..interceptors.add(DioLoggingInterceptor(level: Level.body));

    return this;
  }

  /// Perform POST request and then autodispose
  Future<Response<dynamic>> post(path) async {
    final response = client.post(path, data: body);
    dispose();
    return response;
  }

  /// Autodispose or invoke client.close() manually
  void dispose() {
    client.close();
  }
}
