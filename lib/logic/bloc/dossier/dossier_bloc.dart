import 'package:bloc/bloc.dart';
import 'package:xmed/constants/enums/failure_types.dart';
import 'package:xmed/models/clinic_document.dart';

part 'dossier_event.dart';
part 'dossier_state.dart';

class DossierBloc extends Bloc<DossierEvent, DossierState> {
  DossierBloc() : super(EmptyDossierState()) {
    on<ReloadRequestEvent>((event, emit) {
      emit(FetchingDossierState());
      // Fetch all the document
      // manage response
    });
  }
}
