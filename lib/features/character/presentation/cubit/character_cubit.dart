import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_logger.dart';
import 'package:injectable/injectable.dart';

part 'character_state.dart';

@Injectable()
class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit({required ILogger logger})
    : _logger = logger,
      super(CharacterState());
  // ignore: unused_field
  final ILogger _logger;
}
