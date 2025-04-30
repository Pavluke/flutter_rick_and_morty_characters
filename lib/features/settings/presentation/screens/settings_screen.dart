import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty_characters/core/data/enums/theme_mode.dart';
import 'package:flutter_rick_and_morty_characters/core/di/di.dart';
import 'package:flutter_rick_and_morty_characters/core/presentation/theme_cubit/theme_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/presentation/cubit/favorite_characters_cubit.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(8),

          children: [
            SwitchListTile.adaptive(
              tileColor: Theme.of(context).colorScheme.onTertiary,
              title: Text('Dark theme'),
              value: context.watch<ThemeCubit>().state.themeMode.isDark,
              onChanged:
                  (value) => context.read<ThemeCubit>().setThemeMode(
                    value ? AppThemeMode.dark : AppThemeMode.light,
                  ),
            ),
            ListTile(
              tileColor: Theme.of(context).colorScheme.onTertiary,
              title: Text('Clear cache'),
              onTap:
                  () async => await Future.wait([
                    context.read<CharactersCubit>().clearCache(),
                    context.read<FavoriteCharactersCubit>().clear(),
                  ]),
            ),
            ListTile(
              tileColor: Theme.of(context).colorScheme.onTertiary,
              title: Text('Logs'),
              onTap:
                  () => context.router.pushWidget(
                    TalkerScreen(talker: di<Talker>()),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
