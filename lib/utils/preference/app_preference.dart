import 'package:get_storage/get_storage.dart';

class AppPreference {
  final _storage = GetStorage();
  final String _accessTokenKey = 'access_token';

  static Future<void> initialize() async {
    await GetStorage.init();
  }

  Future<void> saveAccessToken(String token) async {
    await _storage.write(_accessTokenKey, token);
  }

  String? getAccessToken() {
    final accessToken = _storage.read(_accessTokenKey);
    if (accessToken != null) {
      return accessToken;
    }
    return null;
  }

  Future<void> clearLocalStorage() async {
    await _storage.remove(_accessTokenKey);
  }
}
