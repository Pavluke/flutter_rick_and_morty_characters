import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_favorite_entities_repository.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';

abstract class IFavoriteCharactersRepository
    extends IFavoriteEntitiesRepository<Character> {
  IFavoriteCharactersRepository({
    required super.localStorage,
    required super.logger,
  });
}
