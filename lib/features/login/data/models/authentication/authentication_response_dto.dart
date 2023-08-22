// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import '../../../../../utils/constants/enums/credential_status.dart';
import '../../../../../utils/global_data_models/common/message.dart';

class AuthenticationResponseDto {
  final Output output;
  AuthenticationResponseDto({
    required this.output,
  });

  AuthenticationResponseDto copyWith({
    Output? output,
  }) {
    return AuthenticationResponseDto(
      output: output ?? this.output,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'output': output.toMap(),
    };
  }

  factory AuthenticationResponseDto.fromMap(Map<String, dynamic> map) {
    return AuthenticationResponseDto(
      output: Output.fromMap(map['output'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationResponseDto.fromJson(String source) =>
      AuthenticationResponseDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthenticationResponseDto(output: $output)';

  @override
  bool operator ==(covariant AuthenticationResponseDto other) {
    if (identical(this, other)) return true;

    return other.output == output;
  }

  @override
  int get hashCode => output.hashCode;
}

class Output {
  final Body body;
  final List<Message> messages;
  final String result;
  Output({
    required this.body,
    required this.messages,
    required this.result,
  });

  Output copyWith({
    Body? body,
    List<Message>? messages,
    String? result,
  }) {
    return Output(
      body: body ?? this.body,
      messages: messages ?? this.messages,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body.toMap(),
      'messages': messages.map((x) => x.toMap()).toList(),
      'result': result,
    };
  }

  factory Output.fromMap(Map<String, dynamic> map) {
    return Output(
      body: Body.fromMap(map['body'] as Map<String, dynamic>),
      messages: List<Message>.from(
        (map['messages'] as List<int>).map<Message>(
          (x) => Message.fromMap(x as Map<String, dynamic>),
        ),
      ),
      result: map['result'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Output.fromJson(String source) =>
      Output.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Output(body: $body, messages: $messages, result: $result)';

  @override
  bool operator ==(covariant Output other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.body == body &&
        listEquals(other.messages, messages) &&
        other.result == result;
  }

  @override
  int get hashCode => body.hashCode ^ messages.hashCode ^ result.hashCode;
}

class Body {
  final String flagLicenzaObbligatoria;
  final int idClinica;
  final CredentialStatus status;
  Body({
    required this.flagLicenzaObbligatoria,
    required this.idClinica,
    required this.status,
  });

  Body copyWith({
    String? flagLicenzaObbligatoria,
    int? idClinica,
    CredentialStatus? status,
  }) {
    return Body(
      flagLicenzaObbligatoria:
          flagLicenzaObbligatoria ?? this.flagLicenzaObbligatoria,
      idClinica: idClinica ?? this.idClinica,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flagLicenzaObbligatoria': flagLicenzaObbligatoria,
      'idClinica': idClinica,
      'status': status,
    };
  }

  factory Body.fromMap(Map<String, dynamic> map) {
    return Body(
      flagLicenzaObbligatoria: map['flagLicenzaObbligatoria'] as String,
      idClinica: map['idClinica'] as int,
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

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
