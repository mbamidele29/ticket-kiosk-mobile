import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/routes/routes.dart';
import 'package:ticket_kiosk/features/create_account/presentation/create_account_page.dart';
import 'package:ticket_kiosk/features/create_event/presentation/pages/create_event_page.dart';
import 'package:ticket_kiosk/features/forgot_password/presentation/forgot_password_page.dart';
import 'package:ticket_kiosk/features/home/presentation/pages/main_page.dart';
import 'package:ticket_kiosk/features/login/presentation/login_page.dart';
import 'package:ticket_kiosk/features/splash/splash_page.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  final String route=settings.name;
  final Map arguments=settings.arguments;

  switch(route){
    case routeInit:
      return MaterialPageRoute(builder: (_)=>SplashPage());
    case routeLogin:
      return MaterialPageRoute(builder: (_)=>LoginPage());
    case routeCreateAccount:
      return MaterialPageRoute(builder: (_)=>CreateAccountPage());
    case routeForgotPassword:
      return MaterialPageRoute(builder: (_)=>ForgotPasswordPage());

    case routeHome:
      return MaterialPageRoute(builder: (_)=>MainPage());
    case routeCreateEvent:
      return MaterialPageRoute(builder: (_)=>CreateEventPage(event: arguments['event'],));
    default:
      return MaterialPageRoute(builder: (_)=>SplashPage());
  }
}








// const schema=mongoose.Schema({
//     // rsvp: {
//     //     type: [String], // name, phone, email; defaults to info of creator
//     //     required: true,
//     // },
//     tickets: {
//         type: [ticket],
//         required: true
//     },
//     eventDates: {
//         type: [String],
//         required: true,
//     },
//     address: {
//         type: String,
//         required: true,
//     },
//     banner: {
//         type: String,
//         required: [true, 'Banner is required'],
//     },
// }, {
//     timestamps: true,
// });
