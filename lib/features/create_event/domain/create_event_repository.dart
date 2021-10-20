
import 'package:ticket_kiosk/core/datasource/http_post.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/values/apis.dart';

abstract class ICreateEventRepository {
  Future<KioskMessage> call(Map event);
}

class CreateEventRepositoryImpl implements ICreateEventRepository {
  final HttpPost client;

  CreateEventRepositoryImpl(this.client);
  @override
  Future<KioskMessage> call(Map event) async{
    return await client.call(API_EVENT, payload: event);
  }

}