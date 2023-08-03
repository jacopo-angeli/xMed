import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/services.dart' as services;

import 'package:xmed/constants/constants.dart';

/* Comment by ChatGPT */

/// Classe [SignatureService] che fornisce servizi per la firma di un messaggio utilizzando RSA.
class SignatureService {
  /// Recupera la chiave privata crittografata dalla memoria di archiviazione.
  ///
  /// Restituisce una stringa rappresentante la chiave privata crittografata.
  /// Se la chiave privata crittografata non è disponibile o è vuota,
  /// viene lanciata un'eccezione con il messaggio "Missing private key file".
  static Future<String> getDecriptedPrivateKeyFromStorage() async {
    String encryptedPrivateKey =
        await services.rootBundle.loadString('assets/private.key');

    if (encryptedPrivateKey.isEmpty) {
      throw Exception("File della chiave privata mancante");
    }

    //TODO : fix decryptPrivateKey
    String privateKey =
        await RSA.decryptPrivateKey(encryptedPrivateKey, "Cambiami2013!");
    return privateKey;
  }

  /// Genera una firma digitale di un messaggio utilizzando RSA.
  ///
  /// [message]: Il messaggio da firmare.
  /// Restituisce una stringa rappresentante la firma digitale del messaggio.
  static Future<String> generateSignature(String message) async {
    String decryptedPrivateKey = await getDecriptedPrivateKeyFromStorage();
    return await RSA.signPKCS1v15(message, Hash.SHA256, decryptedPrivateKey);
  }
}
