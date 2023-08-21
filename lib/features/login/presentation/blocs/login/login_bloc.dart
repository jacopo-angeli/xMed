import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:xmed/utils/constants/enums/failure_types.dart';
import 'package:xmed/utils/constants/enums/validator_massages.dart';
import 'package:xmed/utils/constants/regular_expressions.dart';

import '../../../domain/entities/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // TODO : Aggiungere clinic state
  LoginBloc() : super(NotLoggedState()) {
    on<AppStartedEvent>((event, emit) async {
      emit(LoggingState());
      // controllare se username e password sono salvati in locale
      // se si effettuare autologin
      // altrimenti emit(NotLoggedState())
      await Future.delayed(const Duration(seconds: 5));
      emit(NotLoggedState());
    });
    on<LoginRequestedEvent>(
      (event, emit) async {
        emit(LoggingState());
        await Future.delayed(const Duration(seconds: 1));
        // Controllo i dati della form
        String emailErrorMessage = "", passwordErrorMessage = "";

        if (event.email.isEmpty) {
          emailErrorMessage = ValidatorMessages.requiredField();
        } else if (!RegExp(RegularExpressions.emailRegExp())
            .hasMatch(event.email.toString())) {
          emailErrorMessage = ValidatorMessages.badFormat();
        }

        if (event.password.isEmpty) {
          passwordErrorMessage = ValidatorMessages.requiredField();
        }

        if (emailErrorMessage.isNotEmpty || passwordErrorMessage.isNotEmpty) {
          emit(WrongInputState(
              emailError: emailErrorMessage,
              passwordError: passwordErrorMessage,
              email: event.email,
              password: event.password));
          await Future.delayed(const Duration(seconds: 1));
          emit(NotLoggedState());
        } else {
          //Check on pushed data
        }

        // tento il login usando event.loginData
        // gestisco la risposta dal backoffice
      },
    );
  }
}
