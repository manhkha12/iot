import 'package:shared_preferences/shared_preferences.dart';

const String _tokenKey = 'family_4_0_app.access_token';
const String _releaseLocationPermissionKey = 'family_4_0_app.release_location_permission';

class AppProvider {
  final SharedPreferences _preferences;

  AppProvider(this._preferences);

  String? _accessToken;

  String? get accessToken {
    return _accessToken ?? _preferences.getString(_tokenKey);
  }

  bool get hasAccessToken => accessToken?.isNotEmpty ?? false;

  Future<void> setAccessToken(String? value) async {
    _accessToken = value;
    await _preferences.setString(_tokenKey, value ?? '');
  }

  bool get isReleaseLocationPermission {
    return _preferences.getBool(_releaseLocationPermissionKey) ?? false;
  }

  Future<void> releaseLocationPermission() async {
    await _preferences.setBool(_releaseLocationPermissionKey, true);
  }
}
