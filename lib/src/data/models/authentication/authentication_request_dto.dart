// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthenticationRequestDto {
  final String username;
  final String password;
  AuthenticationRequestDto({
    required this.username,
    required this.password,
  });
  final int institute = 2272;

  AuthenticationRequestDto copyWith({
    String? username,
    String? password,
  }) {
    return AuthenticationRequestDto(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory AuthenticationRequestDto.fromMap(Map<String, dynamic> map) {
    return AuthenticationRequestDto(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationRequestDto.fromJson(String source) =>
      AuthenticationRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthenticationRequestDto(username: $username, password: $password)';

  @override
  bool operator ==(covariant AuthenticationRequestDto other) {
    if (identical(this, other)) return true;

    return other.username == username && other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
