import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_kiosk/core/values/colors.dart';

void showMessage(BuildContext context, bool status, String message){
  Color color=colorError;
  if(status) color=colorSuccess;
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(
      message,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15.sp,
      ),
    ),
    duration: const Duration(seconds: 3),
    // action: SnackBarAction(
    //   label: 'ACTION',
    //   onPressed: () { },
    // ),
  ));
}