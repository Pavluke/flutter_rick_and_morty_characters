// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CharacterScreen]
class CharacterRoute extends PageRouteInfo<CharacterRouteArgs> {
  CharacterRoute({
    Key? key,
    required Character character,
    List<PageRouteInfo>? children,
  }) : super(
         CharacterRoute.name,
         args: CharacterRouteArgs(key: key, character: character),
         initialChildren: children,
       );

  static const String name = 'CharacterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CharacterRouteArgs>();
      return WrappedRoute(
        child: CharacterScreen(key: args.key, character: args.character),
      );
    },
  );
}

class CharacterRouteArgs {
  const CharacterRouteArgs({this.key, required this.character});

  final Key? key;

  final Character character;

  @override
  String toString() {
    return 'CharacterRouteArgs{key: $key, character: $character}';
  }
}

/// generated route for
/// [CharactersScreen]
class CharactersRoute extends PageRouteInfo<void> {
  const CharactersRoute({List<PageRouteInfo>? children})
    : super(CharactersRoute.name, initialChildren: children);

  static const String name = 'CharactersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CharactersScreen());
    },
  );
}

/// generated route for
/// [FavoriteCharactersScreen]
class FavoriteCharactersRoute extends PageRouteInfo<void> {
  const FavoriteCharactersRoute({List<PageRouteInfo>? children})
    : super(FavoriteCharactersRoute.name, initialChildren: children);

  static const String name = 'FavoriteCharactersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const FavoriteCharactersScreen());
    },
  );
}

/// generated route for
/// [RootScreen]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RootScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}
