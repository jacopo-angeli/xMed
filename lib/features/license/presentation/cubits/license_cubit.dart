import 'package:bloc/bloc.dart';
import 'package:xmed/features/license/domain/repositories/license_repository.dart';

import '../../domain/entities/license.dart';

part 'license_state.dart';

class LicenseCubit extends Cubit<LicenseState> {
  final LicenseRepository repo;
  LicenseCubit({required this.repo}) : super(UnlicensedState());

  void appStarted() {
    // controllo in locale se ho una licenza
    // in caso la scarico e per attivare la licenza devo interfacciarmi con Namirial
    // comunicazione di attivazione al backoffice
    emit(LicenseSyncingState());
  }

  void licenseNotFound(License InsertedLicense) {
    // ricerco nel DB se la licenza inserita esiste
    // in caso esista ho due possibilità
    //  Licenza valida => chiamo LicenseFound()
    // Licenza scaduta => chiamo LicenseExpired() che chiama LicenseRenewal()
    // licenza non esistente => chiamo buyLicense()
    emit(UnlicensedState());
  }

  void buyLicense() {
    //TODO interfacciarsi con Namirial fornendo servizio per comprare una licenza
    emit(LicenseSyncingState());
  }

  void licenseExpired(License InsertedLicense) {
    // PRE: licenza scaduta
    emit(LicenseSyncingState()); // emetto il relativo stato
    //chiamo il metodo per il rinnovamento della licenza
    this.licenseRenewal(InsertedLicense);
  }

  void licenseRenewal(License InsertedLicense) {
    //TODO interfacciarsi con Namirial fornendo servizio di rinnovo licenza
    emit(LicenseSyncingState());
  }

  void licenseFound(License InsertedLicense) {
    //PRE: InsertedLicense esiste nel DB ed è valida
    emit(LicensedState(license: InsertedLicense)); //emetto il relativo segnale
  }
}
