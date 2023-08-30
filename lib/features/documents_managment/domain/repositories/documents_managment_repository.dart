import 'package:dartz/dartz.dart';
import '../entities/Document.dart';
import '../../../../core/error_handling/failures.dart';

abstract class DocumentsManagmentRepository {
  Future<Either<FailureEntity, Map<int, Document>>> getLocalDocuments(
      {required int idClinica});

  Future<Either<FailureEntity, Map<int, Document>>> getRemoteDocuments(
      {required int idClinica});

  Future<Either<FailureEntity, void>> documentUpload(
      {required int idClinica, required Document document});

  Future<Either<FailureEntity, void>> documentDowload(
      {required int idDocumento,
      required int idClinica,
      required Document remoteDocument});

  Future<Either<FailureEntity, void>> documentDelete(
      {required int idDocumento, required int idClinica});

  Future<Either<FailureEntity, void>> clearCache({required int idClinica});
  Future<void> clearDevice({required int idClinica});
}
