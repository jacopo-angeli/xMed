import 'package:equatable/equatable.dart';
import 'package:xmed/constants/enums/credential_status.dart';

class User extends Equatable {
  final int? clinicID;
  final CredentialStatus? status;
  final String? username;
  final String? flagLicense;

  const User(
      {required this.clinicID,
      required this.status,
      required this.username,
      required this.flagLicense});

  factory User.defaultActivatedUser() => const User(
      clinicID: 1,
      status: CredentialStatus.ACTIVATED,
      username: "Test User",
      flagLicense: "TBD");

  factory User.defaultDisabledUser() => const User(
      clinicID: 1,
      status: CredentialStatus.DISABLED,
      username: "Test User",
      flagLicense: "TBD");

  @override
  List<Object?> get props => [clinicID, status, username, flagLicense];
}
