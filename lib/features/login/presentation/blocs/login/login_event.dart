part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class AppStartedEvent extends LoginEvent {}

class LoginRequestedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginRequestedEvent({required this.email, required this.password});
}
