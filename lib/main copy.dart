import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/routes/generate_route.dart';
import 'package:ticket_kiosk/core/routes/routes.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_kiosk/core/values/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: ()=>MaterialApp(
        title: APP_NAME,
        theme: ThemeData(
          primaryColor: colorPrimary,
          accentColor: colorAccent,
          fontFamily: 'WorkSans',
          backgroundColor: colorWhite,
          scaffoldBackgroundColor: colorWhite,
          textTheme: TextTheme(
            headline1: headline1,
            headline2: headline2,
            headline3: headline3,
            headline4: headline4,
            subtitle1: subtitle1,
            subtitle2: subtitle2,
          ),
        ),
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget,
          );
        },
        initialRoute: routeInit,
        onGenerateRoute: generateRoute,
      )
    );
  }
}
