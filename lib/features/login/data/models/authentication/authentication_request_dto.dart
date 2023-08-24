// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// Classe per rappresentare i dati di richiesta di autenticazione.
class AuthenticationRequestDto {
  ///  L'indirizzo email dell'utente.
  final String username;

  /// La password dell'utente.
  final String password;

  /// L'ID dell'istituto di default.
  final int institute = 2272;

  /// Costruttore della classe [AuthenticationRequestDto].
  ///
  /// Richiede l'indirizzo email ([username]) e la password ([password]) dell'utente.
  AuthenticationRequestDto({
    required this.username,
    required this.password,
  });

  /// Metodo per creare una copia dell'oggetto con alcuni valori modificati.
  AuthenticationRequestDto copyWith({
    String? username,
    String? password,
  }) {
    return AuthenticationRequestDto(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  /// Converte l'oggetto in una mappa (Map) di chiavi e valori.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'input': <String, dynamic>{
        'institute': institute,
        'password': password,
        'username': username,
      }
    };
  }

  /// Costruttore per creare un oggetto dalla rappresentazione JSON.
  factory AuthenticationRequestDto.fromMap(Map<String, dynamic> map) {
    return AuthenticationRequestDto(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  /// Converte l'oggetto in una rappresentazione JSON.
  String toJson() => json.encode(toMap());

  /// Costruttore per creare un oggetto dalla rappresentazione JSON.
  factory AuthenticationRequestDto.fromJson(String source) =>
      AuthenticationRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthenticationRequestDto(username: $username, password: $password)';

  @override
  bool operator ==(covariant AuthenticationRequestDto other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.password == password &&
        other.institute == institute;
  }

  @override
  int get hashCode =>
      username.hashCode ^ password.hashCode ^ institute.hashCode;
}
