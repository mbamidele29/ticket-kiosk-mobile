import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/widgets/show_message.dart';
import 'package:ticket_kiosk/features/home/domain/services/event_service.dart';
import 'package:ticket_kiosk/features/home/presentation/widgets/collection_event_item.dart';

import 'major_event_item.dart';

class CollectionEvents extends StatefulWidget {
  const CollectionEvents({ Key key, }) : super(key: key);

  @override
  _CollectionEventsState createState() => _CollectionEventsState();
}

class _CollectionEventsState extends State<CollectionEvents> {
  final List<Event> events=[];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 256.h,
        aspectRatio: 319.w/161.h,
        autoPlay: false,
        viewportFraction: .92
      ),
      items: events.length>0 ?
        events.map((event) => 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: CollectionEventItem(
              event: event,
            ),
          ),
        ).toList():
        [1, 2, 3].map((e) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: CollectionEventItem(event: null),
        )).toList()
    );
  }

  @override
    void initState() {
      initCollections();
      super.initState();
    }

  void initCollections() async {
    KioskMessage message=await serviceLocator<EventService>().collections();
    if(!message.status || message.data==null)showMessage(context, message.status, message.message);
    else{
      events.addAll(message.data);
      setState(() {});
    }
  }
}

