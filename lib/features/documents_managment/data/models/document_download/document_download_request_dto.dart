// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DocumentDownloadRequestDto {
  final int idClinica;
  final int idDocumento;
  DocumentDownloadRequestDto({
    required this.idClinica,
    required this.idDocumento,
  });
  final int institute = 2272;

  DocumentDownloadRequestDto copyWith({
    int? idClinica,
    int? idDocumento,
  }) {
    return DocumentDownloadRequestDto(
      idClinica: idClinica ?? this.idClinica,
      idDocumento: idDocumento ?? this.idDocumento,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idClinica': idClinica,
      'idDocumento': idDocumento,
    };
  }

  factory DocumentDownloadRequestDto.fromMap(Map<String, dynamic> map) {
    return DocumentDownloadRequestDto(
      idClinica: map['idClinica'] as int,
      idDocumento: map['idDocumento'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentDownloadRequestDto.fromJson(String source) =>
      DocumentDownloadRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DocumentDownloadRequestDto(idClinica: $idClinica, idDocumento: $idDocumento)';

  @override
  bool operator ==(covariant DocumentDownloadRequestDto other) {
    if (identical(this, other)) return true;

    return other.idClinica == idClinica && other.idDocumento == idDocumento;
  }

  @override
  int get hashCode => idClinica.hashCode ^ idDocumento.hashCode;
}
