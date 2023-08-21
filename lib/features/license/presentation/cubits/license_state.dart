part of 'license_cubit.dart';

abstract class LicenseState {}

class UnlicensedState extends LicenseState {}

class LicenseSyncingState extends LicenseState {}

class LicensedState extends LicenseState {
  final License license;
  LicensedState({required this.license});
}
