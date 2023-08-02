part of 'document_bloc.dart';

abstract class DocumentState {
  final Document document;

  DocumentState({required this.document});
}

class DocumentLocalState extends DocumentState {
  DocumentLocalState({required super.document});
}

class DocumentRemoteState extends DocumentState {
  DocumentRemoteState({required super.document});
}

class DocumentUploadingState extends DocumentState {
  DocumentUploadingState({required super.document});
}

class DocumentDownloadingState extends DocumentState {
  DocumentDownloadingState({required super.document});
}
