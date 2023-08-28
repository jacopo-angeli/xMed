// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/documents_managment/domain/repositories/documents_managment_repository.dart';

import '../../../../login/domain/entities/user.dart';
import '../../../domain/entities/Document.dart';

part 'documents_state.dart';

// Creato dopo aver effettuato il login
class DocumentsListCubit extends Cubit<DocumentsListState> {
  // REPOSITORY DECLARATION
  DocumentsManagmentRepository documentsRepository;
  // USER DECLARATION
  User currentUser;
  DocumentsListCubit(
      {required this.documentsRepository, required this.currentUser})
      : super(EmptyDocumentsListState());

  void onInit() async {
    emit(DocumentsListSynchingState(documentList: []));
    List<Document> documentList = [
      Document(
          created: DateTime.now(),
          idClinica: 1,
          idDocumento: 1,
          nome: 'nome',
          descrizione: 'descrizione',
          status: 'DA_FIRMARE',
          content: 'content',
          markersMedico: ['markersMedico'],
          markersPaziente: ['markersPaziente']),
      Document(
          created: DateTime.now(),
          idClinica: 1,
          idDocumento: 1,
          nome: 'nome1',
          descrizione: 'descrizione1',
          status: 'DA_FIRMARE',
          content: 'content',
          markersMedico: ['markersMedico'],
          markersPaziente: ['markersPaziente']),
      Document(
          created: DateTime.now(),
          idClinica: 1,
          idDocumento: 1,
          nome: 'nome2',
          descrizione: 'descrizione2',
          status: 'FIRMATO_PAZIENTE',
          content: 'content',
          markersMedico: ['markersMedico'],
          markersPaziente: ['markersPaziente']),
      Document(
          created: DateTime.now(),
          idClinica: 1,
          idDocumento: 1,
          nome: 'nome3',
          descrizione: 'descrizione3',
          status: 'FIRMATO_MEDICO',
          content: 'content',
          markersMedico: ['markersMedico'],
          markersPaziente: ['markersPaziente']),
      Document(
          created: DateTime.now(),
          idClinica: 1,
          idDocumento: 1,
          nome: 'nome4',
          descrizione: 'descrizione4',
          status: 'FIRMATO',
          content: 'content',
          markersMedico: ['markersMedico'],
          markersPaziente: ['markersPaziente']),
      Document(
          created: DateTime.now(),
          idClinica: 1,
          idDocumento: 1,
          nome: 'nome5',
          descrizione: 'descrizione5',
          status: 'FIRMATO_PAZIENTE',
          content: 'content',
          markersMedico: ['markersMedico'],
          markersPaziente: ['markersPaziente']),
      Document(
          created: DateTime.now(),
          idClinica: 1,
          idDocumento: 1,
          nome: 'nome6',
          descrizione: 'descrizione6',
          status: 'DA_FIRMARE',
          content: 'content',
          markersMedico: ['markersMedico'],
          markersPaziente: ['markersPaziente']),
      Document(
          created: DateTime.now(),
          idClinica: 1,
          idDocumento: 1,
          nome: 'nome7',
          descrizione: 'descrizione7',
          status: 'FIRMATO',
          content: 'content',
          markersMedico: ['markersMedico'],
          markersPaziente: ['markersPaziente']),
    ];
    // emit(DocumentsListSynchingState(documentList: documentList));
    // Funzione che viene chiamata prima di ogni modifica attiva e al login dell'utente
    // Reucupero tutti i documenti presenti in remoto e li confronto con quelli presenti in lastDocumentList
    // DOCUMENTI ANNULLATI (Trovo dei documenti con status ANNULLATO nella backoffice e con status diverso in locale)
    //  Elimino il documento in locale (se è presente)
    //  Elimino il documento dalla nuova lista di documenti
    // DOCUMENTI NON PRESENTI IN LOCALE MA IN REMOTO
    // * Cerco solo documenti con stato DA_FIRMARE
    //  Aggiorno la lista di documenti con i documenti presenti in remoto (con cached = false)

    // TENTATIVO DI RECUPERO DEI FILE DAL BACKOFFICE
    Either<FailureEntity, List<Document>> documentsListRetrieveAttempt =
        await documentsRepository.documentSearch(
            idClinica: currentUser.idClinica);

    documentsListRetrieveAttempt.fold((l) {}, (r) {});
    emit(DocumentsListFullState(documentList: documentList));
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
