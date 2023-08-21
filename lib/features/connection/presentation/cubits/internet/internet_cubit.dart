import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:xmed/utils/constants/enums/connection_types.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity})
      : super(CheckingConnectionState()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      switch (connectivityResult) {
        case ConnectivityResult.none:
          emitInternetDisconnectedState();
          break;
        case ConnectivityResult.mobile:
          emitInternetConnectedState(ConnectionTypes.MOBILE);
          break;
        case ConnectivityResult.wifi:
          emitInternetConnectedState(ConnectionTypes.WIFI);
          break;
        default:
        //BU
      }
    });
  }

  void emitInternetConnectedState(ConnectionTypes connectionType) =>
      emit(InternetConnectedState(connectionType: connectionType));

  void emitInternetDisconnectedState() => emit(InternetDisconnectedState());
}
