import 'package:get_storage/get_storage.dart';

class AppPreference {
  final _storage = GetStorage();
  final String _accessTokenKey = 'access_token';
  final String _idUser = 'id_user';

  static Future<void> initialize() async {
    await GetStorage.init();
  }

  Future<void> saveAccessToken(String token) async {
    await _storage.write(_accessTokenKey, token);
  }

  Future<void> saveUserId(int id) async {
    await _storage.write(_idUser, id);
  }

  String? getAccessToken() {
    final accessToken = _storage.read(_accessTokenKey);
    if (accessToken != null) {
      return accessToken;
    }
    return null;
  }

  int? getUserId() {
    final idUser = _storage.read(_idUser);
    if (idUser != null) {
      return idUser;
    }
    return null;
  }

  Future<void> clearLocalStorage() async {
    await _storage.remove(_accessTokenKey);
    await _storage.remove(_idUser);
  }
}
