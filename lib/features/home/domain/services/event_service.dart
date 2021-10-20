import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/features/home/domain/repositories/event_repository.dart';

class EventService {
  final IEventRepository repository;

  EventService(this.repository);

  Future<KioskMessage> call() async{
    KioskResponse response=await repository();
    try {
      if(response==null)return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
      if(!response.status)return KioskMessage(status: false, message: response.message, data: []);
      List<Event> events= [];
      List.from(
        response.data
      ).forEach((event){
          events.add(Event.fromJSON(event));
        }
      );
      return KioskMessage(status: true, message: '', data: events);
    }catch(err){
      print(err);
      return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
    }
  }

  Future<KioskMessage> collections() async{
    KioskResponse response=await repository.collections();
    try {
      if(response==null)return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
      if(!response.status)return KioskMessage(status: false, message: response.message, data: []);
      List<Event> events= [];
      List.from(
        response.data
      ).forEach((event){
          events.add(Event.fromJSON(event));
        }
      );
      return KioskMessage(status: true, message: '', data: events);
    }catch(err){
      print(err);
      return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
    }
  }

  Future<KioskMessage> getOne(String eventId) async{
    KioskResponse response=await repository.getOne(eventId);
    try {
      if(response==null)return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
      return response;
    }catch(err){
      return KioskMessage(status: false, message: ERROR_GENERIC, data: null);
    }
  }
}