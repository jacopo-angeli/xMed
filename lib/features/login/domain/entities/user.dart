import 'package:equatable/equatable.dart';

import 'package:xmed/features/login/data/models/authentication/authentication_response_dto.dart';

/// Questa classe rappresenta un utente e le sue informazioni associate.
class User extends Equatable {
  final int idClinica; // ID della clinica associata all'utente
  final int flagLicenzaObbligatoria; // Indicatore di licenza obbligatoria
  final String status; // Stato dell'utente

  /// Costruttore per inizializzare un oggetto User.
  const User({
    required this.idClinica,
    required this.flagLicenzaObbligatoria,
    required this.status,
  });

  /// Costruttore per generare un utente predefinito.
  factory User.defaultUser() =>
      const User(idClinica: 0, flagLicenzaObbligatoria: 0, status: '');

  /// Metodo per creare una copia dell'utente con alcune proprietà modificate.
  User copyWith({
    int? idClinica,
    int? flagLicenzaObbligatoria,
    String? status,
  }) {
    return User(
      idClinica: idClinica ?? this.idClinica,
      flagLicenzaObbligatoria:
          flagLicenzaObbligatoria ?? this.flagLicenzaObbligatoria,
      status: status ?? this.status,
    );
  }

  /// Costruttore per creare un oggetto User da un oggetto AuthenticationResponseDto.
  factory User.fromDto(AuthenticationResponseDto dto) {
    return User(
      idClinica: dto.getIdClinica,
      flagLicenzaObbligatoria: dto.getFlagLicenzaObbligatoria,
      status: dto.getStatus,
    );
  }

  /// Override del metodo per determinare le proprietà dell'oggetto da considerare per l'uguaglianza.
  @override
  List<Object?> get props => [idClinica, flagLicenzaObbligatoria, status];
}
