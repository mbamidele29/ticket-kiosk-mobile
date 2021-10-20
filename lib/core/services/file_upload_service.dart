import 'dart:io';

import 'package:ticket_kiosk/core/datasource/http_post_file.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';

class FileUploadService {
  final HttpPostFile uploadClient;

  FileUploadService(this.uploadClient);

  Future<KioskMessage> call(String url, String fieldName, File file) async{
    return uploadClient(url, fieldName, file);
  }
}