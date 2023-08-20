import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../utils/costants/enums/connection_types.dart';

part 'internet.states.dart';

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
      }
    });
  }

  void emitInternetConnectedState(ConnectionTypes connectionType) =>
      emit(InternetConnectedState(connectionType: connectionType));

  void emitInternetDisconnectedState() => emit(InternetDisconnectedState());
}
