import 'package:dartz/dartz.dart';
import '../entities/Document.dart';
import '../../../../core/error_handling/failures.dart';

abstract class DocumentsManagmentRepository {
  Future<Either<FailureEntity, void>> documentUpload(
      {required int idClinica, required Document document});

  Future<Either<FailureEntity, List<Document>>> documentSearch(
      {required int idClinica});

  Future<Either<FailureEntity, Document>> documentDowload(
      {required int idDocumento,
      required int idClinica,
      required Document remoteDocument});
}
