part of 'dossier_bloc.dart';

abstract class DossierState {}

class FetchingDossierState extends DossierState {}

class DossierReadyState extends DossierState {
  final List<Document> dossier;

  DossierReadyState({required this.dossier});
}

class EmptyDossierState extends DossierState {}

class SystemErrorState extends DossierState {
  FailureTypes failureTypes;

  SystemErrorState({required this.failureTypes});
}
