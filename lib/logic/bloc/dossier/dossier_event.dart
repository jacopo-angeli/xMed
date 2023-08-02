part of 'dossier_bloc.dart';

abstract class DossierEvent {}

class ReloadRequestEvent extends DossierEvent {
  final String clinicID;

  ReloadRequestEvent({required this.clinicID});
}
