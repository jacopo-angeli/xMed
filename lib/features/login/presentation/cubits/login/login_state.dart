part of 'login_cubit.dart';

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
  final String? email;
  final String? password;

  WrongInputState(
      {required this.emailError,
      required this.passwordError,
      this.email,
      this.password});
}

class DisabledCredentialState extends LoginState {
  final String? email;
  final String? password;

  DisabledCredentialState({this.email, this.password});
}

class LoginErrorState extends LoginState {
  final FailureEntity failureEntity;
  final String email;
  final String password;

  LoginErrorState(
      {required this.email,
      required this.password,
      required this.failureEntity});
}
