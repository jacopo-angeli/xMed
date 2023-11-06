import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/documents_managment/domain/repositories/namirial_documents_repository.dart';

class NamirialSDKDocumentsRepositoryImpl
    implements NamirialSDKDocumentsRepository {
  final _viewerChannel = const MethodChannel('cwbi/viewer');
  @override
  Future<Either<FailureEntity, void>> startWizard(
      {required String pdfFile,
      required List<String>? signatureFields,
      required bool partialSigning,
      required String callBackOption,
      required String idDocumento}) async {
    try {
      final int result = await _viewerChannel.invokeMethod('startWizard', {
        'pdfFile': pdfFile,
        'signatureFields': signatureFields,
        'partialSigning': partialSigning,
        'callBackOption': callBackOption,
        'idDocumento': idDocumento
      });
      debugPrint("RISULTATO WIZARD : $result");
      return const Right(null);
    } on PlatformException catch (exception, stacktrace) {
      debugPrint("ERRORE DURANTE LA FIRMA SDK");
      return (const Left(FailedSigningAttempt()));
    }
  }
}
