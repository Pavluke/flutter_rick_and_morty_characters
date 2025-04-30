import 'package:flutter_rick_and_morty_characters/core/presentation/favorite_entities_cubit/favorite_entities_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/domain/repositories/i_favorite_characters_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class FavoriteCharactersCubit extends IFavoriteEntitiesCubit<Character> {
  FavoriteCharactersCubit(IFavoriteCharactersRepository super._repository);

  @PostConstruct(preResolve: true)
  @override
  Future<void> init() => super.init();
}
