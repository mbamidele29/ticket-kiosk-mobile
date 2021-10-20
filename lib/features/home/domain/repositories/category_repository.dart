import 'package:ticket_kiosk/core/datasource/http_get.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/core/values/apis.dart';

abstract class ICategoryRepository {
  Future<KioskResponse> call();
}

class CategoryRepository implements ICategoryRepository {
  final HttpGet client;

  CategoryRepository(this.client);
  @override
  Future<KioskResponse> call() async{
    return await client.call(API_CATEGORY);
  }

}