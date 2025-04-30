import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty_characters/core/data/models/base_entity.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_favorite_entities_repository.dart';

part 'favorite_entities_cubit_status.dart';
part 'favorite_entities_state.dart';

abstract class IFavoriteEntitiesCubit<E extends BaseEntity>
    extends Cubit<FavoriteEntitiesState<E>> {
  IFavoriteEntitiesCubit(this._repository) : super(FavoriteEntitiesState<E>());

  final IFavoriteEntitiesRepository _repository;

  Future<void> init() async {
    emit(state.copyWith());
    await _repository.init();
    _emitEntities(_repository.entities as List<E>);
  }

  Future<void> onLikedTap(E entity, bool value) async {
    final characters = _repository.entities;
    try {
      characters.firstWhere((c) => c.id == entity.id);
      await _repository.remove(entity);
    } catch (_) {
      await _repository.add(entity);
    }
    _emitEntities(_repository.entities as List<E>);
  }

  Future<void> clear() async {
    await _repository.clear();
    _emitEntities([]);
  }

  void _emitEntities(List<E> entities) {
    emit(
      state.copyWith(
        entities: List.from(entities),
        status: BaseFavoritesCubitStatus.loaded,
      ),
    );
  }
}
