// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class XmedTheme extends Equatable {
  // "clinicaID": "string",
  //     "colorAccent": "string",
  //     "colorBackground": "string",
  //     "colorPrimary": "string",
  //     "descrizione": "string",
  //     "logo": "string",
  //     "nome": "string",
  //     "status": "string"
  final String status;
  final String? clinicaID;
  final String nome;
  final String descrizione;
  final String logo;
  final String colorPrimary;
  final String colorAccent;
  final String colorBackground;
  const XmedTheme({
    required this.status,
    required this.clinicaID,
    required this.nome,
    required this.descrizione,
    required this.logo,
    required this.colorPrimary,
    required this.colorAccent,
    required this.colorBackground,
  });

  static Future<XmedTheme> getDefaultTheme() async => XmedTheme.fromJson(
      await rootBundle.loadString('assets/defaultTheme.json'));

  XmedTheme copyWith({
    String? status,
    String? clinicaID,
    String? nome,
    String? descrizione,
    String? logoContentType,
    String? logo,
    String? logoSize,
    String? colorPrimary,
    String? colorAccent,
    String? colorBackground,
  }) {
    return XmedTheme(
      status: status ?? this.status,
      clinicaID: clinicaID ?? this.clinicaID,
      nome: nome ?? this.nome,
      descrizione: descrizione ?? this.descrizione,
      logo: logo ?? this.logo,
      colorPrimary: colorPrimary ?? this.colorPrimary,
      colorAccent: colorAccent ?? this.colorAccent,
      colorBackground: colorBackground ?? this.colorBackground,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'clinicaID': clinicaID,
      'nome': nome,
      'descrizione': descrizione,
      'logo': logo,
      'colorPrimary': colorPrimary,
      'colorAccent': colorAccent,
      'colorBackground': colorBackground,
    };
  }

  factory XmedTheme.fromMap(Map<String, dynamic> map) {
    return XmedTheme(
      status: map['status'] as String,
      logo: map['logo'] as String,
      colorPrimary: map['colorPrimary'] as String,
      colorAccent: map['colorAccent'] as String,
      colorBackground: map['colorBackground'] as String,
      clinicaID: map['clinicaID'] as String,
      nome: map['nome'] as String,
      descrizione: map['descrizione'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory XmedTheme.fromJson(String source) =>
      XmedTheme.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      status,
      clinicaID,
      nome,
      descrizione,
      logo,
      colorPrimary,
      colorAccent,
      colorBackground,
    ];
  }
}
