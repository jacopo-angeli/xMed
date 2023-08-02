import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xmed/data/model/document.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final Document document;
  DocumentBloc({required this.document})
      : super(DocumentRemoteState(document: document)) {
    on<DocumentEvent>((event, emit) {
      // TODO: okay
    });
  }
}
