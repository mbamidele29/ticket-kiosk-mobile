import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/datasource/http_post.dart';
import 'package:ticket_kiosk/core/entities/kiosk_response.dart';
import 'package:ticket_kiosk/core/values/apis.dart';

abstract class ILoginRepository {
  Future<KioskResponse> call(String email, String password);
}

class LoginRepositoryImpl implements ILoginRepository{
  final HttpPost client;

  LoginRepositoryImpl(this.client);

  @override
  Future<KioskResponse> call(String email, String password)async {
    return await client(
      API_LOGIN,
      payload: {'email': email, 'password': password}
    );
  }
}