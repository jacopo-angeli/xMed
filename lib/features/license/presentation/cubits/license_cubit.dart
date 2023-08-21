import 'package:bloc/bloc.dart';

import '../../domain/entities/license.dart';
part 'license_state.dart';

class LicenseCubit extends Cubit<LicenseState> {
  LicenseCubit() : super(UnlicensedState());

  void appStarted() {
    //nel momento in cui avvio l'app verrò segnato come unlicensed per poi modificarlo in seguito
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
    emit(LicenseSyncingState());
  }

  void licenseExpired(License InsertedLicense) {
    emit(LicenseSyncingState());
  }

  void licenseRenewal(License InsertedLicense) {
    emit(LicenseSyncingState());
  }

  void licenseFound(License InsertedLicense) {
    emit(LicensedState(license: InsertedLicense));
  }
}
