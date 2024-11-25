import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:iot/data/remote/handler/api_handler.dart';
import 'package:iot/data/remote/interceptors/auth_interceptor.dart';
import 'package:iot/data/remote/interceptors/error_interceptor.dart';
import 'package:iot/data/remote/user_api.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../app_config.dart';

dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}

Future parseJson(String text) {
  return compute(_parseAndDecode, text);
}

Dio _buildDio(AppConfig config, List<Interceptor> interceptors) {
  final dio = Dio()
    ..options.baseUrl = config.baseApiUrl
    ..options.contentType = 'application/json'
    ..interceptors.addAll(interceptors);
  (dio.transformer as BackgroundTransformer).jsonDecodeCallback = parseJson;
  return dio;
}

Future<void> registerRemoteModules(GetIt getIt) async {
  getIt
    ..registerLazySingleton(() => AuthInterceptor(getIt()))
    ..registerLazySingleton(() => ErrorInterceptor(getIt()))
    ..registerLazySingleton(() => LogInterceptor(
          requestBody: false,
          request: false,
          responseBody: kDebugMode,
          requestHeader: false,
          responseHeader: false,
        ))
    ..registerLazySingleton(() {
      final _interceptors = <Interceptor>[
        getIt<AuthInterceptor>(),
        getIt<LogInterceptor>(),
        getIt<ErrorInterceptor>(),
      ];
      return ApiHandlerImpl(_buildDio(getIt(), _interceptors));
    })
    ..registerLazySingleton(() => UserApi(getIt<ApiHandlerImpl>()));
}
