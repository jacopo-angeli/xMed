import 'package:dartz/dartz.dart';
import 'package:xmed/core/error_handling/failures.dart';

abstract class NamirialSDKDocumentsRepository {
  Future<Either<FailureEntity, void>> startWizard(
      {required String pdfFile,
      required List<String>? signatureFields,
      required bool partialSigning,
      required String callBackOption,
      required String idDocumento});
}
