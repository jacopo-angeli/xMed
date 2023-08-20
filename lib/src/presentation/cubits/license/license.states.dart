part of 'license.cubit.dart';

@immutable
abstract class LicenseState extends Equatable {
  @override
  List<Object> get props => [];
}

class UnlicensedState extends LicenseState {}

class LicenseSynchingState extends LicenseState {}

class LicensedState extends LicenseState {
  final License license;

  LicensedState({required this.license});

  @override
  List<Object> get props => [license];
}

class LicenseExpiredState extends LicenseState {
  final License license;

  LicenseExpiredState({required this.license});

  @override
  List<Object> get props => [license];
}
