import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/widgets/show_message.dart';
import 'package:ticket_kiosk/features/home/domain/services/event_service.dart';

import 'major_event_item.dart';

class RecommendedEvents extends StatefulWidget {
  const RecommendedEvents({ Key key, }) : super(key: key);

  @override
  _RecommendedEventsState createState() => _RecommendedEventsState();
}

class _RecommendedEventsState extends State<RecommendedEvents> {
  final List<Event> events=[];
  
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 256.h,
        aspectRatio: 327.w/256.h,
        autoPlay: false,
        viewportFraction: .98
      ),
      items: events.length>0 ?
        events.map((event) => 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: MajorEventItem(
              event: event,
            ),
          ),
        ).toList():
        [1, 2, 3].map((e) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: MajorEventItem(event: null),
        )).toList()
    );
  }

  @override
  void initState() {
    initEvents();
    super.initState();
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

