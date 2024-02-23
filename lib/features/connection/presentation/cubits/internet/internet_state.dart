part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class CheckingConnectionState extends InternetState {}

class InternetConnectedState extends InternetState {
  final ConnectionTypes connectionType;

  InternetConnectedState({required this.connectionType});
}

class InternetDisconnectedState extends InternetState {}
