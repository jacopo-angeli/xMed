import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/connection/presentation/cubits/internet/internet_cubit.dart';
import 'package:xmed/features/login/domain/repositories/user_repository.dart';
import 'package:xmed/features/login/domain/usecases/login.dart';
import 'package:xmed/features/login/domain/usecases/logout.dart';
import 'package:xmed/core/utils/services/validator_service.dart';

import '../../../../../core/utils/constants/strings.dart';
import '../../../domain/entities/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // INTERNET CUBIT LOGIN
  final InternetCubit internetCubit;
  // REPOSITORY DECLARATION
  final UserRepository userRepository;
  // USE CASES DECLARATION
  late final LogInUseCase loginUseCase;
  late final LogOutUseCase logOutUseCase;
  // CURRENT USER DECLARATION PER UTILIZZO CON ALTRI CUBIT
  late User currentUser;

  LoginCubit({required this.internetCubit, required this.userRepository})
      : super(const NotLoggedState()) {
    loginUseCase = LogInUseCase(userRepository: userRepository);
    logOutUseCase = LogOutUseCase(userRepository: userRepository);
  }

  Future<void> appStartedEvent() async {
    emit(const LoggingState());
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

  void logInRequest(
      {required String username, required String password}) async {
    emit(LoggingState(username: username, password: password));
    // TODO REFACTOR
    // SANITY CHECK DI username E password
    final emailError = ValidatorService.emailValidation(email: username)
        ? ""
        : wrongEmailInput;
    final String passwordError = password.isEmpty ? emptyFieldError : "";
    if (emailError.isNotEmpty || passwordError.isNotEmpty) {
      // ALMENO username O password CONTENGONO UN ERRORE
      emit(WrongInputState(
          username: username,
          password: password,
          emailError: emailError,
          passwordError: passwordError));
    } else {
      // TENTATIVO DI LOGIN
      Either<FailureEntity, User> result =
          await loginUseCase.execute(email: username, password: password);

      // GESTIONE DEL RISULTATO
      _loginResultHandler(result, username, password);
    }
  }

  //HANDLER RISULTATO CHIAMATA DI LOGIN
  void _loginResultHandler(
      Either<FailureEntity, User> result, String username, String password) {
    result.fold((failure) {
      switch (failure.runtimeType) {
        case (DBFailure):
        case (LoginFailure):
          emit(WrongInputState(
              username: username,
              password: password,
              emailError: wrongCredentialErrorMessage,
              passwordError: wrongCredentialErrorMessage));
          break;
        default:
          break;
      }
    }, (user) {
      debugPrint('UTENTE RECUEPERATO CON SUCCESSO : $user');
      currentUser = user;
      currentUser.copyWith(username: username);
      if (currentUser.status == "DISABLED") {
        emit(WrongInputState(
            username: username,
            password: password,
            emailError: disabledCredentialErrorMessage,
            passwordError: disabledCredentialErrorMessage));
      } else {
        emit(LoggedState(user: user));
      }
    });
  }

  void logOutRequest() async {
    // ELIMINO DAL SECURE STORAGE password
    // EMETTO LO STATO DI NOTLOGGED
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'password');
    emit(NotLoggedState(username: await storage.read(key: 'username')));
  }
}
