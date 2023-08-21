// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LicenseDownloadRequestDto {
  final int idClinica;
  LicenseDownloadRequestDto({
    required this.idClinica,
  });
  final int institute = 2272;

  LicenseDownloadRequestDto copyWith({
    int? idClinica,
  }) {
    return LicenseDownloadRequestDto(
      idClinica: idClinica ?? this.idClinica,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idClinica': idClinica,
    };
  }

  factory LicenseDownloadRequestDto.fromMap(Map<String, dynamic> map) {
    return LicenseDownloadRequestDto(
      idClinica: map['idClinica'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LicenseDownloadRequestDto.fromJson(String source) =>
      LicenseDownloadRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LicenseDownloadRequestDto(idClinica: $idClinica)';

  @override
  bool operator ==(covariant LicenseDownloadRequestDto other) {
    if (identical(this, other)) return true;

    return other.idClinica == idClinica;
  }

  @override
  int get hashCode => idClinica.hashCode;
}