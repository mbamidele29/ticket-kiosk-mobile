import 'package:ticket_kiosk/core/datasource/http_post.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/core/values/apis.dart';

abstract class IRegisterRepository {
  Future<KioskResponse> call(String firstName, String lastName, email, String phoneNumber);
}

class RegisterRepositoryImpl implements IRegisterRepository {
  final HttpPost client;

  RegisterRepositoryImpl(this.client);
  @override
  Future<KioskResponse> call(String firstName, String lastName, email, String phoneNumber) {
    return client(
      API_REGISTER,
      payload: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
      }
    );
  }

}