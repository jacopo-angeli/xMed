part of 'license_cubit.dart';

abstract class LicenseState {}

class LicenseSynching extends LicenseState {}

class LicenseErrorState extends LicenseState {
  final String errorMessage;

  LicenseErrorState({required this.errorMessage});
}

class LicenseNotNecessary extends LicenseState {}

class LicenseInfoReady extends LicenseState {
  final License license;
  LicenseInfoReady({required this.license});
}
