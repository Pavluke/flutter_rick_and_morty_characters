import 'dart:convert';

import 'package:flutter_rick_and_morty_characters/core/data/models/base_entity.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_local_storage.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_logger.dart';

abstract class IEntitiesRepository<T extends BaseEntity> {
  final ILocalStorage _localStorage;

  IEntitiesRepository({
    required ILocalStorage localStorage,
    required ILogger logger,
  }) : _localStorage = localStorage;

  Future<void> clear() => _localStorage.remove(storageKey);

  Future<List<T>> getAllEntities() async => (await _getMap()).values.toList();

  Future<void> update(T entity) async {
    final localEntities = await _getMap();

    Map<String, Map<String, dynamic>> localMap = Map.fromIterables(
      localEntities.keys,
      localEntities.values.map((e) => e.toJson()),
    );
    final Map<String, Map<String, dynamic>> entry = {
      '${entity.id}': entity.toJson(),
    };
    localMap.addAll(entry);
    final json = jsonEncode(localMap);
    await _localStorage.setString(storageKey, value: json);
  }

  Future<void> updateAll(List<T> entities) async {
    final localEntities = await _getMap();

    Map<String, Map<String, dynamic>> localMap = Map.fromIterables(
      localEntities.keys,
      localEntities.values.map((e) => e.toJson()),
    );
    final keys = entities.map((e) => '${e.id}');
    final values = entities.map((e) => e.toJson());
    final Map<String, Map<String, dynamic>> map = Map.fromIterables(
      keys,
      values,
    );
    localMap.addAll(map);
    final json = jsonEncode(localMap);
    await _localStorage.setString(storageKey, value: json);
  }

  Future<Map<String, T>> _getMap() async {
    final json = await _localStorage.getString(storageKey);
    if (json.isEmpty) {
      return {};
    }
    final map = jsonDecode(json) as Map<String, dynamic>;
    final values = map.values.map(fromJson);
    return Map.fromIterables(map.keys, values);
  }

  T fromJson(dynamic json);

  String get storageKey;
}
