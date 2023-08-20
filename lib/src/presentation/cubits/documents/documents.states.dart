part of 'documents.cubit.dart';

@immutable
abstract class DocumentsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class DocumentsSynchingState extends DocumentsState {}

final class EmptyState extends DocumentsState {}

final class FullState extends DocumentsState {
  final List<Document> documents;

  FullState({required this.documents});

  @override
  List<Object> get props => [documents];
}
