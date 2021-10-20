import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_kiosk/core/entities/category.dart';
import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/routes/routes.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/core/values/styles.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_app_bar.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_location_delegate.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_round_button.dart';
import 'package:ticket_kiosk/features/home/domain/entities/menu_item.dart';
import 'package:ticket_kiosk/features/home/domain/services/category_service.dart';
import 'package:ticket_kiosk/features/home/presentation/pages/home_page.dart';
import 'package:ticket_kiosk/features/home/presentation/widgets/create_event_modal.dart';
import 'package:uuid/uuid.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  int _currentIndex=0;
  List<MenuItem> _menuItem;
  List<Category> categories=[];
  List<String> eventTypes=['Public', 'Private'];

  final Widget homeWidget= HomePage();

  @override
  void initState() {
    init();
    _menuItem=[
      MenuItem(index: 0, view: homeWidget, title: 'Home', image: iconHome),
      MenuItem(index: 1, view: homeWidget, title: 'Search', image: iconSearch),
      MenuItem(index: 2, view: homeWidget, title: 'Ticket', image: iconTicket),
      MenuItem(index: 3, view: homeWidget, title: 'Profile', image: iconProfile),
    ];
    super.initState();
  }

  Future<void> init() async{
      categories= await serviceLocator<CategoryService>()();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            KioskAppBar(
              HOME_TITLE,
              leading: Icon(Icons.person, color: colorBlack,),
              trailing: Icon(Icons.search, color: colorBlack,),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IndexedStack(
                        index: _currentIndex,
                        children: _menuItem.map((item) => item.view).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorWhite,
        selectedLabelStyle: forgotPasswordTextStyle,
        unselectedLabelStyle: rememberMeTextStyle,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (int index){
          setState(() {
            _currentIndex=index;
          });
        },
        currentIndex: _currentIndex,
        items: _menuItem.map((item) {
          return BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: SvgPicture.asset(item.image, width: 24.w, height: 24.w, color: colorBasicGray,),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: SvgPicture.asset(item.image, width: 24.w, height: 24.w, color: colorAccent,),
            ),
            label: item.title,
          );
        }).toList(),
      ),
      floatingActionButton: _currentIndex==0 ? FloatingActionButton(
        tooltip: 'create event',
        child: Icon(Icons.add, color: colorWhite,),
        onPressed: (){
          Event event;
          showCreateEventModal(
            context, 
            categories, 
            (Event e){
              event=e;
              Navigator.of(context).pushNamed(routeCreateEvent, arguments: {
                'event': event
              });
            }
          );
        },
      ) : null,
    );
  }
}