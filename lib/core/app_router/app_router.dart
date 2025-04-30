import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_rick_and_morty_characters/core/app_router/route_path.dart';
import 'package:flutter_rick_and_morty_characters/features/character/presentation/screens/character_screen.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/data/models/character.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/presentation/screens/characters_screen.dart';
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/presentation/screens/favorites_screen.dart';
import 'package:flutter_rick_and_morty_characters/features/root/presentation/screens/root_screen.dart';
import 'package:flutter_rick_and_morty_characters/features/settings/presentation/screens/settings_screen.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@Injectable()
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootRoute.page,
      path: RoutePath.root,
      children: [
        AutoRoute(
          initial: true,
          page: CharactersRoute.page,
          path: RoutePath.characters,
        ),

        AutoRoute(
          page: FavoriteCharactersRoute.page,
          path: RoutePath.characters,
        ),
      ],
    ),
    AutoRoute(page: SettingsRoute.page, path: RoutePath.settings),
    AutoRoute(page: CharacterRoute.page, path: RoutePath.character),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
