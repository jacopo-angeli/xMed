import 'dart:convert';

/// Questa classe rappresenta le credenziali di accesso utente all'interno dell'applicazione.
///
/// Le [CredentialsEntity] contengono le informazioni di autenticazione, come l'indirizzo
/// email e la password dell'utente.
class CredentialsEntity {
  /// L'indirizzo email associato alle credenziali.
  final String? email;

  /// La password associata alle credenziali.
  final String? password;

  /// Costruttore della classe [CredentialsEntity].
  CredentialsEntity({
    this.email,
    this.password,
  });

  /// Crea una copia delle credenziali con attributi opzionali sovrascritti.
  CredentialsEntity copyWith({
    String? email,
    String? password,
  }) {
    return CredentialsEntity(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  /// Converte le credenziali in una mappa chiave-valore.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  /// Crea un'istanza di [CredentialsEntity] da una mappa.
  factory CredentialsEntity.fromMap(Map<String, dynamic> map) {
    return CredentialsEntity(
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  /// Converte le credenziali in una stringa JSON.
  String toJson() => json.encode(toMap());

  /// Crea un'istanza di [CredentialsEntity] da una stringa JSON.
  factory CredentialsEntity.fromJson(String source) =>
      CredentialsEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Restituisce una rappresentazione testuale delle credenziali.
  @override
  String toString() => 'CredentialsEntity(email: $email, password: $password)';

  /// Sovrascrive l'operatore di uguaglianza `==` per confrontare due oggetti [CredentialsEntity].
  @override
  bool operator ==(covariant CredentialsEntity other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  /// Sovrascrive il metodo `hashCode` per calcolare un valore hash unico per [CredentialsEntity].
  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
