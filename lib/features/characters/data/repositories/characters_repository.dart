import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/domain/repositories/i_characters_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ICharactersRepository)
class CharactersRepository extends ICharactersRepository {
  CharactersRepository({required super.localStorage, required super.logger});

  @override
  Character fromJson(json) => Character.fromJson(json);

  @override
  String get storageKey => _CharactersLocalStorageKeys.characters.name;
}

enum _CharactersLocalStorageKeys { characters }
