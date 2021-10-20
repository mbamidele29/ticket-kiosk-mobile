import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_kiosk/core/values/strings.dart';

class LocalSource {
  
  final SharedPreferences _sharedPreferences;

  LocalSource(this._sharedPreferences);

  /// set user authentication token
  Future<bool> setToken(String value) async{
    return _sharedPreferences.setString(KEY_TOKEN, value);
  }

  /// get user authentication token
  Future<String> getToken()async {
    return _sharedPreferences.getString(KEY_TOKEN);
  }

  /// set user refresh token
  Future<bool> setRefreshToken(String value) async{
    return _sharedPreferences.setString(KEY_REFRESH_TOKEN, value);
  }

  /// get user refresh token
  Future<String> getRefreshToken()async {
    return _sharedPreferences.getString(KEY_REFRESH_TOKEN);
  }

  /// set user authentication token expiry date
  Future<bool> setTokenExpiry(String value) async{
    return _sharedPreferences.setString(KEY_TOKEN_EXPIRY, value);
  }

  /// get user authentication token expiry date
  Future<String> getTokenExpiry()async {
    return _sharedPreferences.getString(KEY_TOKEN_EXPIRY);
  }

  /// set user refresh token expiry date
  Future<bool> setRefreshTokenExpiry(String value) async{
    return _sharedPreferences.setString(KEY_REFRESH_TOKEN_EXPIRY, value);
  }

  /// get user refresh token expiry date
  Future<String> getRefreshTokenExpiry()async {
    return _sharedPreferences.getString(KEY_REFRESH_TOKEN_EXPIRY);
  }

  /// set user object
  Future<bool> setUser(String value) async{
    return _sharedPreferences.setString(KEY_USER, value);
  }

  /// get user object
  Future<String> getUser()async {
    return _sharedPreferences.getString(KEY_TOKEN);
  }
}