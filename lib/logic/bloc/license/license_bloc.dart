import 'package:bloc/bloc.dart';
import 'package:xmed/data/model/license.dart';

part 'license_event.dart';
part 'license_state.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  LicenseBloc() : super(LicensedState(license: License())) {
    on<TODOEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
