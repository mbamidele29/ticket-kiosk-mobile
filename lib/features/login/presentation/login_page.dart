import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/routes/routes.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/styles.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_button.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_loading.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_text_field.dart';
import 'package:ticket_kiosk/core/widgets/show_message.dart';
import 'package:ticket_kiosk/features/login/domain/login_service.dart';
import 'package:ticket_kiosk/features/login/presentation/widgets/remember_me.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _rememberMe=false, isLoading=false;
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
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
                      LOGIN_DESC,
                      style: Theme.of(context).textTheme.headline3.copyWith(color: colorBlack, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 40.h,),
                    KioskTextField(
                      hintText: HINT_EMAIL, 
                      textInputType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    SizedBox(height: 20.h,),
                    KioskTextField(
                      hintText: HINT_PASSWORD, 
                      isPasswordField: true,
                      controller: _passwordController
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // RememberMe(
                        //   isChecked: _rememberMe,
                        //   onTap: (){
                        //     setState(() {
                        //       _rememberMe=!_rememberMe;
                        //     });
                        //   },
                        // ),
                        GestureDetector(
                          onTap: ()=>Navigator.of(context).pushNamed(routeForgotPassword),
                          child: Text(
                            FORGOT_PASSWORD_DESC,
                            textAlign: TextAlign.end,
                            style: forgotPasswordTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h,),
                    KioskButton(
                      buttonText: LOGIN_BUTTON_TEXT, 
                      onTap: _login,
                    ),
                    SizedBox(height: 12.h,),
                    RichText(
                      text: TextSpan(
                        text: NEW_HERE_DESC,
                        style: rememberMeTextStyle,
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: ()=>Navigator.of(context).pushNamed(routeCreateAccount),
                              child: Text(
                                CREATE_ACCOUNT_DESC,
                                style: forgotPasswordTextStyle,
                              ),
                            ),
                          )
                        ]
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: KioskLoading()
          )
        ],
      ),
    );
  }

  Future<void> _login() async{
    _toggleLoader();
    KioskMessage message=await serviceLocator<LoginService>()(
      _emailController.text.trim(), 
      _passwordController.text.trim()
    );
    _toggleLoader();

    showMessage(context, message.status, message.message);
    
    if(message.status)
      Navigator.of(context).pushNamedAndRemoveUntil(routeHome, (route) => false);
  }

  void _toggleLoader(){
    setState(() {
      isLoading=!isLoading;
    });
  }

}