import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_entities_repository.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart'
    show Character;

abstract class ICharactersRepository extends IEntitiesRepository<Character> {
  ICharactersRepository({required super.localStorage, required super.logger});
}
