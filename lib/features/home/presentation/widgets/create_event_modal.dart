import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_kiosk/core/entities/category.dart';
import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/utils/file_upload.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/strings.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_button.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_dropdown.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_text_field.dart';
import 'package:ticket_kiosk/core/widgets/show_message.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;

void showCreateEventModal(
  BuildContext context, 
  List<Category> categories, 
  Function(Event event) proceedTap
) {
  
  File banner;
  final List<String> categoryNames=categories.map<String>((item) => item.name).toList();
  String categoryId, categoryName, eventType;
  List<String> eventTypes=['Public', 'Private'];
  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();

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
                initialChildSize: 0.7,
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
                    child: StatefulBuilder(
                      builder: (___, setModalState) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                              child: Text(
                                'Create Event',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline3.copyWith(color: colorBlack),
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
                                    SizedBox(height: 20,),
                                    KioskTextField(
                                      minified: true,
                                      hintText: 'Event Title', 
                                      controller: _titleController
                                    ),
                                    SizedBox(height: 15,),
                                    KioskTextField(
                                      minified: true,
                                      lines: 5,
                                      hintText: 'Event Details', 
                                      controller: _descriptionController
                                    ),
                                    SizedBox(height: 15,),
                                    KioskDropdown(
                                      categoryNames, 
                                      categoryName, 
                                      'Select Event Category',
                                      onChange: (value){
                                        setModalState(() {
                                          categoryName=value;
                                          categoryId=categories.firstWhere((element) => element.name==value).id;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 15,),
                                    KioskDropdown(
                                      eventTypes, 
                                      eventType, 
                                      'Select Event Type',
                                      onChange: (value){
                                        setModalState(() {
                                          eventType=value;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 15,),
                                    if(banner!=null && banner.existsSync())
                                      Container(
                                        width: double.infinity,
                                        height: 256.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(banner),
                                          )
                                        ),
                                      ),
                                    SizedBox(height: 15,),
                                    GestureDetector(
                                      onTap: () async{
                                        banner=await pickFile();
                                        if(banner==null)return;
                                        final String ext=p.extension(banner.path);
                                        if(!['.jpg', '.jpeg', '.png'].contains(ext)){
                                          banner.delete();
                                          banner=null;
                                          showMessage(context, false, 'invalid file type');
                                        }else{
                                          int size=banner.lengthSync();
                                          double sizeMB=(size/1024)/1024;
                                          if(sizeMB>2){
                                            banner.delete();
                                            banner=null;
                                            showMessage(context, false, 'file too large');
                                          }
                                        }
                                        setModalState((){});
                                      },
                                      child: DottedBorder(
                                        color: colorAccent,
                                        strokeWidth: 1.2,
                                        dashPattern: [10, 10],
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(4),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 21, vertical: 14),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: SvgPicture.asset(imageGallerySelect)
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Select event banner',
                                                      style: Theme.of(context).textTheme.headline4.copyWith(color: colorBlack, height: 1),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text(
                                                      'File Format: JPG & PNG | File Size: 2MB',
                                                      style: Theme.of(context).textTheme.subtitle2.copyWith(height: 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                    KioskButton(
                                      buttonText: PROCEED, 
                                      onTap: (){
                                        eventType=eventType ?? '';
                                        categoryId=categoryId ?? '';
                                        categoryName=categoryName ?? '';
                                        String title=_titleController.text.trim();
                                        String description=_descriptionController.text.trim();
                                        if(
                                          title.isEmpty || description.isEmpty || 
                                          categoryId.isEmpty || eventType.isEmpty
                                        ){
                                          showMessage(context, false, ERROR_ALL_FIELDS_REQUIRED);
                                          return;
                                        }

                                        final Event event=Event(
                                          eventDates: [], 
                                          minCost: '0',
                                          maxCost: '0',
                                          tags: [], 
                                          nextEventDate: '',
                                          eventType: eventType, 
                                          tickets: [], 
                                          comments: [], 
                                          placeId: '',
                                          address: '', 
                                          createdAt: '', 
                                          updatedAt: '', 
                                          id: '', 
                                          title: title, 
                                          description: description, 
                                          category: Category.fromJson({
                                            '_id': '',
                                            'name': categoryName
                                          }),
                                          banner: banner?.path ?? '', 
                                          createdById: '', 
                                          createdByFirstName: '', 
                                          createdByLastName: ''
                                        );
                                        Navigator.of(context).pop();
                                        proceedTap(event);
                                      }
                                    ),
                                    SizedBox(height: 15,),
                                  ],
                                )
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }