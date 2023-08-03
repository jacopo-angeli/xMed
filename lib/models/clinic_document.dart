import 'package:equatable/equatable.dart';

class Document extends Equatable {
  final int? clinicID;
  final String? status;
  final String? documentID;
  final String? name;
  final String? description;

  final String? originalFileContentType;
  final String? originalFileName;
  final int? originalFileSize;

  // Namirial data
  final List<String>? markerPazienteList;
  final List<String>? markerMedicoList;
  final List<String>? markerCheckboxList;

  final DateTime dataDocumento;
  final DateTime dataFirma;

  const Document(
      {required this.clinicID,
      required this.status,
      required this.documentID,
      required this.name,
      required this.description,
      this.originalFileContentType,
      this.originalFileName,
      this.originalFileSize,
      this.markerPazienteList,
      this.markerMedicoList,
      this.markerCheckboxList,
      required this.dataDocumento,
      required this.dataFirma});

  @override
  List<Object?> get props => [
        clinicID,
        status,
        documentID,
        name,
        description,
        originalFileContentType,
        originalFileName,
        originalFileSize,
        markerPazienteList,
        markerMedicoList,
        markerCheckboxList,
        dataDocumento,
        dataFirma
      ];
}
