import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../../utils/global_data_models/common/message.dart';

class LicenseDownloadResponseDto {
  final LicenseDownloadResponseBody output;
  LicenseDownloadResponseDto({
    required this.output,
  });

  LicenseDownloadResponseDto copyWith({
    LicenseDownloadResponseBody? output,
  }) {
    return LicenseDownloadResponseDto(
      output: output ?? this.output,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'output': output.toMap(),
    };
  }

  factory LicenseDownloadResponseDto.fromMap(Map<String, dynamic> map) {
    return LicenseDownloadResponseDto(
      output: LicenseDownloadResponseBody.fromMap(
          map['output'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LicenseDownloadResponseDto.fromJson(String source) =>
      LicenseDownloadResponseDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LicenseDownloadResponseDto(output: $output)';

  @override
  bool operator ==(covariant LicenseDownloadResponseDto other) {
    if (identical(this, other)) return true;

    return other.output == output;
  }

  @override
  int get hashCode => output.hashCode;
}

class LicenseDownloadResponseBody {
  final Body body;
  final List<Message> messages;
  final String result;
  LicenseDownloadResponseBody({
    required this.body,
    required this.messages,
    required this.result,
  });

  LicenseDownloadResponseBody copyWith({
    Body? body,
    List<Message>? messages,
    String? result,
  }) {
    return LicenseDownloadResponseBody(
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

  factory LicenseDownloadResponseBody.fromMap(Map<String, dynamic> map) {
    return LicenseDownloadResponseBody(
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

  factory LicenseDownloadResponseBody.fromJson(String source) =>
      LicenseDownloadResponseBody.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LicenseDownloadResponseBody(body: $body, messages: $messages, result: $result)';

  @override
  bool operator ==(covariant LicenseDownloadResponseBody other) {
    if (identical(this, other)) return true;

    return other.body == body &&
        listEquals(other.messages, messages) &&
        other.result == result;
  }

  @override
  int get hashCode => body.hashCode ^ messages.hashCode ^ result.hashCode;
}

class Body {
  final String content;
  final int idClinica;
  final int idPromoCode;
  Body({
    required this.content,
    required this.idClinica,
    required this.idPromoCode,
  });

  Body copyWith({
    String? content,
    int? idClinica,
    int? idPromoCode,
  }) {
    return Body(
      content: content ?? this.content,
      idClinica: idClinica ?? this.idClinica,
      idPromoCode: idPromoCode ?? this.idPromoCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'idClinica': idClinica,
      'idPromoCode': idPromoCode,
    };
  }

  factory Body.fromMap(Map<String, dynamic> map) {
    return Body(
      content: map['content'] as String,
      idClinica: map['idClinica'] as int,
      idPromoCode: map['idPromoCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Body.fromJson(String source) =>
      Body.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Body(content: $content, idClinica: $idClinica, idPromoCode: $idPromoCode)';

  @override
  bool operator ==(covariant Body other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.idClinica == idClinica &&
        other.idPromoCode == idPromoCode;
  }

  @override
  int get hashCode =>
      content.hashCode ^ idClinica.hashCode ^ idPromoCode.hashCode;
}
