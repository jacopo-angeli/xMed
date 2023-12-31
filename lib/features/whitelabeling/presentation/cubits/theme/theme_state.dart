// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {
  final XmedTheme currentTheme;
  const ThemeState({
    required this.currentTheme,
  });
}

class ThemeSynchedState extends ThemeState {
  const ThemeSynchedState({required super.currentTheme});
}

class ThemeSynchingState extends ThemeState {
  const ThemeSynchingState({required super.currentTheme});
}
