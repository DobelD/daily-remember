import 'dart:io';

import 'package:dio/dio.dart';

// import '../../../modules/auth/session/session_manager.dart';

InterceptorsWrapper headerInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers[HttpHeaders.contentTypeHeader] = 'application/json';

      // var accessToken = SessionManager().getSession();
      // if (accessToken.isNotEmpty) {
      //   options.headers[HttpHeaders.authorizationHeader] =
      //       'Bearer $accessToken';
      // }

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
