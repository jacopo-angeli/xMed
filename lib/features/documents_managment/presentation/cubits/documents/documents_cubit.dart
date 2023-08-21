import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/enitites/Document.dart';

part 'documents_state.dart';

// Creato dopo aver effettuato il login
class DocumentsListCubit extends Cubit<DocumentsListState> {
  DocumentsListCubit() : super(EmptyDocumentsListState());

  void sync(List<Document> lastDocumentsList) {
    emit(DocumentsListSynchingState(documentList: lastDocumentsList));
    // Funzione che viene chiamata prima di ogni modifica attiva e al login dell'utente
    // Reucupero tutti i documenti presenti in remoto e li confronto con quelli presenti in lastDocumentList
    // DOCUMENTI ANNULLATI (Trovo dei documenti con status ANNULLATO nella backoffice e con status diverso in locale)
    //  Elimino il documento in locale (se è presente)
    //  Elimino il documento dalla nuova lista di documenti
    // DOCUMENTI NON PRESENTI IN LOCALE MA IN REMOTO
    // * Cerco solo documenti con stato DA_FIRMARE
    //  Aggiorno la lista di documenti con i documenti presenti in remoto (con cached = false)
    // TODO Impl con  integrazione con internet cubit
    emit(EmptyDocumentsListState());
  }

  void documentChanged(
      List<Document> lastDocumentsList, Document documentChanged) {
    // Chiamata quando l'utente effettua una modifica ATTIVA alla lista di documenti
    //
    // Aggiorno lastDocumentsList con le modifiche apportate
    // Aggiorno il backoffice
    // Possibili modifiche
    //  DOWNLOAD DEL DOCUMENTO
    //    lo noto se il documento ha ora cached = true
    //    salvataggio del documento in locale
    //    aggiornamento della corrente lista di documenti
    //  FIRMA DEL DOCUMENTO
    //    FIRMA DEL MEDICO
    //      Content modificato e status passa a FIRMATO_MEDICO O FIRMATO
    //    FIRMA DEL PAZIENTE
    //      Content modificato e status passa a FIRMATO_PAZIENTE O FIRMATO
    //  UPLOAD DEL DOCUMENTO
    //    da cached a !cached
    //    tento di caricare il documento in remoto,
    //    se tutto va a buon fine lo elimino dal locale
    // TODO Impl
    List<Document> updatedDocumentsList = lastDocumentsList;
    emit(DocumentsListFullState(documentList: updatedDocumentsList));
  }
}
