import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LicenseActivateResponseDto {
  final String status;
  LicenseActivateResponseDto({
    required this.status,
  });

  LicenseActivateResponseDto copyWith({
    String? status,
  }) {
    return LicenseActivateResponseDto(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory LicenseActivateResponseDto.fromMap(Map<String, dynamic> map) {
    return LicenseActivateResponseDto(
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LicenseActivateResponseDto.fromJson(String source) =>
      LicenseActivateResponseDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LicenseActivateResponseDto(status: $status)';

  @override
  bool operator ==(covariant LicenseActivateResponseDto other) {
    if (identical(this, other)) return true;

    return other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
