import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/login/domain/usecases/login.dart';
import 'package:xmed/features/login/domain/usecases/logout.dart';

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
    emit(LoggedState(user: User.defaultUser()));
  }

  void logInRequest({required String email, required String password}) async {
    // Effettuo il login e gestisco il ritorno
    // Gestisco il ritorno di loginUseCase.execute
    Either<FailureEntity, User> response =
        await loginUseCase.execute(email: email, password: password);

    switch (response.runtimeType) {
      case User:
        break;
      default:
    }
  }

  void logOutRequest() {
    // Effettuo il logout e gestisco il ritorno
  }
}
