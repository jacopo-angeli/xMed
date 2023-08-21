part of 'clinic_bloc.dart';

@immutable
abstract class ClinicState {}

class DefaultDetailsState extends ClinicState {}

class DetailsFetchingState extends ClinicState {}

class DetailsAvaiableState extends ClinicState {
  final Clinic clinic;

  DetailsAvaiableState({required this.clinic});
}

class SystemErrorState extends ClinicState {
  final FailureTypes failureType;

  SystemErrorState({required this.failureType});
}
