import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/core/datasource/local_source.dart';
import 'package:ticket_kiosk/core/values/strings.dart';

class HttpPostFile {
  final LocalSource _localSource;

  HttpPostFile(this._localSource);

  Future<KioskResponse> call(String url, String fieldName, File file) async{
    if(file==null || !file.existsSync())return KioskResponse(status: false, message: ERROR_GENERIC, data: null);
    String token=await _localSource.getToken() ?? '';
    
    try{
      final request= MultipartRequest('POST', Uri.parse(url));

      request.headers['Authorization'] = token;
      request.headers["Content-Type"]='multipart/form-data';

      print(file.path.split(".").last);
      request.files.add(
        MultipartFile.fromBytes(
          fieldName,
          file.readAsBytesSync(),
          filename: "test.${file.path.split(".").last}",
          // contentType: MediaType(
          //     "file", "${file.path.split(".").last}"),
        ),
      );
      StreamedResponse response = await request.send();
      if(response==null)
        return KioskResponse(
          status: false, 
          message: 'empty response', 
          data: null
        );

      dynamic body=await response.stream.bytesToString();

      if(response.statusCode==401)
        return KioskResponse(status: false, message: body, data: null);

      body=jsonDecode(body);
      return KioskResponse(
        status: body['success'], 
        message: body['message'], 
        data: body['data']
      );
    }catch(err){
      return KioskResponse(
        status: false, 
        message: ERROR_GENERIC, 
        data: null
      );
    }
  }
}