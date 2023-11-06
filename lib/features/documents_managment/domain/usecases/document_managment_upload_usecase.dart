// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:xmed/features/documents_managment/domain/repositories/documents_managment_repository.dart';

import '../../../../core/error_handling/failures.dart';
import '../entities/Document.dart';

class DocumentManagmentUploadUseCase {
  final DocumentsManagmentRepository documentRepository;
  DocumentManagmentUploadUseCase({
    required this.documentRepository,
  });
  Future<Either<FailureEntity, void>> execute(
      {required String idClinica, required int idDocumento}) async {
    return await documentRepository.documentUpload(
        idClinica: idClinica, idDocumento: idDocumento);
  }
}
