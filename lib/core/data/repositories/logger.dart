import 'package:flutter_rick_and_morty_characters/core/domain/repositories/i_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

@Injectable(as: ILogger)
class Logger implements ILogger {
  final Talker _talker;

  Logger({required Talker talker}) : _talker = talker;

  @override
  void debug(message) => _talker.debug(message);

  @override
  void error(message, [Object? exception, StackTrace? stackTrace]) =>
      _talker.error(message, exception, stackTrace);

  @override
  void exception(message, [Object? exception, StackTrace? stackTrace]) =>
      _talker.warning(message, exception, stackTrace);

  @override
  void info(message) => _talker.info(message);
}
