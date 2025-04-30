import 'dart:async';

import 'package:flutter_rick_and_morty_characters/core/presentation/entities_cubit/i_entities_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/domain/repositories/i_characters_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CharactersCubit extends IEntitiesCubit<Character> {
  CharactersCubit({
    required super.logger,
    required super.apiClient,
    required ICharactersRepository characterRepository,
  }) : super(entitiesRepository: characterRepository);

  @PostConstruct(preResolve: true)
  @override
  Future<void> fetchEntities() async => super.fetchEntities();

  @override
  Character fromJson(json) => Character.fromJson(json);
}
