// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClinicDetailsRequestDto {
  final int idClinica;
  ClinicDetailsRequestDto({
    required this.idClinica,
  });
  final int institute = 2272;

  ClinicDetailsRequestDto copyWith({
    int? idClinica,
  }) {
    return ClinicDetailsRequestDto(
      idClinica: idClinica ?? this.idClinica,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idClinica': idClinica,
    };
  }

  factory ClinicDetailsRequestDto.fromMap(Map<String, dynamic> map) {
    return ClinicDetailsRequestDto(
      idClinica: map['idClinica'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicDetailsRequestDto.fromJson(String source) =>
      ClinicDetailsRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClinicDetailsRequestDto(idClinica: $idClinica)';

  @override
  bool operator ==(covariant ClinicDetailsRequestDto other) {
    if (identical(this, other)) return true;

    return other.idClinica == idClinica;
  }

  @override
  int get hashCode => idClinica.hashCode;
}
