import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/domain/repositories/i_favorite_characters_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IFavoriteCharactersRepository)
class FavoriteCharactersRepository extends IFavoriteCharactersRepository {
  FavoriteCharactersRepository({
    required super.localStorage,
    required super.logger,
  });

  @override
  Character fromJson(json) => Character.fromJson(json);

  @override
  String get storageKey =>
      _FavoriteCharactersLocalStorageKeys.favoriteCharacters.name;
}

enum _FavoriteCharactersLocalStorageKeys { favoriteCharacters }
