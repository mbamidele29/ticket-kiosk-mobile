import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_button.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({ Key key }) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  bool _rememberMe=false;
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 50.h,),
                SvgPicture.asset(
                  brandLogo,
                  width: 175.w,
                  height: 139.w,
                ),
                Text(
                  APP_NAME,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  APP_MOTTO,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 60.h,),
                Text(
                  FORGOT_PASSWORD_DESC,
                  style: Theme.of(context).textTheme.headline3.copyWith(color: colorBlack, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 40.h,),
                KioskTextField(
                  hintText: HINT_EMAIL, 
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                SizedBox(height: 30.h,),
                KioskButton(
                  buttonText: FORGOT_PASSWORD_BUTTON_TEXT, 
                  onTap: null
                ),
                SizedBox(height: 8.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}