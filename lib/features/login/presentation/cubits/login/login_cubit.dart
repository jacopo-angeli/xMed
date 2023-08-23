import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/login/domain/usecases/login.dart';
import 'package:xmed/features/login/domain/usecases/logout.dart';
import 'package:xmed/utils/services/validator_service.dart';

import '../../../../../utils/constants/strings.dart';
import '../../../domain/entities/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // USE CASES DECLARATION
  final LogInUseCase loginUseCase;
  final LogOutUseCase logOutUseCase;

  LoginCubit({required this.loginUseCase, required this.logOutUseCase})
      : super(NotLoggedState());

  void appStartedEvent() async {
    // Controllo eventuali username e password salvati nel secure storage
    // Tento il login
    // Gestisco il ritorno
    await Future.delayed(const Duration(seconds: 3));
    emit(NotLoggedState());
  }

  void logInRequest({required String email, required String password}) async {
    // SANITY CHECK DI email E password
    final emailError =
        ValidatorService.emailValidation(email: email) ? "" : wrongEmailInput;
    final String passwordError = password.isEmpty ? emptyFieldError : "";
    if (emailError.isNotEmpty || passwordError.isNotEmpty) {
      // ALMENO email O password CONTENGONO UN ERRORE
      emit(WrongInputState(
          email: email,
          password: password,
          emailError: emailError,
          passwordError: passwordError));
    } else {
      // TENTATIVO DI LOGIN
      Either<FailureEntity, User> result =
          await loginUseCase.execute(email: email, password: password);

      // GESTIONE DEL RISULTATO
      result.fold((l) {
        switch (l.runtimeType) {
          case (DBFailure):
            emit(LoginErrorState(
                email: email, password: password, failureEntity: l));
            break;
          case (LoginFailure):
            emit(WrongInputState(
                email: email,
                password: password,
                emailError: wrongCredentialErrorMessage,
                passwordError: wrongCredentialErrorMessage));
            break;
          default:
            break;
        }
      }, (r) => null);
    }
  }

  void logOutRequest() {
    // Effettuo il logout e gestisco il ritorno
  }
}
