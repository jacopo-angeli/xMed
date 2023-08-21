part of 'documents_cubit.dart';

abstract class DocumentsListState {
  final List<Document> documentList;
  const DocumentsListState({required this.documentList});
}

class EmptyDocumentsListState extends DocumentsListState {
  EmptyDocumentsListState() : super(documentList: []);
}

class DocumentsListSynchingState extends DocumentsListState {
  DocumentsListSynchingState({required super.documentList});
}

class DocumentsListFullState extends DocumentsListState {
  DocumentsListFullState({required super.documentList});
}
