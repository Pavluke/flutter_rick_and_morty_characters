abstract interface class IThemeRepository {
  /// Читает название темы из локального хранилища.
  Future<String> getThemeMode();

  /// Записывает тему в локальное хранилище.
  Future<void> setThemeMode(String mode);
}
