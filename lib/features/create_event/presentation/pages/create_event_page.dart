import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/entities/kiosk_message.dart';
import 'package:ticket_kiosk/core/entities/location.dart';
import 'package:ticket_kiosk/core/entities/ticket.dart';
import 'package:ticket_kiosk/core/service_locator.dart';
import 'package:ticket_kiosk/core/values/apis.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/core/values/styles.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_button.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_loading.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_location_delegate.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_round_button.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_text_field.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_ticket_item.dart';
import 'package:ticket_kiosk/core/widgets/show_message.dart';
import 'package:ticket_kiosk/features/create_event/domain/create_event_service.dart';
import 'package:ticket_kiosk/features/create_event/presentation/widgets/section_title.dart';
import 'package:uuid/uuid.dart';

class CreateEventPage extends StatefulWidget {
  final Event event;
  const CreateEventPage({ Key key, @required this.event }) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {

  Location _location;
  TextTheme textTheme;
  String category, eventType;

  bool isLoading=false;
  @override
    void initState() {
      if(widget.event==null)Navigator.of(context).pop();
      super.initState();
    }
  
  @override
  Widget build(BuildContext context) {
    if(textTheme==null) textTheme=Theme.of(context).textTheme;
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0), 
                    bottomRight: Radius.circular(0),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*.4,
                        decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0), 
                            bottomRight: Radius.circular(0),
                          )
                        ),
                        child: Image.file(
                          File(widget.event.banner),
                          // fit: BoxFit.cover,
                          fit: BoxFit.fitWidth,
                          frameBuilder: (BuildContext context, Widget child, int frame, bool wasSyncLoaded){
                            if(wasSyncLoaded || frame!=null){
                              return Container(
                                child: child,
                                foregroundDecoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.transparent,
                                      const Color(0x33111010),
                                      const Color(0x33111010),
                                    ]
                                  ),
                                ),
                              );
                            }
                            return Container(
                              child: CircularProgressIndicator(
                                value: null,
                                backgroundColor: colorWhite,
                              ),
                              alignment: Alignment(0, 0),
                              constraints: BoxConstraints.expand(),
                            );
                          },
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.event.title}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.headline2.copyWith(color: colorWhite),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              '${widget.event.description}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: subtitle3,
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                SvgPicture.network(
                                  '$IMAGE_BASE_URL/icons/${widget.event.category.name.replaceAll(' ', '-')}.svg', 
                                  color: colorWhite,
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  '${widget.event.category.name}',
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.subtitle1.copyWith(color: colorWhite),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // SizedBox(height: 30,),
                // MajorEventItem(event: widget.event),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        _location == null ? 'Select Venue' : _location.placeAddress,
                        trailing: KioskRoundButton(
                          iconLocation,
                          onTap: () async{
                            final String sessionToken=Uuid().v4();
                            _location=await showSearch(
                              context: context, 
                              delegate: KioskLocationDelegate(sessionToken)
                            );
                            setState(() {});
                          },
                        ),
                      ),
                      SectionTitle(
                        'Event Date',
                        trailing: KioskRoundButton(
                          iconCalendar,
                          onTap: () async{
                            String date=await _selectDate(context);
                            if(date!=null)widget.event.eventDates.insert(0, date);
                            setState(() {});
                          },
                        ),
                      ),

                      for(int index=0; index<widget.event.eventDates.length; index++)
                        _eventDateWidget(index, widget.event.eventDates[index]),

                      SectionTitle(
                        'Tickets',
                        trailing: KioskRoundButton(
                          iconAdd,
                          onTap: (){
                            _showTicketBottomSheet(context, -1);
                          },
                        ),
                      ),
                      for(int index=0; index<widget.event.tickets.length; index++)
                        KioskTicketItem(
                          widget.event.tickets[index],
                          hasRemove: true,
                          onRemoveTap: (){
                            widget.event.tickets.removeAt(index);
                            setState(() {});
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.file_upload),
            onPressed: _submit,
          )
        ),
        Visibility(
          visible: isLoading,
          child: KioskLoading()
        )
      ],
    );
  }

  Future<void> _submit() async{
    widget.event.placeId=_location?.placeId;
    widget.event.address=_location?.placeAddress;
    _toggleLoader();
    KioskMessage message= await serviceLocator<CreateEventService>().call(widget.event);
    _toggleLoader();
    showMessage(context, message.status, message.message);
  }

  void _toggleLoader(){
    setState(() {
      isLoading=!isLoading;
    });
  }

  Future<String> _selectDate(BuildContext context, {DateTime initialDate}) async {
    DateTime selectedDate=await showDatePicker(
      context: context, 
      initialDate: initialDate ?? DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime(DateTime.now().year+5),
      helpText: 'Select Event Date',
      fieldLabelText: 'Enter Event Date',
      fieldHintText: 'Enter Event Date'
    );
    if(selectedDate==null)return null;
    TimeOfDay timeOfDay=await _selectTime(context);
    if(timeOfDay==null)return null;
    
    return DateTime(
      selectedDate.year, 
      selectedDate.month, 
      selectedDate.day, 
      timeOfDay.hour, 
      timeOfDay.minute
    ).toIso8601String();
  }

  Future<TimeOfDay> _selectTime(BuildContext context)async {
    return await showTimePicker(
      context: context, 
      helpText: 'Select Event Start Time',
      initialTime: TimeOfDay.now()
    );
  }

  void _showTicketBottomSheet(BuildContext context, int index) {
    String title='Add Ticket Type';
    if(index>-1)title='Modify Ticket Type';

    Ticket ticket=index>-1 ? widget.event.tickets.elementAt(index) : Ticket.initial();

    String cost=ticket.cost == null ? '' : ticket.cost.toString();
    String quantity=ticket.quantity == null ? '' : ticket.quantity.toString();

    final TextEditingController _ticketCostController=TextEditingController(text: cost);
    final TextEditingController _ticketNameController=TextEditingController(text: ticket.name);
    final TextEditingController _ticketQuantityController=TextEditingController(text: quantity);
    final TextEditingController _ticketDescriptionController=TextEditingController(text: ticket.description);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.45,
                minChildSize: 0.3,
                maxChildSize: 0.85,
                builder: (__, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                          child: Text(
                            '$title',
                            textAlign: TextAlign.center,
                            style: textTheme.headline3.copyWith(fontSize: 18.sp, color: colorBlack),
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: .8,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ListView(
                              controller: controller,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    KioskTextField(
                                      minified: true,
                                      hintText: 'Ticket Name e.g. VVIP', 
                                      controller: _ticketNameController,
                                    ),
                                    SizedBox(height: 10,),
                                    KioskTextField(
                                      minified: true,
                                      lines: 2,
                                      hintText: 'Ticket Description', 
                                      controller: _ticketDescriptionController,
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: KioskTextField(
                                            minified: true,
                                            hintText: 'Ticket Cost', 
                                            controller: _ticketCostController,
                                            textInputType: TextInputType.number,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: KioskTextField(
                                            minified: true,
                                            hintText: 'Ticket Quantity', 
                                            controller: _ticketQuantityController,
                                            textInputType: TextInputType.number,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Expanded(child: SizedBox.shrink()),
                                        Expanded(child: SizedBox.shrink()),
                                        Expanded(
                                          flex: 2,
                                          child: KioskButton(
                                            minified: true,
                                            buttonType: ButtonType.PRIMARY,
                                            buttonText: 'Discard', 
                                            onTap: (){
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 7,),
                                        Expanded(
                                          flex: 2,
                                          child: KioskButton(
                                            minified: true,
                                            buttonText: 'Add',
                                            hasShadow: false,
                                              onTap: (){
                                                String name=_ticketNameController.text.trim() ?? '';
                                                String description=_ticketDescriptionController.text.toString() ?? '';
                                                String cost=_ticketCostController.text.trim() ?? '';
                                                String quantity=_ticketQuantityController.text.trim() ?? '';
                                                if(name.isEmpty || description.isEmpty || cost.isEmpty || quantity.isEmpty){
                                                  showMessage(context, false, ERROR_ALL_FIELDS_REQUIRED);
                                                  return;
                                                }
                                                ticket.name=name;
                                                ticket.description=description;
                                                ticket.cost=int.parse(cost);
                                                ticket.quantity=int.parse(quantity);
                                                ticket.currency=NAIRA_CURRENCY;
                                                if(index==-1){
                                                  widget.event.tickets.insert(0, ticket);
                                                }else{
                                                  widget.event.tickets.remove(index);
                                                  widget.event.tickets.insert(index, ticket);
                                                }
                                                setState(() {});
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ),
                        ),
                      ],
                    )
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _eventDateWidget(int index, String dt) {
    final DateTime dateTime=DateTime.parse(dt);
    final String date=DateFormat.yMMMEd().format(dateTime);
    final String time=DateFormat.Hm().format(dateTime);
    Color color=colorAccent;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: color.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: SvgPicture.asset(iconCalendar, color: color,),
            ),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$date',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontSize: 16.sp, 
                    height: 1,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  'Start time: $time',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 14.sp,
                    height: 1,
                    fontWeight: FontWeight.w500
                  )
                ),
              ],
            ),
          ),
          SizedBox(width: 12,),
          KioskRoundButton(
            iconCancel,
            hasShadow: false,
            onTap: (){
              widget.event.eventDates.removeAt(index);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}