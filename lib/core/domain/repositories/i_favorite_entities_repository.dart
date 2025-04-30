import 'dart:convert';

import 'package:flutter_rick_and_morty_characters/core/data/models/base_entity.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_local_storage.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_logger.dart';

abstract class IFavoriteEntitiesRepository<E extends BaseEntity> {
  final ILocalStorage _localStorage;

  IFavoriteEntitiesRepository({
    required ILocalStorage localStorage,
    required ILogger logger,
  }) : _localStorage = localStorage;

  List<E>? _entities;

  List<E> get entities => _entities ?? [];

  Future<List<E>> add(E entity) async {
    entities.add(entity);
    await _update();
    return entities;
  }

  Future<void> clear() async {
    _entities = [];
    _localStorage.remove(storageKey);
  }

  Future<List<E>> remove(E entity) async {
    entities.removeWhere((c) => c.id == entity.id);
    await _update();
    return entities;
  }

  Future<List<E>> init() async {
    if (_entities == null) {
      final json = await _localStorage.getListString(storageKey);
      final result = json.map((e) => fromJson(jsonDecode(e))).toList();
      _entities = result;
    }
    return entities;
  }

  Future<void> _update() async {
    final json =
        entities
            .map((c) => c.toJson())
            .map((object) => jsonEncode(object))
            .toList();
    _localStorage.setListString(storageKey, value: json);
  }

  E fromJson(dynamic json);

  String get storageKey;
}
