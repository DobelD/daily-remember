import 'package:dio/dio.dart';
import 'package:get/get.dart';

InterceptorsWrapper timeoutInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      options.connectTimeout = 8.seconds;
      options.receiveTimeout = 8.seconds;
      options.sendTimeout = 8.seconds;

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
