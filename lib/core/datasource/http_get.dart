import 'dart:convert';

import 'package:http/http.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/core/datasource/local_source.dart';

class HttpGet {
  final LocalSource _localSource;

  HttpGet(this._localSource);

  Future<KioskResponse> call(String url) async{
    String token=await _localSource.getToken() ?? '';
    Map<String, String> headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    try{
      Response response=await Client().get(
        Uri.parse(url), 
        headers: headers,
      );
      if(response==null)
        return KioskResponse(
          status: false, 
          message: 'empty response', 
          data: null
        );

      if(response.statusCode==401)
        return KioskResponse(status: false, message: response.body, data: null);

      dynamic body=jsonDecode(response.body);
      return KioskResponse(
        status: body['success'], 
        message: body['message'], 
        data: body['data']
      );
    }catch(err){
      print(err);
      return KioskResponse(
        status: false, 
        message: err.toString(), 
        data: null
      );
    }
  }
}