import 'dart:convert';

import 'package:ticket_kiosk/core/datasource/local_source.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/core/entities/user.dart';
import 'package:ticket_kiosk/core/validators/validator.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/features/create_account/domain/register_repository.dart';
import 'package:ticket_kiosk/features/login/domain/login_repository.dart';

class RegisterService {
  final IRegisterRepository repository;

  RegisterService(this.repository);

  Future<KioskMessage> call(String firstName, String lastName, email, String phoneNumber) async{
    String error=validate(firstName, lastName, email, phoneNumber);
    if(error!=null)
      return KioskMessage(status: false, message: error, data: null);

    final KioskResponse response= await repository(firstName, lastName, email, phoneNumber);
    assert(response!=null);
    if(response.status){
      try{        
        return KioskMessage(status: true, message: response.message, data: null);
      }catch(err){
        return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
      }
    }
    return response;
  }

  String validate(String firstName, String lastName, email, String phoneNumber){
    if(!isNameValid(firstName))return ERROR_INVALID_FIRST_NAME;
    if(!isNameValid(lastName))return ERROR_INVALID_LAST_NAME;
    if(!isEmailValid(email))return ERROR_INVALID_EMAIL;
    if(!isNameValid(phoneNumber))return ERROR_INVALID_PHONE_NUMBER;
    return null;
  }
}
