import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_local_storage.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_theme_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IThemeRepository)
class ThemeRepository implements IThemeRepository {
  final ILocalStorage _localStorage;

  ThemeRepository({required ILocalStorage localStorage})
    : _localStorage = localStorage;

  @override
  Future<String> getThemeMode() async {
    final value = await _localStorage.getString(
      _LocalStorageKeys.themeMode.name,
    );
    return value.isEmpty ? 'system' : value;
  }

  @override
  Future<void> setThemeMode(String mode) async {
    await _localStorage.setString(
      _LocalStorageKeys.themeMode.name,
      value: mode,
    );
  }
}

enum _LocalStorageKeys { themeMode }
