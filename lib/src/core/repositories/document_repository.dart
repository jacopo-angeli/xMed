import 'dart:async';

import '../entitites/document_entity.dart';
import '../../data/models/document_download/document_download_request_dto.dart';
import '../../data/models/document_search/document_search_request_dto.dart';
import '../../data/models/document_upload/document_upload_request_dto.dart';

abstract class DocumentsRepository {
  /// Recupera tutti i documenti
  Future<List<DocumentEntity>> getAll();

  /// Ricerca parametrizzata tra i documenti
  Future<List<DocumentEntity>> searchBy(DocumentSearchRequestDto requestBody);

  /// Upload di un documento al server
  Future<void> uploadDocument(DocumentUploadRequestDto requestBody);

  Future<DocumentEntity> downloadDocument(
      DocumentDownloadRequestDto requestBody);
}
