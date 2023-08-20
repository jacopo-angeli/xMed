import 'dart:convert';

import '../../utils/costants/enums/credential_status.dart';

/// Questa classe rappresenta un utente all'interno dell'applicazione.
///
/// Un [UserEntity] contiene informazioni relative all'utente, come l'ID della clinica associata,
/// lo stato delle credenziali, il nome utente e il flag della licenza.
class UserEntity {
  /// L'ID della clinica associata all'utente.
  final int? clinicID;

  /// Lo stato delle credenziali dell'utente.
  final CredentialStatus? status;

  /// Il nome utente dell'utente.
  final String? username;

  /// Il flag della licenza dell'utente.
  final String? flagLicense;

  /// Costruttore della classe [UserEntity].
  UserEntity({
    this.clinicID,
    this.status,
    this.username,
    this.flagLicense,
  });

  /// Crea una copia dell'utente con attributi opzionali sovrascritti.
  UserEntity copyWith({
    int? clinicID,
    CredentialStatus? status,
    String? username,
    String? flagLicense,
  }) {
    return UserEntity(
      clinicID: clinicID ?? this.clinicID,
      status: status ?? this.status,
      username: username ?? this.username,
      flagLicense: flagLicense ?? this.flagLicense,
    );
  }

  /// Converte l'utente in una mappa chiave-valore.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clinicID': clinicID,
      'status': status?.toString(),
      'username': username,
      'flagLicense': flagLicense,
    };
  }

  /// Crea un'istanza di [UserEntity] da una mappa.
  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      clinicID: map['clinicID'] != null ? map['clinicID'] as int : null,
      status: map['status'] != null ? map['status'] as CredentialStatus : null,
      username: map['username'] != null ? map['username'] as String : null,
      flagLicense:
          map['flagLicense'] != null ? map['flagLicense'] as String : null,
    );
  }

  /// Converte l'utente in una stringa JSON.
  String toJson() => json.encode(toMap());

  /// Crea un'istanza di [UserEntity] da una stringa JSON.
  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Restituisce una rappresentazione testuale dell'utente.
  @override
  String toString() {
    return 'UserEntity(clinicID: $clinicID, status: $status, username: $username, flagLicense: $flagLicense)';
  }

  /// Sovrascrive l'operatore di uguaglianza `==` per confrontare due oggetti [UserEntity].
  @override
  bool operator ==(covariant UserEntity other) {
    if (identical(this, other)) return true;

    return other.clinicID == clinicID &&
        other.status == status &&
        other.username == username &&
        other.flagLicense == flagLicense;
  }

  /// Sovrascrive il metodo `hashCode` per calcolare un valore hash unico per [UserEntity].
  @override
  int get hashCode {
    return clinicID.hashCode ^
        status.hashCode ^
        username.hashCode ^
        flagLicense.hashCode;
  }
}
