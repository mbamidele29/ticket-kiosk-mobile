import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_kiosk/core/datasource/local_source.dart';
import 'package:ticket_kiosk/core/routes/routes.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/values/assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      String route=routeLogin;

      String expiry=await serviceLocator<LocalSource>().getTokenExpiry() ?? '';
      DateTime expiryDate=DateTime.tryParse(expiry);
      if(expiryDate!=null && DateTime.now().isBefore(expiryDate))
        route=routeHome;

      Timer(Duration(seconds: 3), (){
        Navigator.of(context).pushReplacementNamed(route);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(brandLogo)
      )
    );
  }
}