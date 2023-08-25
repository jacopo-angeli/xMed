// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class XmedTheme extends Equatable {
  final String status;
  final String clinicID;
  final String name;
  final String description;
  final String logoContentType;
  final String logoContent;
  final String logoSize;
  final String colorPrimary;
  final String colorAccent;
  final String colorBackground;
  const XmedTheme({
    required this.status,
    required this.clinicID,
    required this.name,
    required this.description,
    required this.logoContentType,
    required this.logoContent,
    required this.logoSize,
    required this.colorPrimary,
    required this.colorAccent,
    required this.colorBackground,
  });

  factory XmedTheme.defaultTheme() => const XmedTheme(
      status: "status",
      clinicID: "clinicID",
      name: "name",
      description: "description",
      logoContentType: "logoContentType",
      logoContent: "logoContent",
      logoSize: "logoSize",
      colorPrimary: "colorPrimary",
      colorAccent: "colorAccent",
      colorBackground: "colorBackground");

  XmedTheme copyWith({
    String? status,
    String? clinicID,
    String? name,
    String? description,
    String? logoContentType,
    String? logoContent,
    String? logoSize,
    String? colorPrimary,
    String? colorAccent,
    String? colorBackground,
  }) {
    return XmedTheme(
      status: status ?? this.status,
      clinicID: clinicID ?? this.clinicID,
      name: name ?? this.name,
      description: description ?? this.description,
      logoContentType: logoContentType ?? this.logoContentType,
      logoContent: logoContent ?? this.logoContent,
      logoSize: logoSize ?? this.logoSize,
      colorPrimary: colorPrimary ?? this.colorPrimary,
      colorAccent: colorAccent ?? this.colorAccent,
      colorBackground: colorBackground ?? this.colorBackground,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'clinicID': clinicID,
      'name': name,
      'description': description,
      'logoContentType': logoContentType,
      'logoContent': logoContent,
      'logoSize': logoSize,
      'colorPrimary': colorPrimary,
      'colorAccent': colorAccent,
      'colorBackground': colorBackground,
    };
  }

  factory XmedTheme.fromMap(Map<String, dynamic> map) {
    return XmedTheme(
      status: map['status'] as String,
      clinicID: map['clinicID'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      logoContentType: map['logoContentType'] as String,
      logoContent: map['logoContent'] as String,
      logoSize: map['logoSize'] as String,
      colorPrimary: map['colorPrimary'] as String,
      colorAccent: map['colorAccent'] as String,
      colorBackground: map['colorBackground'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory XmedTheme.fromJson(String source) =>
      XmedTheme.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      status,
      clinicID,
      name,
      description,
      logoContentType,
      logoContent,
      logoSize,
      colorPrimary,
      colorAccent,
      colorBackground,
    ];
  }
}
