part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class AppStartedEvent extends LoginEvent {}

class LoginAttemptEvent extends LoginEvent {
  final Credentials credentials;

  LoginAttemptEvent({required this.credentials});
}
