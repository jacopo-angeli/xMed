import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DocumentDownloadResponseDto {
  final Body body;
  DocumentDownloadResponseDto({
    required this.body,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body.toMap(),
    };
  }

  factory DocumentDownloadResponseDto.fromMap(Map<String, dynamic> map) {
    return DocumentDownloadResponseDto(
      body: Body.fromMap(map['output']['body'] as Map<String, dynamic>),
    );
  }
}

class Body {
  // "content": "string",
  // "dataDocumento": "2023-08-28T08:19:19.710Z",
  // "descrizione": "string",
  // "idClinica": 0,
  // "idDocumento": 0,
  // "markersMedico": [
  // "string"
  // ],
  // "markersPaziente": [
  // "string"
  // ],
  // "nome": "string",
  // "status": "string"
  final String content;
  final String dataDocumento;
  final String descrizione;
  final int idClinica;
  final int idDocumento;
  final List<String> markersMedico;
  final List<String> markersPaziente;
  final String nome;
  final String status;
  Body({
    required this.content,
    required this.dataDocumento,
    required this.descrizione,
    required this.idClinica,
    required this.idDocumento,
    required this.markersMedico,
    required this.markersPaziente,
    required this.nome,
    required this.status,
  });

  Body copyWith({
    String? content,
    String? dataDocumento,
    String? descrizione,
    int? idClinica,
    int? idDocumento,
    List<String>? markersMedico,
    List<String>? markersPaziente,
    String? nome,
    String? status,
  }) {
    return Body(
      content: content ?? this.content,
      dataDocumento: dataDocumento ?? this.dataDocumento,
      descrizione: descrizione ?? this.descrizione,
      idClinica: idClinica ?? this.idClinica,
      idDocumento: idDocumento ?? this.idDocumento,
      markersMedico: markersMedico ?? this.markersMedico,
      markersPaziente: markersPaziente ?? this.markersPaziente,
      nome: nome ?? this.nome,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'dataDocumento': dataDocumento,
      'descrizione': descrizione,
      'idClinica': idClinica,
      'idDocumento': idDocumento,
      'markersMedico': markersMedico,
      'markersPaziente': markersPaziente,
      'nome': nome,
      'status': status,
    };
  }

  factory Body.fromMap(Map<String, dynamic> map) {
    return Body(
      content: map['content'] as String,
      dataDocumento: map['dataDocumento'] as String,
      descrizione: map['descrizione'] as String,
      idClinica: map['idClinica'] as int,
      idDocumento: map['idDocumento'] as int,
      markersMedico: List<String>.from((map['markersMedico'] as List<dynamic>)),
      markersPaziente:
          List<String>.from((map['markersPaziente'] as List<dynamic>)),
      nome: map['nome'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Body.fromJson(String source) =>
      Body.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Body(content: $content, dataDocumento: $dataDocumento, descrizione: $descrizione, idClinica: $idClinica, idDocumento: $idDocumento, markersMedico: $markersMedico, markersPaziente: $markersPaziente, nome: $nome, status: $status)';
  }

  @override
  bool operator ==(covariant Body other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.dataDocumento == dataDocumento &&
        other.descrizione == descrizione &&
        other.idClinica == idClinica &&
        other.idDocumento == idDocumento &&
        listEquals(other.markersMedico, markersMedico) &&
        listEquals(other.markersPaziente, markersPaziente) &&
        other.nome == nome &&
        other.status == status;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        dataDocumento.hashCode ^
        descrizione.hashCode ^
        idClinica.hashCode ^
        idDocumento.hashCode ^
        markersMedico.hashCode ^
        markersPaziente.hashCode ^
        nome.hashCode ^
        status.hashCode;
  }
}
