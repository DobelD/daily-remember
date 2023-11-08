import 'package:dailyremember/domain/core/model/params/login_param.dart';

import '../model/params/register_param.dart';

abstract class AuthRepository {
  Future<String?> registerWithApi(RegisterParam param);
  Future<bool?> login(LoginParam param);
  Future<bool?> logout(String param);
}
