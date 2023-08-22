import 'dart:convert';
import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:xmed/utils/constants/STRINGS.dart';
import 'package:xmed/utils/services/crypto_service.dart';
import 'package:xmed/utils/services/signature_service.dart';

import '../../utils/constants/numbers.dart';

/// Utilizzo
/// client = HttpCustomClient()..initialize(Map<string, dynamic> mapRequestBody);\
/// try{ \
///   client.post(String endpoint) \
/// } on Exception{\
///    manage exception \
/// }
class HttpCustomClient {
  late Dio client = Dio();
  late String body;

  HttpCustomClient();

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

  /// Configura e prepara un'istanza di [HttpCustomClient] per effettuare richieste HTTP.
  ///
  /// Questo metodo accetta una [Map] di chiavi [String] e valori dinamici che rappresentano
  /// i parametri del corpo della richiesta. Inizializza un client [Dio] con i timeout di
  /// connessione e ricezione specificati, l'URL di base e gli header personalizzati generati
  /// da [SignatureService] e [CryptoService]. Viene anche aggiunto il [DioLoggingInterceptor]
  /// al client per registrare le informazioni di richiesta e risposta.
  ///
  /// Restituisce un [Future] che si completa con l'istanza di [HttpCustomClient] configurata per
  /// per permettere le chiamate a catena.
  ///
  /// Solleva un'eccezione se si verifica un problema durante la generazione della firma
  /// della richiesta o dell'impronta digitale nell'ambito del processo di creazione dell'header.
  Future<void> initialize(Map<String, dynamic> mapRequestBody) async {
    // Inizializza il corpo della richiesta.
    body = jsonEncode(mapRequestBody);

    // Recupera firma e thumbprint
    String signature = await SignatureService.generateSignature(body);
    String thumbprint = await CryptoService.generateThumbprint();

    // Inizializza un client Dio con header e vincoli definiti dal backoffice
    client.options.connectTimeout = connectionLimitTimeout;
    client.options.receiveTimeout = receiveLimitTimeout;
    client.options.baseUrl = baseUrl;

    //Headers setting
    client.options.headers['Content-Type'] = 'application/json';
    client.options.headers['X-Signature-Type'] = 'SHA256withRSA';
    client.options.headers['X-Signature'] = signature;
    client.options.headers['X-Thumbprint'] = thumbprint;
    client.options.headers['X-Institute'] = '2272';

    // Include interceptor per debugging.
    client.interceptors.add(DioLoggingInterceptor(level: Level.body));
  }

  /// Perform POST request and then autodispose
  Future<Response<dynamic>> post(path) async {
    // Chiamata prima dell'inizializzazione lancia eccezione
    if (client.options.baseUrl.isNull) {
      throw Exception("Client not initialized.");
    }
    final response = client.post(path, data: body);
    dispose();
    return response;
  }

  /// Autodispose or invoke client.close() manually
  void dispose() {
    client.close();
  }
}
