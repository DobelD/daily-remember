import 'package:get_storage/get_storage.dart';

import '../../domain/core/model/user_model.dart';

class AppPreference {
  final _storage = GetStorage();
  final String _userModelKey = 'user_model';
  final String _accessTokenKey = 'access_token';

  static Future<void> initialize() async {
    await GetStorage.init();
  }

  Future<void> saveUserModel(UserModel userModel) async {
    await _storage.write(_userModelKey, userModel.toJson());
  }

  Future<void> saveAccessToken(String token) async {
    await _storage.write(_accessTokenKey, token);
  }

  UserModel? getUserModel() {
    final userData = _storage.read(_userModelKey);
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  String? getAccessToken() {
    final accessToken = _storage.read(_accessTokenKey);
    if (accessToken != null) {
      return accessToken;
    }
    return null;
  }

  Future<void> clearLocalStorage() async {
    // await _storage.remove(_userModelKey);
    await _storage.remove(_accessTokenKey);
  }
}
