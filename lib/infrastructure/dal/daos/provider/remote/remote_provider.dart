import 'package:dio/dio.dart';

import '../../../../../config.dart';
import '../interceptor/header_interceptors.dart';
import '../interceptor/logger_interceptors.dart';
import '../interceptor/timeout_interceptor.dart';

class RemoteProvider {
  static final _dio = Dio(_baseOptions);

  static final _baseOptions = BaseOptions(baseUrl: baseUrl);

  static Dio get client {
    return _dio;
  }

  static String baseUrl =
      ConfigEnvironments.getEnvironments()['url'].toString();

  static void init() {
    _dio.interceptors.add(headerInterceptor());
    _dio.interceptors.add(timeoutInterceptor());
    _dio.interceptors.add(prettyLogger());
  }
}
