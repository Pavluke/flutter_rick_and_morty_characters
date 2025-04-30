import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty_characters/core/app_router/app_router.dart';
import 'package:flutter_rick_and_morty_characters/core/presentation/favorite_entities_cubit/favorite_entities_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/presentation/cubit/favorite_characters_cubit.dart';
import 'package:flutter_rick_and_morty_characters/ui/cards/cards.dart';
import 'package:flutter_rick_and_morty_characters/ui/ui.dart';

@RoutePage()
class FavoriteCharactersScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const FavoriteCharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      FavoriteCharactersCubit,
      FavoriteEntitiesState<Character>
    >(
      listener:
          (context, state) => state.status.whenOrNull(
            error:
                () => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMsg))),
          ),

      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child:
                state.status.whenOrNull(
                  loading: () => Center(child: CircularProgressIndicator()),
                  loaded:
                      () =>
                          state.favorites.isNotEmpty
                              ? AppGridView(
                                builder:
                                    (context, index) => CharacterCardWidget(
                                      character: state.favorites.elementAt(
                                        index,
                                      ),
                                      onLikeTap:
                                          context
                                              .read<FavoriteCharactersCubit>()
                                              .onLikedTap,
                                      onTap:
                                          (character) => context.pushRoute(
                                            CharacterRoute(
                                              character: character,
                                            ),
                                          ),
                                    ),
                                itemCount: state.favorites.length,
                              )
                              : EmptyEntityList(title: 'List is empty!'),
                ) ??
                SizedBox(),
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => this;
}
