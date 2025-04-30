abstract interface class ILocalStorage {
  Future<String> getString(String key);
  Future<int> getInt(String key);
  Future<double> getDouble(String key);
  Future<List<String>> getListString(String key);
  Future<bool> getBool(String key);

  Future<void> setString(String key, {required String value});
  Future<void> setInt(String key, {required int value});
  Future<void> setDouble(String key, {required double value});
  Future<void> setListString(String key, {required List<String> value});
  Future<void> setBool(String key, {required bool value});

  Future<void> remove(String key);
  Future<void> clear();
}
