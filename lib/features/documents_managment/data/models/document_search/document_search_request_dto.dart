// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class DocumentSearchRequestDto {
  // Mandatory
  final DateTime fromDate;
  final DateTime toDate;
  final int idClinica;
  final int institute = 2272;
  final String status;

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
    String? status,
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
      'input': <String, dynamic>{
        'fromDate': DateFormat("yyyy-MM-ddTHH:mm:ssZ").format(fromDate),
        'idClinica': idClinica,
        'institute': institute,
        'status': status.toString(),
        'toDate': DateFormat("yyyy-MM-ddTHH:mm:ssZ").format(toDate),
      }
    };
  }

  factory DocumentSearchRequestDto.fromMap(Map<String, dynamic> map) {
    return DocumentSearchRequestDto(
      fromDate: DateTime.fromMillisecondsSinceEpoch(map['fromDate'] as int),
      toDate: DateTime.fromMillisecondsSinceEpoch(map['toDate'] as int),
      idClinica: map['idClinica'] as int,
      status: map['status'] as String,
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
