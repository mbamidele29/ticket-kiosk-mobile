import 'dart:convert';

import 'package:ticket_kiosk/core/datasource/local_source.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/core/entities/user.dart';
import 'package:ticket_kiosk/core/validators/validator.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/features/login/domain/login_repository.dart';

class LoginService {
  final LocalSource _localSource;
  final ILoginRepository repository;

  LoginService(this._localSource, this.repository);

  Future<KioskMessage> call(String email, String password) async{
    String error=validate(email, password);
    if(error!=null)return KioskMessage(status: false, message: error, data: null);

    final KioskResponse response= await repository(email, password);
    assert(response!=null);
    if(response.status){
      // extract user from response
      try{
        final User user=User.fromJSON(response.data['user']);
        await _localSource.setUser(jsonEncode(user.toJSON()));
        await _localSource.setToken(response.data['token']);
        await _localSource.setTokenExpiry(DateTime.now().add(
          Duration(seconds: response.data['expiresIn'])
        ).toString());

        await _localSource.setRefreshToken(response.data['refreshToken']);
        await _localSource.setRefreshTokenExpiry(DateTime.now().add(
          Duration(seconds: response.data['refreshExpiresIn'])
        ).toString());
        
        return KioskMessage(status: true, message: response.message, data: null);
      }catch(err){
        return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
      }
    }
    return response;
  }

  String validate(String email, String password){
    if(!isEmailValid(email))return ERROR_INVALID_EMAIL;
    if(!isPasswordValid(password))return ERROR_INVALID_PASSWORD;
    return null;
  }
}
