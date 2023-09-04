// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LicenseActivateRequestDto {
  final String idClinica;
  final String idPromoCode;
  LicenseActivateRequestDto({
    required this.idClinica,
    required this.idPromoCode,
  });
  final int institute = 2272;

  LicenseActivateRequestDto copyWith({
    String? idClinica,
    String? idPromoCode,
  }) {
    return LicenseActivateRequestDto(
      idClinica: idClinica ?? this.idClinica,
      idPromoCode: idPromoCode ?? this.idPromoCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'input': <String, dynamic>{
        'idClinica': idClinica,
        'idPromoCode': idPromoCode,
        'institute': institute
      }
    };
  }

  factory LicenseActivateRequestDto.fromMap(Map<String, dynamic> map) {
    return LicenseActivateRequestDto(
      idClinica: map['idClinica'] as String,
      idPromoCode: map['idPromoCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LicenseActivateRequestDto.fromJson(String source) =>
      LicenseActivateRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LicenseActivateRequestDto(idClinica: $idClinica, idPromoCode: $idPromoCode)';

  @override
  bool operator ==(covariant LicenseActivateRequestDto other) {
    if (identical(this, other)) return true;

    return other.idClinica == idClinica && other.idPromoCode == idPromoCode;
  }

  @override
  int get hashCode => idClinica.hashCode ^ idPromoCode.hashCode;
}
