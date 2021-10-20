import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/styles.dart';

class KioskButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final double borderRadius;
  final bool hasShadow, minified;
  final ButtonType buttonType;
  const KioskButton({ Key key, @required this.buttonText, @required this.onTap, this.borderRadius=8, this.minified=false, this.hasShadow=true, this.buttonType=ButtonType.ACCENT }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor=colorAccent;
    Color buttonColor=colorAccent;
    TextStyle buttonTextStyle=accentButtonTextStyle;

    double verticalPadding=20;
    if(minified)verticalPadding=8;

    if(buttonType==ButtonType.PRIMARY){
      buttonColor=colorWhite;
      buttonTextStyle=primaryButtonTextStyle;
    }

    List<BoxShadow> boxShadow=[];
    if(hasShadow){
      boxShadow.add(BoxShadow(
        color: buttonColor.withOpacity(.25),
        offset: Offset(0, 2),
        blurRadius: 20,
      ));
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          boxShadow: boxShadow,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Center(
            child: Text(
              buttonText,
              style: buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonType {
  PRIMARY, ACCENT, 
}