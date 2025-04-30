// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty_characters/core/app_router/app_router.dart';
import 'package:flutter_rick_and_morty_characters/core/presentation/entities_cubit/entities_cubit_status.dart';
import 'package:flutter_rick_and_morty_characters/core/presentation/entities_cubit/i_entities_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character_filter.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/presentation/widgets/character_filter_dialog.dart';
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/presentation/cubit/favorite_characters_cubit.dart';
import 'package:flutter_rick_and_morty_characters/ui/cards/cards.dart';
import 'package:flutter_rick_and_morty_characters/ui/ui.dart';

@RoutePage()
class CharactersScreen extends StatelessWidget implements AutoRouteWrapper {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharactersCubit, EntitiesState<Character>>(
      listener: _onListen,
      buildWhen: _canBuild,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: state.status.maybeWhen(
              loading: _buildProgressIndicator,
              orElse:
                  () =>
                      state.entities.isNotEmpty
                          ? Scaffold(
                            floatingActionButton: SizedBox.square(
                              dimension: kBottomNavigationBarHeight,
                              child: IconButton.filled(
                                onPressed: () async {
                                  final filter = await showAdaptiveDialog<
                                    CharacterFilter?
                                  >(
                                    context: context,
                                    builder:
                                        (context) => CharacterFilterDialog(
                                          filter:
                                              state.filter as CharacterFilter?,
                                        ),
                                  );

                                  if (filter != null) {
                                    if (context.mounted) {
                                      context
                                          .read<CharactersCubit>()
                                          .setFilters(filter);
                                    }
                                  }
                                },

                                icon: Icon(
                                  state.filter != null
                                      ? Icons.filter_alt
                                      : Icons.filter_alt_outlined,
                                ),
                              ),
                            ),
                            body: _buildGridView(context, state),
                          )
                          : Scaffold(
                            body: SafeArea(
                              child: EmptyEntityList(title: 'List is empty!'),
                            ),
                          ),
            ),
          ),
        );
      },
    );
  }

  bool _canBuild(
    EntitiesState<Character> previous,
    EntitiesState<Character> current,
  ) =>
      previous.status.isLoading && current.status.isLoaded ||
      previous.filter != current.filter;

  void _onListen(BuildContext context, EntitiesState<Character> state) =>
      state.status.whenOrNull(
        error:
            () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMsg))),
      );

  Center _buildProgressIndicator() =>
      Center(child: CircularProgressIndicator());

  AppGridView _buildGridView(
    BuildContext context,
    EntitiesState<Character> state,
  ) {
    return AppGridView(
      onRefresh:
          () async => await context.read<CharactersCubit>().fetchEntities(),
      onScrollEnd: () => context.read<CharactersCubit>().fetchMoreEntities(),
      itemCount:
          state.paginationInfo.canLoadMore
              ? state.entities.length +
                  (MediaQuery.orientationOf(context) == Orientation.portrait
                      ? 2
                      : 3)
              : state.entities.length,
      builder: (context, index) {
        if (state.entities.length > index) {
          final character = state.entities.elementAt(index);
          return CharacterCardWidget(
            character: character,
            isFavorite: context
                .watch<FavoriteCharactersCubit>()
                .state
                .favorites
                .contains(character),
            onTap:
                (character) =>
                    context.pushRoute(CharacterRoute(character: character)),
            onLikeTap: context.read<FavoriteCharactersCubit>().onLikedTap,
          );
        }
        return CardShimmer();
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => this;
}
