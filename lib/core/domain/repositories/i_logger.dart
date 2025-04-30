import 'package:flutter_rick_and_morty_characters/core/di/di.dart';

ILogger get logger => di<ILogger>();

abstract interface class ILogger {
  void debug(message);
  void info(message);
  void error(message, [Object? exception, StackTrace? stackTrace]);
  void exception(message, [Object? exception, StackTrace? stackTrace]);
}
