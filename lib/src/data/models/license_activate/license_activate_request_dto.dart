// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LicenseActivateRequestDto {
  final int idClinica;
  final int promoCode;
  LicenseActivateRequestDto({
    required this.idClinica,
    required this.promoCode,
  });
  final int institute = 2272;

  LicenseActivateRequestDto copyWith({
    int? idClinica,
    int? promoCode,
  }) {
    return LicenseActivateRequestDto(
      idClinica: idClinica ?? this.idClinica,
      promoCode: promoCode ?? this.promoCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idClinica': idClinica,
      'promoCode': promoCode,
    };
  }

  factory LicenseActivateRequestDto.fromMap(Map<String, dynamic> map) {
    return LicenseActivateRequestDto(
      idClinica: map['idClinica'] as int,
      promoCode: map['promoCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LicenseActivateRequestDto.fromJson(String source) =>
      LicenseActivateRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LicenseActivateRequestDto(idClinica: $idClinica, promoCode: $promoCode)';

  @override
  bool operator ==(covariant LicenseActivateRequestDto other) {
    if (identical(this, other)) return true;

    return other.idClinica == idClinica && other.promoCode == promoCode;
  }

  @override
  int get hashCode => idClinica.hashCode ^ promoCode.hashCode;
}
