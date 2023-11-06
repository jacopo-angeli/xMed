import 'package:equatable/equatable.dart';

import 'package:xmed/features/login/data/models/authentication/authentication_response_dto.dart';

/// Questa classe rappresenta un utente e le sue informazioni associate.
class User extends Equatable {
  final String idClinica; // ID della clinica associata all'utente
  final int flagLicenzaObbligatoria; // Indicatore di licenza obbligatoria
  final String status; // Stato dell'utente
  final String username;

  /// Costruttore per inizializzare un oggetto User.
  const User(
      {required this.idClinica,
      required this.flagLicenzaObbligatoria,
      required this.status,
      required this.username});

  /// Costruttore per generare un utente predefinito.
  factory User.defaultUser() => const User(
      idClinica: '', flagLicenzaObbligatoria: 0, status: '', username: '');

  /// Metodo per creare una copia dell'utente con alcune proprietà modificate.
  User copyWith(
      {String? idClinica,
      int? flagLicenzaObbligatoria,
      String? status,
      String? username}) {
    return User(
        idClinica: idClinica ?? this.idClinica,
        flagLicenzaObbligatoria:
            flagLicenzaObbligatoria ?? this.flagLicenzaObbligatoria,
        status: status ?? this.status,
        username: username ?? this.username);
  }

  /// Costruttore per creare un oggetto User da un oggetto AuthenticationResponseDto.
  factory User.fromDto(AuthenticationResponseDto dto, String username) {
    return User(
        idClinica: dto.getIdClinica,
        flagLicenzaObbligatoria: dto.getFlagLicenzaObbligatoria,
        status: dto.getStatus,
        username: username);
  }

  /// Override del metodo per determinare le proprietà dell'oggetto da considerare per l'uguaglianza.
  @override
  List<Object?> get props =>
      [idClinica, flagLicenzaObbligatoria, status, username];
}
