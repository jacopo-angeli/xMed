part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class AppStartedEvent extends LoginEvent {}

class LoginRequestedEvent extends LoginEvent {
  final LoginData loginData;

  LoginRequestedEvent({required this.loginData});
}
