import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/license.model.dart';

part 'license.states.dart';

class LicenseCubit extends Cubit<LicenseState> {
  LicenseCubit(super.initialState);

  void appStartedEvent() {
    emit(LicenseSynchingState());
    // check for local license (needed for Namirial FEA SDK)
    // check for remote license
    // compare license
    emit(LicensedState(license: License()));
  }

  void activateLicense() {
    // ? Check te flow from other application
    // ? Namrial give CWBI x license, CWBI store them, client ask for a license, CWBI send payment request to client ?
    emit(LicensedState(license: License()));
  }

  void licenseRenewal() {
    // ? Check te flow from other application
    // ? Namrial give CWBI x license, CWBI store them, client ask for a license, CWBI send payment request to client ?
    emit(LicensedState(license: License()));
  }

  void licenseExpired() {
    // ? Every appStartedEvent start a timer with license expire time here, when application is closed timer should be canceled
    // ? At timer end emit Unlicenced? Better create a dedicated state.
    emit(LicenseExpiredState(license: License()));
  }
}
