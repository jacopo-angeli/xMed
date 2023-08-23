import 'dart:convert';
import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:xmed/utils/services/crypto_service.dart';
import 'package:xmed/utils/services/signature_service.dart';

import '../../utils/constants/strings.dart';

/// Utilizzo
/// client = HttpCustomClient()..initialize(Map<string, dynamic> mapRequestBody);\
/// try{ \
///   client.post(String endpoint) \
/// } on Exception{\
///    manage exception \
/// }
class HttpCustomClient {
  late Dio client;
  late String body;

  HttpCustomClient();

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
    body = jsonEncode({'input': mapRequestBody});

    // Recupera firma e thumbprint
    String signature = await SignatureService.generateSignature(body);
    String thumbprint = await CryptoService.generateThumbprint();

    client = Dio(BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
      baseUrl: baseUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-Signature-Type': 'SHA256withRSA',
        'X-Signature': signature,
        'X-Thumbprint': thumbprint,
        'X-Institute': '2272',
      },
    ));

    // Include interceptor per debugging.
    client.interceptors.add(DioLoggingInterceptor(level: Level.body));
  }

  /// Perform POST request and then autodispose
  Future<Response<dynamic>> post(path) async {
    // Chiamata prima dell'inizializzazione lancia eccezione
    if (client.options.baseUrl.isNull) {
      throw Exception("Client not initialized.");
    }
    final response = await client.post(path, data: body);
    dispose();
    return response;
  }

  /// Autodispose or invoke client.close() manually
  void dispose() {
    client.close();
  }
}
