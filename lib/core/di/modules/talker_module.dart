import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

@module
abstract class TalkerModule {
  Talker get talker => TalkerFlutter.init(settings: TalkerSettings());
}
