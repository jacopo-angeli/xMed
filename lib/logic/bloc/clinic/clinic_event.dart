part of 'clinic_bloc.dart';

@immutable
abstract class ClinicEvent {}

class ApplicationStarted extends ClinicEvent {}

class LoggedIn extends ClinicEvent {
  final String clinicID;

  LoggedIn({required this.clinicID});
}
