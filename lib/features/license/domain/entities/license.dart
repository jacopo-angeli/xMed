// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class License extends Equatable {
  final int idClinica;
  final int IdPromoCode;
  final Map<String, dynamic> NamirialLicense;
  final String content;
  final String status;
  const License({
    required this.idClinica,
    required this.IdPromoCode,
    required this.NamirialLicense,
    required this.content,
    required this.status,
  });

  License copyWith({
    int? idClinica,
    int? IdPromoCode,
    Map<String, dynamic>? NamirialLicense,
    String? content,
    String? status,
  }) {
    return License(
      idClinica: idClinica ?? this.idClinica,
      IdPromoCode: IdPromoCode ?? this.IdPromoCode,
      NamirialLicense: NamirialLicense ?? this.NamirialLicense,
      content: content ?? this.content,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idClinica': idClinica,
      'IdPromoCode': IdPromoCode,
      'NamirialLicense': NamirialLicense,
      'content': content,
      'status': status,
    };
  }

  factory License.fromMap(Map<String, dynamic> map) {
    return License(
      idClinica: map['idClinica'] as int,
      IdPromoCode: map['IdPromoCode'] as int,
      NamirialLicense: Map<String, dynamic>.from(
          (map['NamirialLicense'] as Map<String, dynamic>)),
      content: map['content'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory License.fromJson(String source) =>
      License.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      idClinica,
      IdPromoCode,
      NamirialLicense,
      content,
      status,
    ];
  }
}
