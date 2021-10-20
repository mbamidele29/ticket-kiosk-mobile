import 'dart:convert';

import 'package:flutter/material.dart';

class KioskMessage {
  final bool status;
  final String message;
  final dynamic data;

  KioskMessage({@required this.status, @required this.message, @required this.data});

  @override
    String toString() {
      return jsonEncode({
        'status': status,
        'message': message,
        'data': data,
      });
    }

}