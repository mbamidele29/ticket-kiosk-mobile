import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/styles.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMe extends StatelessWidget {
  final bool isChecked;
  final Function onTap;
  const RememberMe({ Key key, this.onTap, this.isChecked=false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              color: isChecked ? colorAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: colorAccent
              )
            ),
            child: Center(
              child: SvgPicture.asset(
                iconMark,
                width: 8.w,
                height: 5.5.h,
              ),
            ),
          ),
          SizedBox(width: 10.w,),
          Text(
            REMEMBER_ME_DESC,
            textAlign: TextAlign.start,
            style: rememberMeTextStyle
          ),
        ],
      ),
    );
  }
}