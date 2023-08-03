import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xmed/constants/constants.dart';
import 'package:xmed/utils/crypto.dart';
import 'package:xmed/utils/signature.dart';

/* Commented by ChatGPT */

/// Classe XMedTableHttpClient
///
/// Questa classe rappresenta un client HTTP personalizzato per effettuare richieste POST
/// a un server remoto. Viene utilizzata per inviare richieste al server utilizzando il
/// protocollo HTTP e restituire le risposte dal server.
class XMedTabletHttpClient {
  late Dio client; // Oggetto Dio per effettuare le richieste HTTP
  late String body; // Il corpo della richiesta HTTP

  /// Costruttore della classe XMedTableHttpClient.
  ///
  /// Inizializza il client HTTP Dio e il corpo della richiesta HTTP.
  XMedTabletHttpClient.builder();

  /// Costruisce gli headers per la richiesta HTTP.
  ///
  /// Questa funzione riceve in input una firma digitale [signature] e un'immagine digitale [thumbprint]
  /// e restituisce un Map contenente gli headers necessari per la richiesta HTTP.
  static Map<String, String> buildHeaders({
    required String signature,
    required String thumbprint,
  }) {
    return <String, String>{
      'Content-type':
          'application/json', // Tipo di contenuto della richiesta: JSON
      'X-Signature-Type': 'SHA256withRSA', // Tipo di firma digitale utilizzata
      'X-Signature': signature, // La firma digitale calcolata
      'X-Thumbprint':
          thumbprint, // L'immagine digitale (thumbprint) del certificato
      'X-institute': '2272', // ID dell'istituto, valore fisso '2272'
    };
  }

  /// Imposta il corpo della richiesta HTTP.
  ///
  /// Questa funzione prende in input una mappa [requestBody] contenente i dati da inviare al server.
  /// Il corpo della richiesta viene convertito in formato JSON utilizzando `jsonEncode`.
  /// Viene inoltre generato un thumbprint del certificato e una firma digitale per la richiesta
  /// utilizzando i servizi `Crypto` e `SignatureService`.
  /// Infine, viene inizializzato l'oggetto Dio con le opzioni di base, inclusi gli headers
  /// necessari per la richiesta HTTP.
  Future<XMedTabletHttpClient> setRequestBody(
      Map<String, dynamic> requestBody) async {
    body = jsonEncode(requestBody);

    // Genera l'immagine digitale (thumbprint) del certificato.
    String thumbprint = await Crypto.generateThumbprint();

    // Genera la firma digitale per il corpo della richiesta.
    String signature = await SignatureService.generateSignature(body);
    print("dsdsdas");
    // Configura l'oggetto Dio con le opzioni di base e gli headers necessari.
    client = Dio(BaseOptions(
      connectTimeout: HttpClientCostants.connectionLimitTimeout,
      receiveTimeout: HttpClientCostants.receiveLimitTimeout,
      baseUrl: HttpClientCostants.baseUrl,
      headers: buildHeaders(signature: signature, thumbprint: thumbprint),
    ));
    return this;
  }

  /// Effettua una richiesta HTTP POST.
  ///
  /// Questa funzione invia la richiesta POST al server con l'endpoint specificato [endPoint]
  /// e il corpo della richiesta precedentemente impostato.
  /// Se il corpo della richiesta è vuoto, viene lanciata un'eccezione con il messaggio "Post request without body".
  /// Viene restituita la risposta dal server in formato `Future<Response<dynamic>>`.
  Future<Response<dynamic>> post(String endPoint) async {
    if (body.isEmpty) throw Exception("Richiesta POST senza corpo");
    final response = client.post(endPoint, data: body);
    dispose(); // Chiude il client HTTP dopo aver inviato la richiesta
    return response;
  }

  /// Chiude il client HTTP.
  ///
  /// Questa funzione chiude l'oggetto Dio dopo aver inviato la richiesta HTTP.
  void dispose() {
    client.close();
  }
}
