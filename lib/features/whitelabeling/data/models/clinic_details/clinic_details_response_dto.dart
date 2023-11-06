// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClinicDetailsReponseDto {
  final String clinicaID;
  final String colorAccent;
  final String colorBackground;
  final String colorPrimary;
  final String descrizione;
  final String logo;
  final String nome;
  final String status;
  ClinicDetailsReponseDto({
    required this.clinicaID,
    required this.colorAccent,
    required this.colorBackground,
    required this.colorPrimary,
    required this.descrizione,
    required this.logo,
    required this.nome,
    required this.status,
  });

  ClinicDetailsReponseDto copyWith({
    String? clinicaID,
    String? colorAccent,
    String? colorBackground,
    String? colorPrimary,
    String? descrizione,
    String? logo,
    String? nome,
    String? status,
  }) {
    return ClinicDetailsReponseDto(
      clinicaID: clinicaID ?? this.clinicaID,
      colorAccent: colorAccent ?? this.colorAccent,
      colorBackground: colorBackground ?? this.colorBackground,
      colorPrimary: colorPrimary ?? this.colorPrimary,
      descrizione: descrizione ?? this.descrizione,
      logo: logo ?? this.logo,
      nome: nome ?? this.nome,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clinicaID': clinicaID,
      'colorAccent': colorAccent,
      'colorBackground': colorBackground,
      'colorPrimary': colorPrimary,
      'descrizione': descrizione,
      'logo': logo,
      'nome': nome,
      'status': status,
    };
  }

  factory ClinicDetailsReponseDto.fromMap(Map<String, dynamic> map) {
    return ClinicDetailsReponseDto(
      clinicaID: map['clinicaID'] as String,
      colorAccent: map['colorAccent'] as String,
      colorBackground: map['colorBackground'] as String,
      colorPrimary: map['colorPrimary'] as String,
      descrizione: map['descrizione'] as String,
      logo: map['logo'] as String,
      nome: map['nome'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicDetailsReponseDto.fromJson(String source) =>
      ClinicDetailsReponseDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClinicDetailsReponseDto(clinicaID: $clinicaID, colorAccent: $colorAccent, colorBackground: $colorBackground, colorPrimary: $colorPrimary, descrizione: $descrizione, logo: $logo, nome: $nome, status: $status)';
  }

  @override
  bool operator ==(covariant ClinicDetailsReponseDto other) {
    if (identical(this, other)) return true;

    return other.clinicaID == clinicaID &&
        other.colorAccent == colorAccent &&
        other.colorBackground == colorBackground &&
        other.colorPrimary == colorPrimary &&
        other.descrizione == descrizione &&
        other.logo == logo &&
        other.nome == nome &&
        other.status == status;
  }

  @override
  int get hashCode {
    return clinicaID.hashCode ^
        colorAccent.hashCode ^
        colorBackground.hashCode ^
        colorPrimary.hashCode ^
        descrizione.hashCode ^
        logo.hashCode ^
        nome.hashCode ^
        status.hashCode;
  }
}
