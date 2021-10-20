import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';

class KioskResponse extends KioskMessage {
  final bool status;
  final dynamic data;
  final String message;
  KioskResponse({@required this.status, @required this.message, @required this.data}) : super(status:status, message: message, data: data);
}