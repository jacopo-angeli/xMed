import 'package:equatable/equatable.dart';

import '../../../../src/utils/costants/enums/credential_status.dart';

class User extends Equatable {
  final String username;
  final bool flagLicenzaObbligatoria;
  final CredentialStatus status;

  User(
      {required this.username,
      required this.flagLicenzaObbligatoria,
      required this.status});

  @override
  List<Object?> get props => [username, flagLicenzaObbligatoria, status];
}
