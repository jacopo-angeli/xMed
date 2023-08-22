// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthenticationRequestDto {
  final String email;
  final String password;
  final int institute = 2272;
  AuthenticationRequestDto({required this.email, required this.password});

  AuthenticationRequestDto copyWith({
    String? email,
    String? password,
  }) {
    return AuthenticationRequestDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory AuthenticationRequestDto.fromMap(Map<String, dynamic> map) {
    return AuthenticationRequestDto(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationRequestDto.fromJson(String source) =>
      AuthenticationRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthenticationRequestDto(email: $email, password: $password)';

  @override
  bool operator ==(covariant AuthenticationRequestDto other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.institute == institute;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ institute.hashCode;
}
