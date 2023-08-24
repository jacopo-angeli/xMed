import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    emit(LoggingState());
    // RECUPERO username E password DAL SECURE STORAGE
    const storage = FlutterSecureStorage();
    Map<String, String> secureStorageContent = await storage.readAll();
    final String? password = secureStorageContent['password'];
    final String? username = secureStorageContent['username'];

    // AUTOLOGIN
    if (password != null) {
      if (username != null) {
        // TENTATIVO DI LOGIN
        Either<FailureEntity, User> result =
            await loginUseCase.execute(email: username, password: password);

        // GESTIONE DEL RISULTATO
        _loginResultHandler(result, username, password);
      }
    } else {
      // NOTLOGGED STATE CON CAMPO USERNAME, SE UN UTENTE EFFETTUA
      // IL LOGOUT IL CAMPO PASSWORD VIENE ELIMINATO DAL SECURE STORAGE
      // OBBLIGANDO L'UTENTE A REINSERIRLA
      emit(NotLoggedState(username: username));
    }
  }

  void logInRequest({required String email, required String password}) async {
    emit(LoggingState());
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
      _loginResultHandler(result, email, password);
    }
  }

  //HANDLER RISULTATO CHIAMATA DI LOGIN
  void _loginResultHandler(
      Either<FailureEntity, User> result, String email, String password) {
    result.fold((l) {
      switch (l.runtimeType) {
        case (DBFailure):
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
    }, (r) {
      emit(LoggedState(user: r));
    });
  }

  void logOutRequest() async {
    // ELIMINO DAL SECURE STORAGE password
    // EMETTO LO STATO DI NOTLOGGED
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'password');
    print("puzzapalle");
    emit(NotLoggedState(username: await storage.read(key: 'username')));
  }
}
