part of 'theme_cubit.dart';

abstract class ThemeState {}

class ThemeSynched extends ThemeState {
  final XmedTheme theme;

  ThemeSynched({required this.theme});
}

class ThemeSyncingState extends ThemeState {
  final XmedTheme currentTheme;
  ThemeSyncingState({required this.currentTheme});
}
