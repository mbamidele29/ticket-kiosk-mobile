import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_button.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_loading.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_text_field.dart';
import 'package:ticket_kiosk/core/widgets/show_message.dart';
import 'package:ticket_kiosk/features/create_account/domain/register_service.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({ Key key }) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  bool isLoading=false;
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _lastNameController=TextEditingController();
  final TextEditingController _firstNameController=TextEditingController();
  final TextEditingController _phoneNumberController=TextEditingController();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h,),
                    GestureDetector(
                      onTap: ()=>Navigator.of(context).pop(),
                      child: Container(
                        width: 35.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                          color: colorAccent.withOpacity(1),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: colorWhite,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Text(
                      CREATE_ACCOUNT_DESC2,
                      style: Theme.of(context).textTheme.headline3.copyWith(color: colorBlack, fontWeight: FontWeight.bold, height: 1.32),
                    ),
                    SizedBox(height: 40.h,),
                    KioskTextField(
                      hintText: HINT_FIRST_NAME, 
                      controller: _firstNameController,
                    ),
                    SizedBox(height: 20.h,),
                    KioskTextField(
                      hintText: HINT_LAST_NAME, 
                      controller: _lastNameController,
                    ),
                    SizedBox(height: 20.h,),
                    KioskTextField(
                      hintText: HINT_EMAIL, 
                      textInputType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    SizedBox(height: 20.h,),
                    KioskTextField(
                      hintText: HINT_PHONE_NUMBER, 
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _phoneNumberController,
                    ),
                    SizedBox(height: 30.h,),
                    KioskButton(
                      buttonText: CREATE_ACCOUNT_DESC, 
                      onTap: _register
                    ),
                    SizedBox(height: 8.h,),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: KioskLoading()
          ),
        ],
      ),
    );
  }

  _toggleLoader(){
    setState(() {
      isLoading=!isLoading;
    });
  }

  Future<void> _register()async{
    _toggleLoader();
    KioskMessage message=await serviceLocator<RegisterService>()(
      _firstNameController.text.trim(), 
      _lastNameController.text.trim(), 
      _emailController.text.trim(), 
      _phoneNumberController.text.trim(), 
    );
    _toggleLoader();
    showMessage(context, message.status, message.message);
    if(message.status)Navigator.of(context).pop();

  }
}