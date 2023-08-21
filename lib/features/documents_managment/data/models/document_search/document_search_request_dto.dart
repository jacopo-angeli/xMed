// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../../src/utils/costants/enums/documents_status.dart';

class DocumentSearchRequestDto {
  // Mandatory
  final DateTime fromDate;
  final DateTime toDate;
  final int idClinica;
  final int institute = 2272;
  final DocumentStatus status;

  DocumentSearchRequestDto({
    required this.fromDate,
    required this.toDate,
    required this.idClinica,
    required this.status,
  });

  DocumentSearchRequestDto copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    int? idClinica,
    DocumentStatus? status,
  }) {
    return DocumentSearchRequestDto(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      idClinica: idClinica ?? this.idClinica,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fromDate': fromDate.millisecondsSinceEpoch,
      'toDate': toDate.millisecondsSinceEpoch,
      'idClinica': idClinica,
      'status': status.toString(),
    };
  }

  factory DocumentSearchRequestDto.fromMap(Map<String, dynamic> map) {
    return DocumentSearchRequestDto(
      fromDate: DateTime.fromMillisecondsSinceEpoch(map['fromDate'] as int),
      toDate: DateTime.fromMillisecondsSinceEpoch(map['toDate'] as int),
      idClinica: map['idClinica'] as int,
      status: map['status'] as DocumentStatus,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentSearchRequestDto.fromJson(String source) =>
      DocumentSearchRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocumentSearchRequestDto(fromDate: $fromDate, toDate: $toDate, idClinica: $idClinica, status: $status)';
  }

  @override
  bool operator ==(covariant DocumentSearchRequestDto other) {
    if (identical(this, other)) return true;

    return other.fromDate == fromDate &&
        other.toDate == toDate &&
        other.idClinica == idClinica &&
        other.status == status;
  }

  @override
  int get hashCode {
    return fromDate.hashCode ^
        toDate.hashCode ^
        idClinica.hashCode ^
        status.hashCode;
  }
}
