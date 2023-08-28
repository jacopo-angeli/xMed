// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../utils/converters/date.dart';

class Document extends Equatable {
  final int institute = 2272;
  // INFO DOCUMENTO
  final String? dataDocumento;
  final String? dataFirma;
  final int idDocumento;
  final String nome;
  final String descrizione;
  final String status;
  // TODO Aggiungere status agli enum

  // CONTENUTO DOCUMENTO
  final String? content;
  final List<String> markersMedico;
  final List<String> markersPaziente;

  const Document({
    this.dataDocumento,
    this.dataFirma,
    this.content,
    required this.idDocumento,
    required this.nome,
    required this.descrizione,
    required this.status,
    required this.markersMedico,
    required this.markersPaziente,
  });

  Document copyWith({
    String? dataDocumento,
    String? dataFirma,
    int? idDocumento,
    String? nome,
    String? descrizione,
    String? status,
    String? content,
    List<String>? markersMedico,
    List<String>? markersPaziente,
  }) {
    return Document(
      dataDocumento: dataDocumento ?? this.dataDocumento,
      dataFirma: dataFirma ?? this.dataFirma,
      idDocumento: idDocumento ?? this.idDocumento,
      nome: nome ?? this.nome,
      descrizione: descrizione ?? this.descrizione,
      status: status ?? this.status,
      content: content ?? this.content,
      markersMedico: markersMedico ?? this.markersMedico,
      markersPaziente: markersPaziente ?? this.markersPaziente,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataDocumento': dataDocumento,
      'dataFirma': dataFirma,
      'idDocumento': idDocumento,
      'nome': nome,
      'descrizione': descrizione,
      'status': status,
      'content': content,
      'markersMedico': markersMedico,
      'markersPaziente': markersPaziente,
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    if (map['body'] != null) map = map['body'];
    return Document(
      dataDocumento:
          CWDateUtils.localDateFormatter(DateTime.parse(map['dataDocumento'])),
      dataFirma: null,
      idDocumento: map['idDocumento'] as int,
      nome: map['nome'] as String,
      descrizione: map['descrizione'] as String,
      status: map['status'] as String,
      content: map['content'] == Null ? map['content'] as String : null,
      markersMedico: List<String>.from((map['markersMedico'] as List<dynamic>)),
      markersPaziente:
          List<String>.from((map['markersPaziente'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      dataDocumento,
      dataFirma,
      idDocumento,
      nome,
      descrizione,
      status,
      content,
      markersMedico,
      markersPaziente,
    ];
  }
}
