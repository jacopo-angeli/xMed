class DocumentSearchResponseDto {
  final Body body;
  DocumentSearchResponseDto({
    required this.body,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body.toMap(),
    };
  }

  factory DocumentSearchResponseDto.fromMap(Map<String, dynamic> map) {
    return DocumentSearchResponseDto(
      body: Body.fromMap(map['output']['body'] as Map<String, dynamic>),
    );
  }
}

class Body {
  final List<dynamic> documenti;
  final int idClinica;
  Body({
    required this.documenti,
    required this.idClinica,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'documenti': documenti,
      'idClinica': idClinica,
    };
  }

  factory Body.fromMap(Map<String, dynamic> map) {
    return Body(
      documenti: map['documenti'],
      idClinica: map['idClinica'],
    );
  }
}
