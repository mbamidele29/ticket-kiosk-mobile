import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_kiosk/core/values/colors.dart';

class KioskRoundButton extends StatelessWidget {
  final String assetPath;
  final Function onTap;
  final bool hasShadow;
  const KioskRoundButton(this.assetPath, { Key key, this.onTap, this.hasShadow=true }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BoxShadow> boxShadow=[
      BoxShadow(
        color: colorTextFieldShadow,
        offset: Offset(0, 2),
        blurRadius: 15,
      )
    ];
    if(!hasShadow)boxShadow.clear();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(32.w),
          boxShadow: boxShadow,
        ),  
        child: Center(
          child: SvgPicture.asset(assetPath, color: colorAccent,),
        ),                  
      ),
    );
  }
}