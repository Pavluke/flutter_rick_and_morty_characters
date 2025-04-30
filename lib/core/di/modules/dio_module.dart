import 'package:dio/dio.dart';
import 'package:flutter_rick_and_morty_characters/core/di/di.dart';
import 'package:flutter_rick_and_morty_characters/core/network/app_dio_configurer.dart';
import 'package:flutter_rick_and_morty_characters/core/services/api_client/api_client.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

@module
abstract class DioModule {
  TalkerDioLogger get talkerDioLogger => TalkerDioLogger(
    talker: di<Talker>(),
    settings: const TalkerDioLoggerSettings(
      printRequestHeaders: false,
      printRequestData: false,
      printResponseData: false,
      printResponseHeaders: false,
      printResponseMessage: false,
      printErrorHeaders: false,
    ),
  );

  @singleton
  Dio get dio => AppDioConfigurer().create([talkerDioLogger]);

  @singleton
  ApiClient get apiClient => ApiClient(dio: dio);
}
