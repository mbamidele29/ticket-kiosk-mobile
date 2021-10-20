import 'dart:convert';
import 'dart:io';

import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/services/file_upload_service.dart';
import 'package:ticket_kiosk/core/values/apis.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/features/create_event/domain/create_event_repository.dart';


class CreateEventService {
  final ICreateEventRepository repository;

  CreateEventService(this.repository);
  
  Future<KioskMessage> call(Event event) async{
    String validate=_validateEvent(event);
    if(validate!=null)
      return KioskMessage(status: false, message: validate, data: null);
    try{
      Map eventMap=event.toJSON();
      if(
        eventMap.containsKey('banner') && 
        eventMap['banner']!=null && 
        eventMap['banner'].toString().isNotEmpty
      ){
        KioskMessage response=await serviceLocator<FileUploadService>()(
          API_EVENT_UPLOAD, 
          'banner', File(eventMap['banner'])
        );
        if(response==null)
          return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
        if(!response.status)
          return response;

        eventMap['banner']=response.data['path'];
        print(jsonEncode(eventMap));
        response=await repository(eventMap);
        return response;
        
      }
        return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
    }catch(err){
      print(err);
      return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
    }
  }

  String _validateEvent(Event event) {
    if(event.title.isEmpty)return ERROR_EVENT_TITLE_REQUIRED;
    if(event.description.isEmpty)return ERROR_EVENT_DESCRIPTION_REQUIRED;
    if(event.eventDates.isEmpty)return ERROR_EVENT_DATE_REQUIRED;
    if(event.tickets.isEmpty)return ERROR_EVENT_TICKETS_REQUIRED;
    if(event.eventType.isEmpty)return ERROR_EVENT_TYPE_REQUIRED;
    if(event.placeId==null || event.address==null || event.placeId.isEmpty || event.address.isEmpty)return ERROR_EVENT_ADDRESS_REQUIRED;
    if(event.category.id.isEmpty || event.category.name.isEmpty)return ERROR_EVENT_ADDRESS_REQUIRED;
    return null;
  }
}