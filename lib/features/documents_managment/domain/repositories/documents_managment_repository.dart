import 'package:dartz/dartz.dart';
import '../entities/Document.dart';
import '../../../../core/error_handling/failures.dart';

abstract class DocumentsManagmentRepository {
  Future<Either<FailureEntity, void>> documentUpload(
      {required int idClinica, required Document document});

  Future<Either<FailureEntity, List<Document>>> documentSearch(
      {required int idClinica});
}

//TODO azioni da rendere disponibili (API)
//licenza ACTIVATE: XTHUMBPRINT, INPUT:{ idClinica, IdPromoCode, institute.} OUTPUT: Body{status, messages[code,message,severity], result}
//licenza DOWNLOAD: XTHUMBPRINT INPUT: idClinica institute. OUTPUT: Body{content idClinica, idPromoCode, messages[code, message, severity], result}
