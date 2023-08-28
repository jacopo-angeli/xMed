import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/documents_managment/data/models/document_upload/document_upload_request_dto.dart';

import 'package:xmed/features/documents_managment/domain/entities/Document.dart';
import '../../../../utils/constants/strings.dart';
import '../../../../core/network/http_custom_client.dart';
import '../../domain/repositories/documents_managment_repository.dart';
import '../models/document_search/document_search_request_dto.dart';
import '../models/document_search/document_search_response_dto.dart';
import '../models/document_upload/document_upload_response.dart';

class DocumentsManagmentRepositoryImpl implements DocumentsManagmentRepository {
  @override
  Future<Either<FailureEntity, List<Document>>> documentSearch(
      {required int idClinica}) async {
    final requestBody = DocumentSearchRequestDto(
        fromDate: DateTime.fromMicrosecondsSinceEpoch(1490000000000),
        toDate: DateTime.now(),
        idClinica: idClinica,
        status: 'DA_FIRMARE');

    print(requestBody);

    HttpCustomClient client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    late Response response;
    try {
      response = await client.post(documentoClinicaSearch);
    } on Exception {
      return const Left(ServerFailure());
    }
    late DocumentSearchResponseDto data;
    try {
      data = DocumentSearchResponseDto.fromMap(response.data);
    } on Exception {
      return const Left(ServerFailure());
    }
    //CASO IN CUI DEVO COMPORRE LA LISTA DI DOCUMENTI
    print("DOCUMENTI RECUPERATI" + data.body.documenti.toString());

    final List<Document> documents = List.empty();
    documents.add(Document.fromMap(data.body.documenti));
    return Right(documents);
  }

  @override
  Future<Either<FailureEntity, void>> documentUpload(
      {required int idClinica, required Document document}) async {
    final DocumentUploadRequestDto requestBody =
        DocumentUploadRequestDto.fromMap(document.toMap());

    // HTTP CLIENT DEFINITION
    final client = HttpCustomClient();
    await client.initialize(requestBody.toMap());

    late Response dioResponse;
    try {
      dioResponse = await client.post('/documentUpload');
    } on Exception {
      return const Left(DocumentUploadFailure());
    }
    if (dioResponse.statusCode != 200) {
      return const Left(DocumentUploadFailure());
    }
    late DocumentUploadResponseDto data;
    try {
      data = DocumentUploadResponseDto.fromMap(dioResponse.data);
    } on Exception {
      return Left(DocumentUploadFailure());
    }
    return const Right(null);
  }
}
