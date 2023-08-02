import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class PromoCode extends Equatable {
  final int? clinicID;
  final String? status;
  final ByteData? fileLicense;
  final String? fileLicenseContentType;
  final String? fileLicenseName;
  final int? fileLicenseSize;

  const PromoCode(
      {required this.clinicID,
      required this.status,
      required this.fileLicense,
      this.fileLicenseContentType,
      this.fileLicenseName,
      this.fileLicenseSize});

  @override
  List<Object?> get props => [
        clinicID,
        status,
        fileLicense,
        fileLicenseContentType,
        fileLicenseName,
        fileLicenseSize
      ];
}
