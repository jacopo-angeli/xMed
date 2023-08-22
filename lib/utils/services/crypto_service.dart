import 'dart:convert';
import 'package:crypto/crypto.dart' as hash;
import 'package:xmed/utils/services/certficate_service.dart';

class CryptoService {
  /// Genera un thumbprint (impronta digitale) di un certificato.
  ///
  /// Questa funzione recupera asincronamente il certificato dalla memoria di archiviazione
  /// e quindi lo elabora per calcolare l'hash SHA-256, che viene restituito come thumbprint.
  ///
  /// La funzione esegue i seguenti passaggi:
  /// 1. Recupera il certificato dalla memoria di archiviazione in formato corretto utilizzando la funzione [CertificateService.getCertificateFromStorageForThumbprint].
  /// 3. Calcola l'hash SHA-256 del certificato decodificato e lo codifica in base64 per generare il thumbprint.
  ///
  /// Restituisce il thumbprint del certificato come [String] codificata in base64.
  static Future<String> generateThumbprint() async {
    final cleanCertificate =
        await CertificateService.getCertificateFromStorageForThumbprint();
    final bytes = base64Decode(cleanCertificate);
    final digest = hash.sha256.convert(bytes);
    return base64Encode(digest.bytes);
  }
}
