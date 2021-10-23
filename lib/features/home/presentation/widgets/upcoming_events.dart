import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_kiosk/core/widgets/show_message.dart';
import 'package:ticket_kiosk/features/home/domain/services/event_service.dart';
import 'package:ticket_kiosk/features/home/presentation/widgets/upcoming_event_item.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({ Key key, }) : super(key: key);

  @override
  _UpcomingEventsState createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  List<Event> events=[];

  @override
    void initState() {
      initEvents();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEP'.toUpperCase(),
            style: forgotPasswordTextStyle.copyWith(fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 10,),
          UpcomingEventItem(event: events[events.length-1]),
        ],
      ),
    );
  }

  void initEvents() async {
    KioskMessage message=await serviceLocator<EventService>()();
    if(!message.status || message.data==null)showMessage(context, message.status, message.message);
    else{
      events.addAll(message.data);
      setState(() {});
    }
  }
}