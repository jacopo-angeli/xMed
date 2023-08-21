import 'package:bloc/bloc.dart';
import '../../../domain/entities/theme.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(DefaultThemeState());

  void themeSynchRequest({required Theme lastTheme}) {
    emit(ThemeSyncingState(theme: lastTheme));
    // Controllo se il tema nel backoffice è lo stesso tema che ho in locale
    // Se si:
    //  Se lastTheme == Theme.defaultTheme()
    //    emit(DeafultThemeState());
    //  Altrimenti
    //    emit(CustomThemeState(lastTheme))
    // Se no:
    //  Se remoteTheme == Theme.defaultTheme()
    //    Elimina tema locale
    //    emit(DeafultThemeState());
    //  Altrimenti
    //    Aggiorno tema locale
    //    emit(CustomThemeState(remoteTheme))
    // ? TBD : Metto un flag default nel Theme?
    // ? TBD : Salvo il tema anche se è default?
    emit(DefaultThemeState());
  }

  void appStartedEvent() {
    // Controllo se ho il tema salvato in locale
    // Tema salvato in locale:
    //      emetto stato di CustomTheme(TemaTrovato)
    // Tema non trovato:
    emit(DefaultThemeState());
  }

  void themeReset() {
    //  Controllo se ho un tema il locale
    //  Tema in locale:
    //    sovrascrivo il tema salvato
    //  update del tema sul backoffice
    emit(DefaultThemeState());
  }

  void themeUpdated({required Theme newTheme}) {
    //  Controllo se ho un tema il locale
    //  Tema in locale:
    //    sovrascrivo il tema salvato
    //  update del tema sul backoffice
    emit(CustomThemeState(theme: newTheme));
  }
}
