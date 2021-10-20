import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_round_button.dart';
import 'package:ticket_kiosk/core/widgets/show_message.dart';
import 'package:ticket_kiosk/features/home/domain/services/event_service.dart';
import 'package:ticket_kiosk/features/home/presentation/widgets/collection_events.dart';
import 'package:ticket_kiosk/features/home/presentation/widgets/recommended_events.dart';
import 'package:ticket_kiosk/features/home/presentation/widgets/section_title.dart';
import 'package:ticket_kiosk/features/home/presentation/widgets/upcoming_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              HEADING_EVENTS_AROUND_YOU, 
              trailing: KioskRoundButton(iconFilter),
            ),
            SizedBox(height: 24.h,),
            RecommendedEvents(),
            SizedBox(height: 48.h,),
            SectionTitle(HEADING_POPULAR),
            SizedBox(height: 24.h,),
            CollectionEvents(),
            SizedBox(height: 24.h,),
            SectionTitle(HEADING_UPCOMING),
            SizedBox(height: 24.h,),
            UpcomingEvents()
          ],
        ),
      ),
    );
  }
}