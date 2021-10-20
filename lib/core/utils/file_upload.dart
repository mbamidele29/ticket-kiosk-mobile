import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File> pickFile() async{
  try{
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image
    );

    return File(result.files.single.path);
  }catch(err){
    return null;
  }
}