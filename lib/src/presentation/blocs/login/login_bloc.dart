import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/credentials.model.dart';
import '../../../domain/entities/user.dart';
import '../../../utils/costants/enums/failure_types.dart';
import '../../../utils/costants/enums/validator_massages.dart';
import '../../../utils/costants/regular_expressions.dart';
import '../clinic/clinic_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ClinicBloc clinicBloc;

  LoginBloc({required this.clinicBloc}) : super(NotLoggedState()) {
    /*--------------------- App Started -------------------- */
    on<AppStartedEvent>((event, emit) async {
      emit(LoggingState());
      // controllare se username e password sono salvati in locale
      // se si effettuare autologin
      // altrimenti emit(NotLoggedState())
      await Future.delayed(const Duration(seconds: 5));
      emit(NotLoggedState());
    });

    /*--------------------- Login Attempt -------------------- */
    on<LoginAttemptEvent>(
      (event, emit) async {
        emit(LoggingState());
        await Future.delayed(const Duration(seconds: 1));
        // Controllo i dati della form
        String emailErrorMessage = "", passwordErrorMessage = "";

        if (event.credentials.email!.isEmpty) {
          emailErrorMessage = ValidatorMessages.requiredField();
        } else if (!RegExp(RegularExpressions.emailRegExp())
            .hasMatch(event.credentials.email.toString())) {
          emailErrorMessage = ValidatorMessages.badFormat();
        }

        if (event.credentials.password!.isEmpty) {
          passwordErrorMessage = ValidatorMessages.requiredField();
        }

        if (emailErrorMessage.isNotEmpty || passwordErrorMessage.isNotEmpty) {
          emit(WrongInputState(
              emailError: emailErrorMessage,
              passwordError: passwordErrorMessage,
              credentials: event.credentials));
          await Future.delayed(const Duration(seconds: 1));
          emit(NotLoggedState());
        } else {
          //Check on pushed data
        }

        // tento il login usando event.credentials
        // gestisco la risposta dal backoffice
      },
    );
  }
}
