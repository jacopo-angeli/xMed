// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../utils/constants/enums/credential_status.dart';

class User extends Equatable {
  final String? username;
  final bool? flagLicenzaObbligatoria;
  final CredentialStatus? status;
  const User({
    this.username,
    this.flagLicenzaObbligatoria,
    this.status,
  });

  factory User.defaultUser() => const User();

  bool get isEmpty => this == User.defaultUser();
  bool get isNotEmpty => this != User.defaultUser();

  bool get isActive => status == CredentialStatus.ACTIVATED;

  User copyWith({
    String? username,
    bool? flagLicenzaObbligatoria,
    CredentialStatus? status,
  }) {
    return User(
      username: username ?? this.username,
      flagLicenzaObbligatoria:
          flagLicenzaObbligatoria ?? this.flagLicenzaObbligatoria,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'flagLicenzaObbligatoria': flagLicenzaObbligatoria,
      'status': status,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      flagLicenzaObbligatoria: map['flagLicenzaObbligatoria'] as bool,
      status: map['status'] as CredentialStatus,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [username, flagLicenzaObbligatoria, status];
}
