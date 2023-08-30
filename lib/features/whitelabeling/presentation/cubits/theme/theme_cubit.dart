import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmed/core/error_handling/failures.dart';
import 'package:xmed/features/login/presentation/cubits/login/login_cubit.dart';
import 'package:xmed/features/whitelabeling/domain/repositories/theme_repository.dart';
import '../../../domain/entities/theme.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  // REPOSITORY DECLARATION
  final ThemeRepository themeRepository;
  final LoginCubit loginCubit;

  // CONSTRUCTOR
  ThemeCubit({required this.loginCubit, required this.themeRepository})
      : super(const AppStartedState());

  Future<void> appStartedEvent() async {
    // AppStartedState
    // Ricerco tema locale
    // Se lo trovo lo ritorno
    // Se non lo trovo lo creo con tema di default e dopo lo ritorno

    debugPrint('TENTATIVO DI RECUPERO DEL TEMA LOCALE');
    final Either<FailureEntity, XmedTheme> localThemeRetrieveAttempt =
        await themeRepository.getLocalClinicTheme();

    localThemeRetrieveAttempt.fold((failure) async {
      debugPrint('FALLIMENTO NEL RECUPERO DEL TEMA DA LOCALE');
      debugPrint('SALVATAGGIO DEL TEMA DI DEFAULT IN LOCALE');
      final defaultTheme = await XmedTheme.getDefaultTheme();
      await themeRepository.writeLocalClinicTheme(defaultTheme);
      debugPrint('TEMA SALVATO IN LOCALE');
      emit(ThemeSynchedState(currentTheme: defaultTheme));
    }, (localTheme) async {
      debugPrint('TEMA RECUPERATO CON SUCCESSO');
      emit(ThemeSynchedState(currentTheme: localTheme));
    });
  }

  Future<void> synch({required XmedTheme currentTheme}) async {
    // SINCRONIZZA IL TEMA DELL'APP RECUPERANDO IL TEMA REMOTO
    // E CONFRONTANDOLO CON IL LOCALE SE I DUE TEMI NON
    // SONO CONGRUENTI ALLORA SOVRASCRIVE IL TEMA LOCALE
    // CON QUELLO REMOTO (SEMPRE AGGIORNATO) E LO RITORNA

    emit(ThemeSynchingState(currentTheme: currentTheme));
    debugPrint('TENTATIVO DI RECUPERO DEL TEMA LOCALE');
    final Either<FailureEntity, XmedTheme> localThemeRetrieveAttempt =
        await themeRepository.getLocalClinicTheme();

    localThemeRetrieveAttempt.fold((failure) async {
      debugPrint('TEMA LOCALE NON PRESENTE (TECNINCAMENTE IMPOSSIBILE)');
      debugPrint('SALVATAGGIO DEL TEMA DI DEFAULT IN LOCALE');
      final defaultTheme = await XmedTheme.getDefaultTheme();
      themeRepository.writeLocalClinicTheme(defaultTheme);
      debugPrint('TEMA LOCALE SALVATO CORRETTAMENTE');
      emit(ThemeSynchedState(currentTheme: defaultTheme));
    }, (localTheme) async {
      debugPrint('TEMA RECUPERATO CON SUCCESSO');

      debugPrint('TENTATIVO DI RECUPERO TEMA DA REMOTO');
      final Either<FailureEntity, XmedTheme> remoteThemeRetrieveAttempt =
          await themeRepository.getRemoteClinicTheme(
              idClinica: loginCubit.currentUser.idClinica);

      // GESTIONE DEL RISULTATO
      remoteThemeRetrieveAttempt.fold((failure) {
        debugPrint('ERRORE NELL RECUPERO DEL TEMA REMOTO');
        // TODO : Valutare se informare o meno l'operatore della clinica
        emit(ThemeSynchedState(currentTheme: localTheme));
      }, (remoteTheme) async {
        debugPrint('TEMA LOCALE SOVRASCRITTO');
        await themeRepository.writeLocalClinicTheme(remoteTheme);
        emit(ThemeSynchedState(currentTheme: remoteTheme));
      });
    });
  }
}
