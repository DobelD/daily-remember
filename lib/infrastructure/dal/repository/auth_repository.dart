import 'package:dailyremember/domain/core/interfaces/auth_repository.dart';
import 'package:dailyremember/domain/core/model/params/login_param.dart';
import 'package:dio/dio.dart';

import '../../../domain/core/model/params/register_param.dart';
import '../../../utils/preference/app_preference.dart';
import '../daos/provider/remote/remote_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl() {
    RemoteProvider.init();
  }
  @override
  Future<String?> registerWithApi(RegisterParam param) async {
    try {
      final response = await RemoteProvider.client
          .post('auth/register', data: param.toMap());
      if (response.statusCode == 201) {
        return "Success registered!";
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<bool?> login(LoginParam param) async {
    try {
      final response =
          await RemoteProvider.client.post('auth/login', data: param.toMap());
      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        AppPreference().saveAccessToken(token);
        return true;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<bool?> logout(String param) async {
    try {
      final response = await RemoteProvider.client.post('auth/logout',
          options: Options(headers: {'Authorization': "Bearer $param"}));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
