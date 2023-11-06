// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class License extends Equatable {
  final String promoCode;
  final String cert;
  final String? status;
  const License({
    required this.promoCode,
    required this.cert,
    this.status,
  });

  factory License.defaultLicense() =>
      const License(promoCode: '', cert: '', status: 'INVALID');

  License copyWith({
    String? promoCode,
    String? cert,
    String? status,
  }) {
    return License(
      promoCode: promoCode ?? this.promoCode,
      cert: cert ?? this.cert,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'promoCode': promoCode,
      'cert': cert,
      'status': status,
    };
  }

  factory License.fromMap(Map<String, dynamic> map) {
    return License(
      promoCode: map['promoCode'] as String,
      cert: map['cert'] as String,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory License.fromJson(String source) =>
      License.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [promoCode, cert, status];
}
