part of 'theme_cubit.dart';

abstract class ThemeState {
  final Theme theme;
  ThemeState({required this.theme});
}

class DefaultThemeState extends ThemeState {
  DefaultThemeState() : super(theme: Theme.defaultTheme());
}

class ThemeSyncingState extends ThemeState {
  ThemeSyncingState({required super.theme});
}

class CustomThemeState extends ThemeState {
  CustomThemeState({required super.theme});
}
