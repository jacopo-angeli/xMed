// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Document extends Equatable {
  final int institute = 2272;
  // INFO DOCUMENTO
  final DateTime created;
  final int idClinica;
  final int idDocumento;
  final String nome;
  final String descrizione;
  final String status;
  // TODO Aggiungere status agli enum

  // CONTENUTO DOCUMENTO
  final String content;
  final List<String> markersMedico;
  final List<String> markersPaziente;

  const Document({
    required this.created,
    required this.idClinica,
    required this.idDocumento,
    required this.nome,
    required this.descrizione,
    required this.status,
    required this.content,
    required this.markersMedico,
    required this.markersPaziente,
  });

  Document copyWith({
    DateTime? created,
    int? idClinica,
    int? idDocumento,
    String? nome,
    String? descrizione,
    String? status,
    String? content,
    List<String>? markersMedico,
    List<String>? markersPaziente,
  }) {
    return Document(
      created: created ?? this.created,
      idClinica: idClinica ?? this.idClinica,
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
      'created': created.millisecondsSinceEpoch,
      'idClinica': idClinica,
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
    return Document(
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      idClinica: map['idClinica'] as int,
      idDocumento: map['idDocumento'] as int,
      nome: map['nome'] as String,
      descrizione: map['descrizione'] as String,
      status: map['status'] as String,
      content: map['content'] as String,
      markersMedico: List<String>.from((map['markersMedico'] as List<String>)),
      markersPaziente:
          List<String>.from((map['markersPaziente'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      created,
      idClinica,
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
