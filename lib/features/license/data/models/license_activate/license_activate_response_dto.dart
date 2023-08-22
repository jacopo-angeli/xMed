// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../../utils/global_data_models/common/message.dart';

class LicenseActivateResponseDto {
  final LicenseActivateResponseBody output;
  LicenseActivateResponseDto({
    required this.output,
  });

  LicenseActivateResponseDto copyWith({
    LicenseActivateResponseBody? output,
  }) {
    return LicenseActivateResponseDto(
      output: output ?? this.output,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'output': output.toMap(),
    };
  }

  factory LicenseActivateResponseDto.fromMap(Map<String, dynamic> map) {
    return LicenseActivateResponseDto(
      output: LicenseActivateResponseBody.fromMap(
          map['output'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LicenseActivateResponseDto.fromJson(String source) =>
      LicenseActivateResponseDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LicenseActivateResponseDto(output: $output)';

  @override
  bool operator ==(covariant LicenseActivateResponseDto other) {
    if (identical(this, other)) return true;

    return other.output == output;
  }

  @override
  int get hashCode => output.hashCode;
}

class LicenseActivateResponseBody {
  final Body body;
  final List<Message> messages;
  final String result;
  LicenseActivateResponseBody({
    required this.body,
    required this.messages,
    required this.result,
  });

  LicenseActivateResponseBody copyWith({
    Body? body,
    List<Message>? messages,
    String? result,
  }) {
    return LicenseActivateResponseBody(
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

  factory LicenseActivateResponseBody.fromMap(Map<String, dynamic> map) {
    return LicenseActivateResponseBody(
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

  factory LicenseActivateResponseBody.fromJson(String source) =>
      LicenseActivateResponseBody.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LicenseActivateResponseBody(body: $body, messages: $messages, result: $result)';

  @override
  bool operator ==(covariant LicenseActivateResponseBody other) {
    if (identical(this, other)) return true;

    return other.body == body &&
        listEquals(other.messages, messages) &&
        other.result == result;
  }

  @override
  int get hashCode => body.hashCode ^ messages.hashCode ^ result.hashCode;
}

class Body {
  final String status;
  Body({
    required this.status,
  });

  Body copyWith({
    String? status,
  }) {
    return Body(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory Body.fromMap(Map<String, dynamic> map) {
    return Body(
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Body.fromJson(String source) =>
      Body.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Body(status: $status)';

  @override
  bool operator ==(covariant Body other) {
    if (identical(this, other)) return true;

    return other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
