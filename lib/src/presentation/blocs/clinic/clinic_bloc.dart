import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/clinic.model.dart';
import '../../../utils/costants/enums/failure_types.dart';

part 'clinic_event.dart';
part 'clinic_state.dart';

class ClinicBloc extends Bloc<ClinicEvent, ClinicState> {
  ClinicBloc() : super(DefaultDetailsState()) {
    on<ApplicationStarted>((event, emit) async {
      //Flow :
      // 1 Cerco i dati in locale,
      //  1 se li trovo emetto lo stato di DetailsAvaiable
      //  2 se non li trovo controllo se solo loggato
      //    1 se non sono loggato emetto lo stato di

      // emit DetailsFetchingState
      emit(DetailsFetchingState());
      // Check for local data
      await Future.delayed(const Duration(seconds: 1));
      // Manage results
      emit(DefaultDetailsState());
    });
    on<LoggedIn>(((event, emit) async {
      // emit DetailsFetchingState
      emit(DetailsFetchingState());
      // fetch remote data
      await Future.delayed(const Duration(seconds: 5));
      // manage api response
      emit(DefaultDetailsState());
      // if founded emit DetailsAvaiable()
      // else if not founded emit DeafultDetails()
      // else emit SystemError(FailureType.CLINIC_API_FAIL)
      // report error
    }));
  }
}
