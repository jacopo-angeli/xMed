// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// Classe per rappresentare il DTO (Data Transfer Object) di una risposta di autenticazione.
class AuthenticationResponseDto {
  final Body body; // Contenuto della risposta

  /// Estrae l'ID della clinica dalla risposta.
  int get getIdClinica => body.idClinica;

  /// Estrae lo stato dalla risposta.
  String get getStatus => body.status;

  /// Estrae il flag di licenza obbligatoria dalla risposta.
  String get getFlagLicenzaObbligatoria => body.flagLicenzaObbligatoria;

  /// Costruttore della classe.
  AuthenticationResponseDto({
    required this.body,
  });

  /// Metodo per creare una copia dell'oggetto con alcuni valori modificati.
  AuthenticationResponseDto copyWith({
    Body? body,
  }) {
    return AuthenticationResponseDto(
      body: body ?? this.body,
    );
  }

  /// Converte l'oggetto in una mappa (Map) di chiavi e valori.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body.toMap(),
    };
  }

  /// Costruttore per creare un oggetto dalla rappresentazione JSON.
  factory AuthenticationResponseDto.fromMap(Map<String, dynamic> map) {
    return AuthenticationResponseDto(
      body: Body.fromMap(map['output']['body'] as Map<String, dynamic>),
    );
  }

  /// Converte l'oggetto in una rappresentazione JSON.
  String toJson() => json.encode(toMap());

  /// Costruttore per creare un oggetto dalla rappresentazione JSON.
  factory AuthenticationResponseDto.fromJson(String source) {
    return AuthenticationResponseDto.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() => 'AuthenticationResponseDto(body: $body)';

  @override
  bool operator ==(covariant AuthenticationResponseDto other) {
    if (identical(this, other)) return true;

    return other.body == body;
  }

  @override
  int get hashCode => body.hashCode;
}

/// Classe per rappresentare il corpo (body) di una risposta di autenticazione.
class Body {
  final String flagLicenzaObbligatoria; // Flag di licenza obbligatoria
  final int idClinica; // ID della clinica
  final String status; // Stato

  /// Costruttore della classe.
  Body({
    required this.flagLicenzaObbligatoria,
    required this.idClinica,
    required this.status,
  });

  /// Metodo per creare una copia dell'oggetto con alcuni valori modificati.
  Body copyWith({
    String? flagLicenzaObbligatoria,
    int? idClinica,
    String? status,
  }) {
    return Body(
      flagLicenzaObbligatoria:
          flagLicenzaObbligatoria ?? this.flagLicenzaObbligatoria,
      idClinica: idClinica ?? this.idClinica,
      status: status ?? this.status,
    );
  }

  /// Converte l'oggetto in una mappa (Map) di chiavi e valori.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flagLicenzaObbligatoria': flagLicenzaObbligatoria,
      'idClinica': idClinica,
      'status': status,
    };
  }

  /// Costruttore per creare un oggetto dalla rappresentazione JSON.
  factory Body.fromMap(Map<String, dynamic> map) {
    return Body(
      flagLicenzaObbligatoria: map['flagLicenzaObbligatoria'],
      idClinica: map['idClinica'],
      status: map['status'],
    );
  }

  /// Converte l'oggetto in una rappresentazione JSON.
  String toJson() => json.encode(toMap());

  /// Costruttore per creare un oggetto dalla rappresentazione JSON.
  factory Body.fromJson(String source) =>
      Body.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Body(flagLicenzaObbligatoria: $flagLicenzaObbligatoria, idClinica: $idClinica, status: $status)';

  @override
  bool operator ==(covariant Body other) {
    if (identical(this, other)) return true;

    return other.flagLicenzaObbligatoria == flagLicenzaObbligatoria &&
        other.idClinica == idClinica &&
        other.status == status;
  }

  @override
  int get hashCode =>
      flagLicenzaObbligatoria.hashCode ^ idClinica.hashCode ^ status.hashCode;
}
