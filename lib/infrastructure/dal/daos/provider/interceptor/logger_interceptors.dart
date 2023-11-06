import '../../../../../utils/dio_logger.dart';

PrettyDioLogger prettyLogger() {
  return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90);
}
