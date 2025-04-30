// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty_characters/core/di/di.dart';
import 'package:flutter_rick_and_morty_characters/features/character/presentation/cubit/character_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/presentation/cubit/favorite_characters_cubit.dart';

@RoutePage()
class CharacterScreen extends StatelessWidget implements AutoRouteWrapper {
  const CharacterScreen({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final expandedHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<CharacterCubit, CharacterState>(
        builder:
            (context, state) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    onPressed: context.pop,
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  pinned: true,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      final fraction =
                          math.max(
                            0,
                            constraints.biggest.height - kToolbarHeight,
                          ) /
                          (expandedHeight - kToolbarHeight);

                      final padding = EdgeInsets.only(
                        left: math.max(0, 48 * (1 - fraction)),
                      );

                      return FlexibleSpaceBar(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: padding,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceContainerHighest
                                              .withValues(alpha: .7 * fraction),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          child: Text(
                                            character.name,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Builder(
                                builder: (context) {
                                  final isFavorite = context
                                      .watch<FavoriteCharactersCubit>()
                                      .state
                                      .favorites
                                      .contains(character);
                                  return IconButton.filledTonal(
                                    padding: EdgeInsets.zero,
                                    onPressed:
                                        () async => await context
                                            .read<FavoriteCharactersCubit>()
                                            .onLikedTap(character, !isFavorite),
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.star
                                          : Icons.star_outline,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        background: CachedNetworkImage(
                          imageUrl: character.image,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  expandedHeight: expandedHeight,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <_Text>[
                      _Text(title: 'Gender', value: character.gender),
                      _Text(title: 'Type', value: character.type),
                      _Text(title: 'Species', value: character.species),
                      _Text(title: 'Status', value: character.status),
                      _Text(
                        title: 'Created',
                        value: character.created.toIso8601String(),
                      ),
                      _Text(
                        title: 'Origin location',
                        value: character.origin.name,
                      ),
                      _Text(
                        title: 'Last location',
                        value: character.location.name,
                      ),
                    ]..removeWhere((t) => t.value.isEmpty),
                  ),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 20)),
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Episodes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => FilledButton.tonal(
                        onPressed: () {},
                        child: Text(
                          character.episodeIDs.elementAt(index).toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      childCount: character.episode.length,
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider(create: (_) => CharacterCubit(logger: di()), child: this);
}

class _Text extends StatelessWidget {
  const _Text({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            children: [TextSpan(text: title), TextSpan(text: ': ')],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: value),
        ],
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
