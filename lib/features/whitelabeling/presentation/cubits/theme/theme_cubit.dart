import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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
      : super(ThemeSyncingState(theme: XmedTheme.defaultTheme()));

  void synch({required XmedTheme theme}) async {
    emit(ThemeSyncingState(theme: theme));
    print('TENTATIVO DI RECUPERO DEL TEMA LOCALE');
    final Either<FailureEntity, XmedTheme> localThemeRetrieveAttempt =
        await themeRepository.getLocalClinicTheme();

    print('GESTIONE RISULTATO DEL TENTATIVO');
    localThemeRetrieveAttempt.fold((failure) {
      print('FALLIMENTO NEL RECUPERO DEL TEMA DA LOCALE');
      print('SALVATAGGIO DEL TEMA DI DEFAULT IN LOCALE');
      themeRepository.writeLocalClinicTheme(XmedTheme.defaultTheme());
      print('STATO CORRENTE ThemeSynched()');
      emit(ThemeSynched(theme: XmedTheme.defaultTheme()));
    }, (localTheme) async {
      print('TEMA RECUPERATO CON SUCCESSO');

      print('TENTATIVO DI RECUPERO TEMA DA REMOTO');
      final Either<FailureEntity, XmedTheme> remoteThemeRetrieveAttempt =
          await themeRepository.getRemoteClinicTheme(
              idClinica: loginCubit.currentUser.idClinica);
      print('GESTISCO IL RISULTATO DEL TENTATIVO');
      remoteThemeRetrieveAttempt.fold((failure) {
        print('TENTATIVO FALLITO');
        emit(ThemeSynched(theme: localTheme));
      }, (remoteTheme) async {
        print('TENTATIVO DI SUCCESSO');
        print('CONFRONTO TEMA LOCALE E REMOTO');
        if (localTheme != remoteTheme) {
          print('TEMA REMOTO PIù RECENTE');
          await themeRepository.writeLocalClinicTheme(remoteTheme);
        }
        print('RITONRO TEMA PIù AGGIORNATO (sempre remoto)');
        emit(ThemeSynched(theme: remoteTheme));
      });
    });
  }
}
