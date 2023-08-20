part of 'internet.cubit.dart';

@immutable
abstract class InternetState extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckingConnectionState extends InternetState {}

class InternetConnectedState extends InternetState {
  final ConnectionTypes connectionType;

  InternetConnectedState({required this.connectionType});

  @override
  List<Object> get props => [connectionType];
}

class InternetDisconnectedState extends InternetState {}
