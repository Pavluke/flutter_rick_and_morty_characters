import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty_characters/core/di/di.dart';
import 'package:flutter_rick_and_morty_characters/core/presentation/app.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppRunner {
  static Future<void> run() async {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await configureDependencies();
        runApp(const App());
      },
      (Object error, StackTrace stack) {
        di<Talker>().handle(error, stack, 'Uncaught app exception');
      },
    );
  }
}
