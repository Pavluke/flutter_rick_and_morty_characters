part of 'theme_cubit.dart';

class ThemeState {
  ThemeState({this.themeMode = AppThemeMode.system});
  final AppThemeMode themeMode;

  ThemeState copyWith({AppThemeMode? themeMode}) =>
      ThemeState(themeMode: themeMode ?? this.themeMode);
}
