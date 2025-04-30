// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_rick_and_morty_characters/core/app_router/app_router.dart'
    as _i648;
import 'package:flutter_rick_and_morty_characters/core/data/repositories/logger.dart'
    as _i768;
import 'package:flutter_rick_and_morty_characters/core/data/repositories/prefs.dart'
    as _i533;
import 'package:flutter_rick_and_morty_characters/core/data/repositories/theme_repository.dart'
    as _i206;
import 'package:flutter_rick_and_morty_characters/core/di/modules/dio_module.dart'
    as _i915;
import 'package:flutter_rick_and_morty_characters/core/di/modules/shared_preferences_module.dart'
    as _i619;
import 'package:flutter_rick_and_morty_characters/core/di/modules/talker_module.dart'
    as _i588;
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_local_storage.dart'
    as _i8;
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_logger.dart'
    as _i914;
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_theme_repository.dart'
    as _i357;
import 'package:flutter_rick_and_morty_characters/core/presentation/theme_cubit/theme_cubit.dart'
    as _i839;
import 'package:flutter_rick_and_morty_characters/core/services/api_client/api_client.dart'
    as _i536;
import 'package:flutter_rick_and_morty_characters/features/character/presentation/cubit/character_cubit.dart'
    as _i937;
import 'package:flutter_rick_and_morty_characters/features/characters/data/repositories/characters_repository.dart'
    as _i810;
import 'package:flutter_rick_and_morty_characters/features/characters/domain/repositories/i_characters_repository.dart'
    as _i6;
import 'package:flutter_rick_and_morty_characters/features/characters/presentation/cubit/characters_cubit.dart'
    as _i13;
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/data/repositories/favorite_characters_repository.dart'
    as _i138;
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/domain/repositories/i_favorite_characters_repository.dart'
    as _i684;
import 'package:flutter_rick_and_morty_characters/features/favorite_characters/presentation/cubit/favorite_characters_cubit.dart'
    as _i498;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart' as _i162;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final talkerModule = _$TalkerModule();
    gh.factory<_i162.TalkerDioLogger>(() => dioModule.talkerDioLogger);
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.factory<_i207.Talker>(() => talkerModule.talker);
    gh.factory<_i648.AppRouter>(() => _i648.AppRouter());
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.singleton<_i536.ApiClient>(() => dioModule.apiClient);
    gh.factory<_i8.ILocalStorage>(
      () =>
          _i533.Prefs(sharedPreferencesInstance: gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i357.IThemeRepository>(
      () => _i206.ThemeRepository(localStorage: gh<_i8.ILocalStorage>()),
    );
    await gh.factoryAsync<_i839.ThemeCubit>(() {
      final i = _i839.ThemeCubit(themeRepository: gh<_i357.IThemeRepository>());
      return i.init().then((_) => i);
    }, preResolve: true);
    gh.factory<_i914.ILogger>(() => _i768.Logger(talker: gh<_i207.Talker>()));
    gh.factory<_i6.ICharactersRepository>(
      () => _i810.CharactersRepository(
        localStorage: gh<_i8.ILocalStorage>(),
        logger: gh<_i914.ILogger>(),
      ),
    );
    gh.factory<_i684.IFavoriteCharactersRepository>(
      () => _i138.FavoriteCharactersRepository(
        localStorage: gh<_i8.ILocalStorage>(),
        logger: gh<_i914.ILogger>(),
      ),
    );
    gh.factory<_i937.CharacterCubit>(
      () => _i937.CharacterCubit(logger: gh<_i914.ILogger>()),
    );
    await gh.factoryAsync<_i13.CharactersCubit>(() {
      final i = _i13.CharactersCubit(
        logger: gh<_i914.ILogger>(),
        apiClient: gh<_i536.ApiClient>(),
        characterRepository: gh<_i6.ICharactersRepository>(),
      );
      return i.fetchEntities().then((_) => i);
    }, preResolve: true);
    await gh.factoryAsync<_i498.FavoriteCharactersCubit>(() {
      final i = _i498.FavoriteCharactersCubit(
        gh<_i684.IFavoriteCharactersRepository>(),
      );
      return i.init().then((_) => i);
    }, preResolve: true);
    return this;
  }
}

class _$DioModule extends _i915.DioModule {}

class _$SharedPreferencesModule extends _i619.SharedPreferencesModule {}

class _$TalkerModule extends _i588.TalkerModule {}
