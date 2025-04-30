import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_theme_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/enums/theme_mode.dart';

part 'theme_state.dart';

@Injectable()
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required IThemeRepository themeRepository})
    : _themeRepository = themeRepository,
      super(ThemeState());

  final IThemeRepository _themeRepository;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final value = await _themeRepository.getThemeMode();
    final themeMode = AppThemeMode.values.firstWhere((e) => e.name == value);
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    await _themeRepository.setThemeMode(mode.name);
    emit(state.copyWith(themeMode: mode));
  }
}
