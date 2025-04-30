import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/i_local_storage.dart';

@Injectable(as: ILocalStorage)
class Prefs implements ILocalStorage {
  final SharedPreferences _prefs;

  Prefs({required SharedPreferences sharedPreferencesInstance})
    : _prefs = sharedPreferencesInstance;

  @override
  Future<bool> getBool(String key) async => _prefs.getBool(key) ?? false;

  @override
  Future<double> getDouble(String key) async => _prefs.getDouble(key) ?? 0;

  @override
  Future<int> getInt(String key) async => _prefs.getInt(key) ?? 0;

  @override
  Future<List<String>> getListString(String key) async =>
      _prefs.getStringList(key) ?? [];

  @override
  Future<String> getString(String key) async => _prefs.getString(key) ?? '';

  @override
  Future<void> clear() async => _prefs.clear();

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> setBool(String key, {required bool value}) =>
      _prefs.setBool(key, value);

  @override
  Future<void> setDouble(String key, {required double value}) =>
      _prefs.setDouble(key, value);

  @override
  Future<void> setInt(String key, {required int value}) =>
      _prefs.setInt(key, value);

  @override
  Future<void> setListString(String key, {required List<String> value}) =>
      _prefs.setStringList(key, value);

  @override
  Future<void> setString(String key, {required String value}) =>
      _prefs.setString(key, value);
}
