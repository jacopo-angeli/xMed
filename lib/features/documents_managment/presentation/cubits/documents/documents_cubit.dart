import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xmed/features/documents_managment/domain/repositories/documents_managment_repository.dart';

import '../../../../../core/error_handling/failures.dart';
import '../../../../login/domain/entities/user.dart';
import '../../../domain/entities/Document.dart';

part 'documents_state.dart';

// Creato dopo aver effettuato il login
class DocumentsListCubit extends Cubit<DocumentsListState> {
  // METHOD CHANNEL PER GESTIONE RITORNO WIZARD DI FIRMA
  static const _viewerChannel = MethodChannel('cwbi/viewer');
  // REPOSITORY DECLARATION
  DocumentsManagmentRepository documentsRepository;
  // USER DECLARATION
  User currentUser;
  DocumentsListCubit(
      {required this.documentsRepository, required this.currentUser})
      : super(DocumentsSynchingState(
            documentsList: {},
            currentOperation: "Sincronizzazione dei documenti in corso...")) {
    /// QUESTA FUNZIONE VIENE CHIAMATA AL TERMINE DEL WIZARD DI FIRMA
    /// GESTISCE IL SUO RISULTATO CHE VIENE GESTITO SOLO QUANDO
    /// EQUIVALE A SIGNED O A INTERMEDIATE. IN ENTRAMBI I CASI VIENE
    /// AGGIORNATO IL CAMPO DATI status DEL FILE. MODIFICA CHE VIENE
    /// RIFLESSA AUTOMATICAMENTE NELLA VISTA.
    _viewerChannel.setMethodCallHandler((call) async {
      if (call.method == 'completeWizard') {
        // RECUPERO DEI PARAMETRI DELLA RICHIESTA
        final String status = call.arguments['status'];
        final String callBackOption = call.arguments['callBackOption'];
        final String idDocumento = call.arguments['idDocumento'];

        debugPrint(
            "STATUS = $status, CALLBACKOPTION = $callBackOption, IDDOCUMENTO = $idDocumento");

        if (status == 'SIGNED') {
          debugPrint("DOCUMENTO TOTALMENTE FIRMATO");
          debugPrint("AGGIORNAMENTO DEL SUO STATO");
          documentsRepository.setDocumentStatus(
              idDocumento: idDocumento,
              idClinica: currentUser.idClinica,
              status: "FIRMATO");
          sync();
        } else {
          // save intermediate document
          if (status == 'INTERMEDIATE') {
            debugPrint("DOCUMENTO PARZIALMENTE FIRMATO");
            if (call.arguments['callBackOption'] == 'MEDICO') {
              debugPrint("FIRMATO DA MEDICO");
              documentsRepository.setDocumentStatus(
                  idDocumento: idDocumento,
                  idClinica: currentUser.idClinica,
                  status: "FIRMATO_MEDICO");
              sync();
            }
            if (callBackOption == 'PAZIENTE') {
              debugPrint("FIRMATO DA PAZIENTE");
              documentsRepository.setDocumentStatus(
                  idDocumento: idDocumento,
                  idClinica: currentUser.idClinica,
                  status: "FIRMATO_PAZIENTE");
              sync();
            }
          }
        }
      }
    });
  }

  Future<void> sync() async {
    emit(DocumentsSynchingState(
        currentOperation: "Recupero i documenti dal dispositivo",
        documentsList: state.documentsList));

    // ELIMINO TUTTI I DOCUMENTI CHE SONO PRESENTI NEL DISPOSITIVO
    // MA CHE NON SONO DELLA CLINICA DELL'UTENTE CORRENTE
    documentsRepository.clearDevice(idClinica: currentUser.idClinica);

    await Future.delayed(Duration(seconds: 1));

    // RECUPERO TUTTI I DOCUMENTI PRESENTI IN LOCALE
    Either<FailureEntity, Map<int, Document>> localDocumentsRetrieveAttempt =
        await documentsRepository.getLocalDocuments(
            idClinica: currentUser.idClinica);

    // TODO : TABLET PASSA A SECONDA CLINICA

    // GESTIONE DEL RISULTATO
    localDocumentsRetrieveAttempt.fold((failure) {
      // NESSUN DOCUMENTO RECUPERATO
      debugPrint("ERRORE NEL RECUPERO DEI FILE LOCALI");
      // NOTIFICARE L'UTENTE
      emit(CompleteFailureState(
          error: 'Fail completo nel recupero dei file locali',
          documentsList: {}));
    }, (localDocumentsMap) async {
      debugPrint(
          "RECUPERATI ${localDocumentsMap.length} DOCUMENTI DAL DISPOSITIVO");
      emit(DocumentsSynchingState(
          currentOperation:
              "Recuperati ${localDocumentsMap.length} documenti dal dispositivo...",
          documentsList: state.documentsList));
      debugPrint("RECUPERO I DOCUMENTI DA REMOTO");
      emit(DocumentsSynchingState(
          currentOperation: "Sincronizzazione con il server",
          documentsList: state.documentsList));

      // RECUPERO DOCUMENTI DA REMOTO
      Either<FailureEntity, Map<int, Document>> remoteDocumentsRetrieveAttempt =
          await documentsRepository.getRemoteDocuments(
              idClinica: currentUser.idClinica);

      // GESTIONE DEL RISULTATO DELLA CHIAMATA
      remoteDocumentsRetrieveAttempt.fold((failure) {
        debugPrint("ERRORE NEL RECUPERO DEI DOCUMENTI REMOTI");
        // TODO
        // Quando non posso scaricare i documenti da remoto? => quando non sono connesso ad internet, ma in tal caso non va male anche la login?
        // Se errore dovuto ad internet cubit devo handlare l'evento in maniera separata
        // Se errore dovuto a problemi di backend devo bestemmiare anche più forte
      }, (remoteDocumentsMap) async {
        debugPrint(
            "RECUPERATI ${remoteDocumentsMap.length} DOCUMENTI DAL SERVER");
        emit(DocumentsSynchingState(
            currentOperation:
                "Recuperati ${remoteDocumentsMap.length} documenti dal server. Sincronizzazione con documenti locali.",
            documentsList: state.documentsList));

        // CONFRONTO DOCUMENTI REMOTI CON DOCUMENTI LOCALI
        // POSSIBILITà:
        // DOCUMENTO PRESENTE SOLO IN REMOTO => SCARICO IL DOCUMENTO
        // DOCUMENTO PRESENTE SOLO IN LOCALE (GIà FIRMATO DA ALTRI) => ELIMINAZIONE DEL DOCUMENTO DA DISPOSITIVO + VALUTARE SE NOTIFICARE L'OPERATORE

        // CONSIDERANDO CHE IL DOCUMENTO NON PUò SUBIRE MODIFICHE, PER MODIFICARNE UNO
        // OCCORRE CARICARNE UNA NUOVA VERSIONE MODIFICATA QUINDI AVREI UN DOCUMENTO
        // NUOVO DA SCARICARE E UN DOCUMENTO IN LOCALE DA ELIMINARE

        for (final remoteDoc in remoteDocumentsMap.entries) {
          final Document remoteDocModel = remoteDoc.value;

          if (localDocumentsMap[remoteDocModel.idDocumento] == null) {
            // DOCUMENTO PRESENTE SOLO IN REMOTO
            // DOWNLOAD DEL DOCUMENTO
            debugPrint("DOCUMENTO PRESENTE SOLO IN REMOTO");
            await documentsRepository.documentDowload(
                idDocumento: remoteDocModel.idDocumento,
                idClinica: currentUser.idClinica,
                remoteDocument: remoteDocModel);
          }
        }

        for (final localDoc in localDocumentsMap.entries) {
          final Document localDocModel = localDoc.value;

          if (remoteDocumentsMap[localDocModel.idDocumento] == null) {
            // DOCUMENTO PRESENTE SOLO IN LOCALE
            // ELIMINAZIONE DEL DOCUMENTO
            debugPrint("DOCUMENTO PRESENTE SOLO IN LOCALE");
            Either<FailureEntity, void> documentDeleteAttempt =
                await documentsRepository.documentDelete(
                    idDocumento: localDocModel.idDocumento,
                    idClinica: currentUser.idClinica);

            documentDeleteAttempt.fold((l) => null, (r) => null);
          }
        }

        // SINCRONIZZAZIONE AVVENUTA CORRETAMENTE
        debugPrint("SINCRONIZZAZIONE AVVENUTA CON SUCCESSO");

        // RECUPERO TUTTI I DOCUMENTI PRESENTI IN LOCALE AGGIORNATI
        Either<FailureEntity, Map<int, Document>>
            updatedlocalDocumentsRetrieveAttempt = await documentsRepository
                .getLocalDocuments(idClinica: currentUser.idClinica);

        updatedlocalDocumentsRetrieveAttempt.fold((failure) {
          // ! ERRORE GRAVE
          debugPrint("ERRORE NEL RECUPERO DEI FILE");
        }, (localDocumentsMap) {
          emit(DocumentsSynchState(documentsList: localDocumentsMap));
        });
      });
    });
  }

  void clearCache({required String idClinica}) async {
    // CLEAR DELLA CACHE LOCALE DEI DOCUMENTI
    if (state is DocumentsSynchState) {
      emit(DocumentsSynchingState(
          currentOperation: 'Pulizia della cache', documentsList: {}));
      await documentsRepository.clearCache(idClinica: idClinica);
      emit(DocumentsSynchState(documentsList: {}));
    }
  }

  Future<void> documentUpload({required String idDocumento}) async {
    emit(DocumentsSynchingState(
        currentOperation: 'Upload del documento',
        documentsList: state.documentsList));
    await documentsRepository.documentUpload(
        idClinica: currentUser.idClinica, idDocumento: int.parse(idDocumento));
    //await documentsRepository.documentDelete(idDocumento: int.parse(idDocumento), idClinica: currentUser.idClinica);
    emit(DocumentsSynchState(documentsList: state.documentsList));
  }
}
