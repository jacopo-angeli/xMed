import 'package:flutter/services.dart' as services;

/* Comment by ChatGPT */

/// Classe [CertificateService] che fornisce funzionalità per gestire i certificati.
class CertificateService {
  /// Recupera il certificato dalla memoria di archiviazione e lo prepara per l'utilizzo
  /// calcolando l'impronta digitale (thumbprint).
  ///
  /// Restituisce una [Future] contenente una stringa con l'impronta digitale del certificato.
  ///
  /// Solleva un'eccezione [Exception] se il certificato è vuoto o mancante.
  ///
  /// Il certificato deve essere posizionato in 'assets/certificate.crt'.
  static Future<String> getCertificateFromStorageForThumbprint() async {
    // Carica il certificato dalla memoria di archiviazione (assets/certificate.crt).
    String certificate =
        await services.rootBundle.loadString('assets/certificate.crt');

    // Solleva un'eccezione se il certificato è vuoto o mancante.
    if (certificate.isEmpty) throw Exception("Certificato mancante");

    // Rimuove l'intestazione e la coda del certificato, elimina caratteri di nuova linea
    // e spazi bianchi per preparare il certificato per il calcolo dell'impronta digitale.
    return _stripCertificatePreamble(certificate)
        .replaceAll('\n', '')
        .replaceAll(RegExp(r'\s+'), '')
        .trim();
  }

  /// Funzione privata utilizzata per rimuovere l'intestazione e la coda del certificato.
  ///
  /// Parametro [certificate]: Il certificato come stringa.
  /// Restituisce una stringa contenente il certificato senza l'intestazione e la coda.
  static String _stripCertificatePreamble(String certificate) {
    const head = '-----BEGIN CERTIFICATE-----';
    const tail = '-----END CERTIFICATE-----';
    return certificate.replaceAll(head, '').replaceAll(tail, '');
  }
}
