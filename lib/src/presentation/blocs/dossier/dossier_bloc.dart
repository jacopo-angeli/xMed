import 'package:bloc/bloc.dart';

import '../../../domain/entities/document.model.dart';
import '../../../utils/costants/enums/failure_types.dart';

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
