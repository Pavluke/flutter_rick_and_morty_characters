import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty_characters/core/data/enums/theme_mode.dart';

class AppTheme {
  AppTheme._();
  static ThemeData _getTheme(Brightness brightness) => ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: brightness,
    ),
  );

  static ThemeData get light => _getTheme(Brightness.light);
  static ThemeData get dark => _getTheme(Brightness.dark);
  static ThemeData fromThemeMode(AppThemeMode mode) => switch (mode) {
    AppThemeMode.system => light,
    AppThemeMode.light => light,
    AppThemeMode.dark => dark,
  };
}
