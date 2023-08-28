part of 'theme_cubit.dart';

abstract class ThemeState {
  final XmedTheme theme;

  const ThemeState({required this.theme});
}

class ThemeSynched extends ThemeState {
  const ThemeSynched({required super.theme});
}

class ThemeSyncingState extends ThemeState {
  const ThemeSyncingState({required super.theme});
}
