import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/core/utils/constants/strings.dart';
import 'package:xmed/features/license/domain/repositories/license_repository.dart';
import 'package:xmed/features/license/domain/repositories/namirial_sdk_repository.dart';
import 'package:xmed/features/login/domain/entities/user.dart';

import '../../domain/entities/license.dart';

part 'license_state.dart';

class LicenseCubit extends Cubit<LicenseState> {
  // DICHIRARAZIONE REPOSITORY
  final LicenseRepository licenseRepository;
  final NamirialSDKLicenseRepository namirialRepository;

  // PARAMETRI GLOBALI
  final User currentUser;

  // COSTRUTTORE
  LicenseCubit(
      {required this.namirialRepository,
      required this.currentUser,
      required this.licenseRepository})
      : super(LicenseSynching());

  void setup() async {
    // flagLicenzaObbligatoria ?
    // SI.  C'è già una licenza presente in locale ?
    //      SI. Valido la licenza con SDK di namirial
    //          Validazione superata ?
    //          SI. Comunico al backoffice che la licenza è attiva
    //              Richiesta va a buon fine ?
    //              SI. Posso utilizzare l'SDK
    //              NO. Posso utilizzare comunque l'SDK.
    //                  Valido la licenza ogni volta che avvio l'applicazione.
    //          NO. Licenza scaduta ?
    //              SI. Richiedo una nuova licenza al backoffice
    //                  Ottengo una licenza ?
    //                  SI. Valido la licenza con SDK di namirial
    //                      Validazione superata ?
    //                      SI. Comunico al backoffice che la licenza è attiva
    //                          Richiesta va a buon fine ?
    //                          SI. Posso utilizzare l'SDK
    //                          NO. Posso utilizzare comunque l'SDK.
    //                              Valido la licenza ogni volta che avvio l'applicazione.
    //                      NO. Il backoffice ha fornito una licenza non più valida
    //                  NO. Il backoffice non ha licenze disponibili
    //              NO. Licenza corrotta ?
    //                  SI. Recupero della licenza mediante namirial
    //                  NO. Ritento la validazione
    //                      Validazione superata ?
    //                      SI. Posso utilizzare l'applicazione senza problemi
    //!                      NO. rip
    //      NO. Richiedo una nuova licenza al backoffice
    //          Ottengo una licenza ?
    //          SI. Valido la licenza con SDK di namirial
    //              Validazione superata ?
    //              SI. Comunico al backoffice che la licenza è attiva
    //                  Richiesta va a buon fine ?
    //                  SI. Posso utilizzare l'SDK
    //                  NO. Posso utilizzare comunque l'SDK.
    //                      Valido la licenza ogni volta che avvio l'applicazione.
    //!              NO. Il backoffice ha fornito una licenza non più valida
    //          NO. Il backoffice non ha licenze disponibili
    // NO.  C'è una licenza in locale ?
    //      SI. Valido la licenza con SDK di namirial
    //          Validazione superata ?
    //          SI. Posso utilizzare l'applicazione senza problemi
    //          NO. Licenza scaduta ?
    //              SI. Richiedo una nuova licenza al backoffice
    //                  Ottengo una licenza ?
    //                  SI. Valido la licenza con SDK di namirial
    //                      Validazione superata ?
    //                      SI. Comunico al backoffice che la licenza è attiva
    //                          Richiesta va a buon fine ?
    //                          SI. Posso utilizzare l'SDK
    //                          NO. Posso utilizzare comunque l'SDK.
    //                              Valido la licenza ogni volta che avvio l'applicazione.
    //                      NO. Il backoffice ha fornito una licenza non più valida
    //                  NO. Il backoffice non ha licenze disponibili
    //              NO. Licenza corrotta ?
    //                  SI. Recupero della licenza mediante namirial
    //                  NO. Ritento la validazione
    //                      Validazione superata ?
    //                      SI. Posso utilizzare l'applicazione senza problemi
    //!                      NO. rip
    //!      NO. rip

    if (testMode) {
      // MODALITà DI TESTING
      final License license = License.defaultLicense();
      licenseRepository.persistLicense(license);
      emit(LicenseInfoReady(license: license));
      // TENTO L' ATTIVAZIONE DELLA LICENZA UTILIZZANDO NAMIRIAL
      debugPrint(File(await licenseRepository.getLocalLicenseFilePath())
          .readAsStringSync());
      debugPrint(
          "username : ${currentUser.username}, email: ${currentUser.username}");

      final Either<FailureEntity, License> requireLicenseAttemptResult =
          await namirialRepository.requireLicense(
              username: currentUser.username,
              email: currentUser.username,
              licenseFilePath:
                  await licenseRepository.getLocalLicenseFilePath());

      requireLicenseAttemptResult.fold((failure) {
        debugPrint(
            "LICENZA NON VALIDA (NAMIRIAL SDK) : ${failure.runtimeType}");
        // TODO
        switch (failure.runtimeType) {
          case "":
            break;
          default:
        }
      }, (validatedNamirialLicense) async {
        debugPrint("LICENZA VALIDA (NAMIRIAL SDK)");
      });
    } else if (currentUser.flagLicenzaObbligatoria == 1) {
      debugPrint("UTENTE CON FLAG DI LICENZA OBBLIGATORIA");

      debugPrint("CONTROLLO LA PRESENZA DELLA LICENZA LOCALE");

      // TENTO DI RECUPERARE LA LICENZA LOCALE SE ESISTE
      final Either<FailureEntity, License> localLicenseRetrieveAttempt =
          await licenseRepository.getLocalLicense();

      // GESTISCO IL RISULTATO DEL RECUPERO DELLA LICENZA DA LOCALE

      localLicenseRetrieveAttempt.fold((failure) async {
        // FALLIMENTO NEL RECUPERO DELLA LICENZA LOCALE
        if (failure.runtimeType == MissingLocalLicense) {
          debugPrint("LICENZA NON PRESENTE IN LOCALE");

          // DOWNLOAD DELLA LICENZA
          final Either<FailureEntity, License> downloadLicenseRetrieveAttempt =
              await licenseRepository.licenseDownload(
                  idClinica: currentUser.idClinica);

          downloadLicenseRetrieveAttempt.fold((failure) {
            // DOWNLOAD DELLA LICENZA FALLITO
            emit(LicenseErrorState(
                errorMessage: "Download della licenza fallito."));
          }, (remoteLicense) async {
            // LICENZA CORRETTAMENTE SCARICATA

            // SALVATAGGIO DELLA LICENZA IN LOCALE
            await licenseRepository.persistLicense(remoteLicense);

            // TENTO L' ATTIVAZIONE DELLA LICENZA UTILIZZANDO NAMIRIAL
            final Either<FailureEntity, License> requireLicenseAttemptResult =
                await namirialRepository.requireLicense(
                    username: currentUser.username,
                    email: currentUser.username,
                    licenseFilePath:
                        await licenseRepository.getLocalLicenseFilePath());

            requireLicenseAttemptResult.fold((failure) {
              debugPrint("LICENZA NON VALIDA (NAMIRIAL SDK)");
              // TODO
              switch (failure.runtimeType) {
                case "":
                  break;
                default:
              }
            }, (validatedNamirialLicense) async {
              debugPrint("LICENZA VALIDA (NAMIRIAL SDK)");

              debugPrint("SINCRONIZZAZIONE CON BACKOFFICE");
              // SE VA A BUON FINE COMUNICO AL BACKOFFICE L'ATTIVAZIONE DELLA LICENZA
              final Either<FailureEntity, void> licenseActivateAttempt =
                  await licenseRepository.licenseActivate(
                      idClinica: currentUser.idClinica,
                      licenzaNonAttiva: validatedNamirialLicense);

              if (licenseActivateAttempt.runtimeType == Null) {
                debugPrint("SINCRONIZZAZIONE AVVENUTA CON SUCCESSO");
              }

              // NON GESTISCO Il RISULTATO DELLA RICHIESTA D'ATTIVAZIONE
              // DELLA LICENZA PERCHè IN OGNI CASO LA LICENZA è STATA ATTIVATA
              // AL PROSSIMO AVVIO RITENTO LA SINCRONIZZAZZIONE, SE NEL MENTRE
              // LA CACHE DEL DISPOSITOVO è STATA ELIMINATA CONTROLLARE
              // COSA PREVEDE LA DOCUMENTAZIONE DI NAMIRIAL
              emit((LicenseInfoReady(
                  license:
                      validatedNamirialLicense.copyWith(status: "ATTIVA"))));
            });
          });
        } else {
          // CASO 1 SU 10000000000 LICENZA MODIFICATA
          // RECUPERO DELLA LICENZA MEDIANTE NAMIRIAL o ATTIVAZIONE DI NUOVA LICENZA
          emit(LicenseErrorState(
              errorMessage:
                  "Il recupero della licenza non è andato a buon fine"));
        }
      }, (localNamrialLicense) async {
        debugPrint("LICENZA RECUPERATA CON SUCCESSO");
        debugPrint("VALIDAZIONE MEDIANTE NAMIRIAL SDK");
        final Either<FailureEntity, License> requireLicenseAttemptResult =
            await namirialRepository.requireLicense(
                username: currentUser.username,
                email: currentUser.username,
                licenseFilePath:
                    await licenseRepository.getLocalLicenseFilePath());

        requireLicenseAttemptResult.fold((failure) {
          debugPrint(failure.runtimeType.toString());
          debugPrint("VALIDAZIONE FALLITA");
          switch (failure.runtimeType) {
            case "":
              break;
            default:
          }
          emit(LicenseErrorState(errorMessage: "Licenza non valida."));
        }, (validatedNamirialLicense) async {
          debugPrint("LICENZA VALIDA (NAMIRIAL SDK)");
          emit(LicenseInfoReady(
              license: validatedNamirialLicense.copyWith(status: "VALIDA")));
        });
      });
    } else {
      debugPrint("UTENTE SENZA FLAG DI LICENZA OBBLIGATORIA");
      debugPrint("CERCO UNA LICENZA IN LOCALE");
      emit(LicenseNotNecessary());
    }
  }
}
