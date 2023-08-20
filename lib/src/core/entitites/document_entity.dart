// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class DocumentEntity {
  int clinicID;
  String status;
  String documentID;
  String name;
  String description;
  String originalFileContentType;
  String originalFileName;
  int originalFileSize;
  List<String> markerPazienteList;
  List<String> markerMedicoList;
  List<String> markerCheckboxList;
  DateTime dataDocumento;
  DateTime dataFirma;
  DocumentEntity({
    required this.clinicID,
    required this.status,
    required this.documentID,
    required this.name,
    required this.description,
    required this.originalFileContentType,
    required this.originalFileName,
    required this.originalFileSize,
    required this.markerPazienteList,
    required this.markerMedicoList,
    required this.markerCheckboxList,
    required this.dataDocumento,
    required this.dataFirma,
  });

  DocumentEntity copyWith({
    int? clinicID,
    String? status,
    String? documentID,
    String? name,
    String? description,
    String? originalFileContentType,
    String? originalFileName,
    int? originalFileSize,
    List<String>? markerPazienteList,
    List<String>? markerMedicoList,
    List<String>? markerCheckboxList,
    DateTime? dataDocumento,
    DateTime? dataFirma,
  }) {
    return DocumentEntity(
      clinicID: clinicID ?? this.clinicID,
      status: status ?? this.status,
      documentID: documentID ?? this.documentID,
      name: name ?? this.name,
      description: description ?? this.description,
      originalFileContentType:
          originalFileContentType ?? this.originalFileContentType,
      originalFileName: originalFileName ?? this.originalFileName,
      originalFileSize: originalFileSize ?? this.originalFileSize,
      markerPazienteList: markerPazienteList ?? this.markerPazienteList,
      markerMedicoList: markerMedicoList ?? this.markerMedicoList,
      markerCheckboxList: markerCheckboxList ?? this.markerCheckboxList,
      dataDocumento: dataDocumento ?? this.dataDocumento,
      dataFirma: dataFirma ?? this.dataFirma,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clinicID': clinicID,
      'status': status,
      'documentID': documentID,
      'name': name,
      'description': description,
      'originalFileContentType': originalFileContentType,
      'originalFileName': originalFileName,
      'originalFileSize': originalFileSize,
      'markerPazienteList': markerPazienteList,
      'markerMedicoList': markerMedicoList,
      'markerCheckboxList': markerCheckboxList,
      'dataDocumento': dataDocumento.millisecondsSinceEpoch,
      'dataFirma': dataFirma.millisecondsSinceEpoch,
    };
  }

  factory DocumentEntity.fromMap(Map<String, dynamic> map) {
    return DocumentEntity(
      clinicID: map['clinicID'] as int,
      status: map['status'] as String,
      documentID: map['documentID'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      originalFileContentType: map['originalFileContentType'] as String,
      originalFileName: map['originalFileName'] as String,
      originalFileSize: map['originalFileSize'] as int,
      markerPazienteList:
          List<String>.from((map['markerPazienteList'] as List<String>)),
      markerMedicoList:
          List<String>.from((map['markerMedicoList'] as List<String>)),
      markerCheckboxList:
          List<String>.from((map['markerCheckboxList'] as List<String>)),
      dataDocumento:
          DateTime.fromMillisecondsSinceEpoch(map['dataDocumento'] as int),
      dataFirma: DateTime.fromMillisecondsSinceEpoch(map['dataFirma'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentEntity.fromJson(String source) =>
      DocumentEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocumentEntity(clinicID: $clinicID, status: $status, documentID: $documentID, name: $name, description: $description, originalFileContentType: $originalFileContentType, originalFileName: $originalFileName, originalFileSize: $originalFileSize, markerPazienteList: $markerPazienteList, markerMedicoList: $markerMedicoList, markerCheckboxList: $markerCheckboxList, dataDocumento: $dataDocumento, dataFirma: $dataFirma)';
  }

  @override
  bool operator ==(covariant DocumentEntity other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.clinicID == clinicID &&
        other.status == status &&
        other.documentID == documentID &&
        other.name == name &&
        other.description == description &&
        other.originalFileContentType == originalFileContentType &&
        other.originalFileName == originalFileName &&
        other.originalFileSize == originalFileSize &&
        listEquals(other.markerPazienteList, markerPazienteList) &&
        listEquals(other.markerMedicoList, markerMedicoList) &&
        listEquals(other.markerCheckboxList, markerCheckboxList) &&
        other.dataDocumento == dataDocumento &&
        other.dataFirma == dataFirma;
  }

  @override
  int get hashCode {
    return clinicID.hashCode ^
        status.hashCode ^
        documentID.hashCode ^
        name.hashCode ^
        description.hashCode ^
        originalFileContentType.hashCode ^
        originalFileName.hashCode ^
        originalFileSize.hashCode ^
        markerPazienteList.hashCode ^
        markerMedicoList.hashCode ^
        markerCheckboxList.hashCode ^
        dataDocumento.hashCode ^
        dataFirma.hashCode;
  }
}
