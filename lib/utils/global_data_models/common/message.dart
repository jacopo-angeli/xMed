// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  final String code;
  final String message;
  final String severity;
  Message({
    required this.code,
    required this.message,
    required this.severity,
  });

  Message copyWith({
    String? code,
    String? message,
    String? severity,
  }) {
    return Message(
      code: code ?? this.code,
      message: message ?? this.message,
      severity: severity ?? this.severity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'severity': severity,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      code: map['code'] as String,
      message: map['message'] as String,
      severity: map['severity'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Message(code: $code, message: $message, severity: $severity)';

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.message == message &&
        other.severity == severity;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ severity.hashCode;
}
