import 'dart:io';

import 'package:dailyremember/utils/preference/app_preference.dart';
import 'package:dio/dio.dart';

// import '../../../modules/auth/session/session_manager.dart';

InterceptorsWrapper headerInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers[HttpHeaders.contentTypeHeader] = 'application/json';

      var accessToken = AppPreference().getAccessToken();
      if (accessToken != null) {
        options.headers[HttpHeaders.authorizationHeader] =
            'Bearer $accessToken';
      }

      return handler.next(options);
    },
    onResponse: (response, handler) {
      return handler.next(response);
    },
    onError: (err, handler) {
      return handler.next(err);
    },
  );
}
