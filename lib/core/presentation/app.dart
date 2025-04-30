import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty_characters/core/app_router/app_router.dart';
import 'package:flutter_rick_and_morty_characters/core/app_theme/app_theme.dart';
import 'package:flutter_rick_and_morty_characters/core/di/di.dart';
import 'package:flutter_rick_and_morty_characters/core/presentation/theme_cubit/theme_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/presentation/cubit/favorite_characters_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter appRouter;
  @override
  void initState() {
    super.initState();
    appRouter = di<AppRouter>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: di()),
        BlocProvider<CharactersCubit>.value(value: di()),
        BlocProvider<FavoriteCharactersCubit>.value(value: di()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final themeData = AppTheme.fromThemeMode(state.themeMode);
          return MaterialApp.router(
            routerConfig: appRouter.config(),
            theme: themeData,
          );
        },
      ),
    );
  }
}
