import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KioskAppBar extends StatelessWidget {
  final String title;
  final Widget leading, trailing;
  const KioskAppBar(this.title, { Key key, this.leading, this.trailing }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.only(bottom: 45.h),
      decoration: BoxDecoration(
        color: colorWhite,
        boxShadow: [
          BoxShadow(
            color: colorBlack.withOpacity(.08),
            offset: Offset(0, 0),
            blurRadius: 25,
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: leading ?? SizedBox.shrink(),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2.copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp,),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: trailing ?? SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}