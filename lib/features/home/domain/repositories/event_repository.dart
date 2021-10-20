import 'package:ticket_kiosk/core/datasource/http_get.dart';
import 'package:ticket_kiosk/core/datasource/http_post.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/core/values/apis.dart';

abstract class IEventRepository {
  Future<KioskResponse> call();
  Future<KioskResponse> collections();
  Future<KioskResponse> getOne(String eventId);
}

class EventRepositoryImpl implements IEventRepository {
  final HttpGet client;

  EventRepositoryImpl(this.client);
  @override
  Future<KioskResponse> call() async{
    return await client(API_EVENT);
  }

  @override
  Future<KioskResponse> getOne(String eventId) async{
    String url='$API_EVENT/$eventId';
    return await client(url);
  }

  @override
  Future<KioskResponse> collections() async{
    return await client(API_EVENT_COLLECTIONS);
  }
  
}