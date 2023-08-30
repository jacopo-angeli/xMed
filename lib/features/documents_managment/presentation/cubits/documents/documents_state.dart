// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'documents_cubit.dart';

abstract class DocumentsListState {
  final Map<int, Document> documentsList;
  const DocumentsListState({required this.documentsList});
}

class DocumentsSynchingState extends DocumentsListState {
  final String currentOperation;
  DocumentsSynchingState({
    required this.currentOperation,
    required super.documentsList,
  });
}

class CompleteFailureState extends DocumentsListState {
  final String error;
  CompleteFailureState({required this.error, required super.documentsList});
}

class DocumentsSynchState extends DocumentsListState {
  DocumentsSynchState({required super.documentsList});
}
