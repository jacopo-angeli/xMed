part of 'license_bloc.dart';

abstract class LicenseState {
  const LicenseState();
}

class UnlicensedState extends LicenseState {}

class LicenceSynching extends LicenseState {}

class LicensedState extends LicenseState {
  final License license;

  LicensedState({required this.license});
}
