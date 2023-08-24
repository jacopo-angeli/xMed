part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  final String? username;
  final String? password;

  const LoginState({this.username, this.password});
}

class NotLoggedState extends LoginState {
  const NotLoggedState({super.username});
}

class LoggingState extends LoginState {
  const LoggingState({super.username, super.password});
}

class LoggedState extends LoginState {
  final User user;

  const LoggedState({required this.user});
}

class WrongInputState extends LoginState {
  final String emailError;
  final String passwordError;

  WrongInputState(
      {required this.emailError,
      required this.passwordError,
      super.username,
      super.password});
}

class DisabledCredentialState extends LoginState {
  const DisabledCredentialState({super.username, super.password});
}

class LoginErrorState extends LoginState {
  final FailureEntity failureEntity;

  const LoginErrorState(
      {required super.username,
      required super.password,
      required this.failureEntity});
}
