// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DocumentUploadRequestDto {
  final String? content;
  final String? dataFirma;
  final int? idClinica;
  final int? idDocumento;
  DocumentUploadRequestDto({
    this.content,
    this.dataFirma,
    this.idClinica,
    this.idDocumento,
  });
  final int? institute = 2272;

  DocumentUploadRequestDto copyWith({
    String? content,
    String? dataFirma,
    int? idClinica,
    int? idDocumento,
  }) {
    return DocumentUploadRequestDto(
      content: content ?? this.content,
      dataFirma: dataFirma ?? this.dataFirma,
      idClinica: idClinica ?? this.idClinica,
      idDocumento: idDocumento ?? this.idDocumento,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "input": <String, dynamic>{
        'content': content,
        'dataFirma': dataFirma,
        'idClinica': idClinica,
        'idDocumento': idDocumento,
        'institute': institute,
      }
    };
  }

  factory DocumentUploadRequestDto.fromMap(Map<String, dynamic> map) {
    return DocumentUploadRequestDto(
      content: map['content'] != null ? map['content'] as String : null,
      dataFirma: map['dataFirma'] != null ? map['dataFirma'] as String : null,
      idClinica: map['idClinica'] != null ? map['idClinica'] as int : null,
      idDocumento:
          map['idDocumento'] != null ? map['idDocumento'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentUploadRequestDto.fromJson(String source) =>
      DocumentUploadRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocumentUploadRequestDto(content: $content, dataFirma: $dataFirma, idClinica: $idClinica, idDocumento: $idDocumento)';
  }

  @override
  bool operator ==(covariant DocumentUploadRequestDto other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.dataFirma == dataFirma &&
        other.idClinica == idClinica &&
        other.idDocumento == idDocumento;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        dataFirma.hashCode ^
        idClinica.hashCode ^
        idDocumento.hashCode;
  }
}
