import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';

class CharacterCardWidget extends StatelessWidget {
  const CharacterCardWidget({
    super.key,
    required this.character,
    this.isFavorite = true,
    this.onTap,
    this.onLikeTap,
  });
  final Character character;
  final bool isFavorite;
  final void Function(Character character)? onTap;
  final void Function(Character character, bool value)? onLikeTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(20);

    return Material(
      elevation: 3,
      borderRadius: borderRadius,
      borderOnForeground: false,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Theme.of(context).primaryColor.withValues(alpha: .3),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(character.image),
          ),
        ),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap != null ? () => onTap?.call(character) : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton.filledTonal(
                  onPressed:
                      onLikeTap == null
                          ? null
                          : () {
                            onLikeTap?.call(character, !isFavorite);
                          },
                  icon: Icon(isFavorite ? Icons.star : Icons.star_outline),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest.withValues(alpha: .7),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    child: Text(
                      character.name,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
