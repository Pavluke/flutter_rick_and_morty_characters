import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class AppDioConfigurer {
  const AppDioConfigurer();

  /// Creating a client [Dio].
  Dio create([List<Interceptor>? interceptors]) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = 'https://rickandmortyapi.com/api'
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout
      ..headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();

      return client;
    };

    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }

    return dio;
  }
}
