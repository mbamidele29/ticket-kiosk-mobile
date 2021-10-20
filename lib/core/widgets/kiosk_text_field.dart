import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/dimensions.dart';
import 'package:ticket_kiosk/core/values/styles.dart';

class KioskTextField extends StatelessWidget {
  final int lines;
  final bool minified;
  final bool hasDetectable;
  final String hintText;
  final bool isPasswordField;
  final TextInputType textInputType;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  const KioskTextField({ Key key, @required this.hintText, @required this.controller, this.isPasswordField=false, this.textInputType, this.inputFormatters, this.lines=1, this.minified=false, this.hasDetectable=false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double blurRadius=20;
    EdgeInsets fieldPadding=contentPadding;

    Widget textfield=_textField(fieldPadding);
    if(hasDetectable)textfield=_detectableTextField(fieldPadding);

    if(minified){
      blurRadius=10;
      fieldPadding=minifiedContentPadding;
    }
    List<BoxShadow> shadow=[
      BoxShadow(
        color: colorTextFieldShadow,
        offset: Offset(0, 4),
        blurRadius: blurRadius
      )
    ];


    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadow
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
        child: textfield
      ),
    );
  }

  Widget _textField(EdgeInsets fieldPadding){
    return TextField(
      style: textFieldStyle,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      obscureText: isPasswordField,
      minLines: lines,
      maxLines: lines,
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        hintText: hintText,
        contentPadding: fieldPadding,
        hintStyle: textFieldHintStyle
      ),
      onChanged: (value){
        
      },
    );
  }

  Widget _detectableTextField(EdgeInsets fieldPadding){
    return SizedBox.shrink();
    // return DetectableTextField(
    //   basicStyle: textFieldStyle,
    //   detectionRegExp: detectionRegExp(),
    //   decoratedStyle: textFieldStyle.copyWith(color: colorAccent),
    //   controller: controller,
    //   inputFormatters: inputFormatters,
    //   keyboardType: textInputType,
    //   obscureText: isPasswordField,
    //   minLines: lines,
    //   maxLines: lines,
    //   decoration: InputDecoration(
    //     isDense: true,
    //     border: InputBorder.none,
    //     hintText: hintText,
    //     contentPadding: fieldPadding,
    //     hintStyle: textFieldHintStyle
    //   ),
    //   onChanged: (value){
        
    //   },
    // );
  }
}