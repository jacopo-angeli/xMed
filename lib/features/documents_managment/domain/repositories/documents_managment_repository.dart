import 'package:dartz/dartz.dart';
import '../entities/Document.dart';
import '../../../../core/error_handling/failures.dart';

abstract class DocumentsManagmentRepository {
  Future<Either<FailureEntity, Map<int, Document>>> getLocalDocuments(
      {required String idClinica});

  Future<Either<FailureEntity, Map<int, Document>>> getRemoteDocuments(
      {required String idClinica});

  Future<Either<FailureEntity, void>> documentUpload(
      {required String idClinica, required int idDocumento});

  Future<Either<FailureEntity, void>> documentDowload(
      {required int idDocumento,
      required String idClinica,
      required Document remoteDocument});

  Future<Either<FailureEntity, void>> documentDelete(
      {required int idDocumento, required String idClinica});

  Future<Either<FailureEntity, void>> clearCache({required String idClinica});
  Future<void> clearDevice({required String idClinica});

  Future<String> getFilePath(
      {required String idDocumento, required String idClinica});

  Future<void> setDocumentStatus(
      {required String idDocumento,
      required String idClinica,
      required String status});
  Future<String> retriveDocumentFromIDs(
      {required String idClinica, required int idDocumento});
}
