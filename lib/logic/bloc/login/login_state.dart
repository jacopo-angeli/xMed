part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class NotLoggedState extends LoginState {}

class LoggingState extends LoginState {}

class LoggedState extends LoginState {
  final User user;

  LoggedState({required this.user});
}

class WrongInputState extends LoginState {
  final String emailError;
  final String passwordError;
  final LoginData loginData;

  WrongInputState(
      {required this.emailError,
      required this.passwordError,
      required this.loginData});
}

class DisabledCredentialState extends LoginState {
  final LoginData loginData;

  DisabledCredentialState({required this.loginData});
}

class LoginErrorState extends LoginState {
  final FailureTypes failureType;

  LoginErrorState({required this.failureType});
}
