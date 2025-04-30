enum AppThemeMode { light, dark, system }

extension ThemeModeX on AppThemeMode {
  /// Returns `true` if the enum value is [AppThemeMode.light].
  bool get isLight => this == AppThemeMode.light;

  /// Returns `true` if the enum value is [AppThemeMode.dark].
  bool get isDark => this == AppThemeMode.dark;

  /// Returns `true` if the enum value is [AppThemeMode.system].
  bool get isSystem => this == AppThemeMode.system;

  /// Executes a function based on the enum value.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value.
  R when<R>({
    required R Function() light,
    required R Function() dark,
    required R Function() system,
  }) => switch (this) {
    AppThemeMode.light => light(),
    AppThemeMode.dark => dark(),
    AppThemeMode.system => system(),
  };

  /// Executes a function based on the enum value, with a fallback.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  /// [orElse] is called if the corresponding function is null.
  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? light,
    R Function()? dark,
    R Function()? system,
  }) => switch (this) {
    AppThemeMode.light => light?.call() ?? orElse(),
    AppThemeMode.dark => dark?.call() ?? orElse(),
    AppThemeMode.system => system?.call() ?? orElse(),
  };

  /// Executes a function based on the enum value, returning null if no function is provided.
  ///
  /// [R] is the return type of the functions.
  /// Each function corresponds to an enum value and can be null.
  R? whenOrNull<R>({
    R? Function()? light,
    R? Function()? dark,
    R? Function()? system,
  }) => switch (this) {
    AppThemeMode.light => light?.call(),
    AppThemeMode.dark => dark?.call(),
    AppThemeMode.system => system?.call(),
  };
}
