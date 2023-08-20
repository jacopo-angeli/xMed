import 'package:bloc/bloc.dart';

import '../../../domain/entities/license.model.dart';

part 'license_event.dart';
part 'license_state.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  LicenseBloc() : super(LicensedState(license: License())) {
    on<TODOEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
