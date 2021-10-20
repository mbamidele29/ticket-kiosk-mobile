import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticket_kiosk/core/entities/event.dart';
import 'package:ticket_kiosk/core/values/apis.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MajorEventItem extends StatefulWidget {
  final Event event;
  const MajorEventItem({ Key key, @required this.event, }) : super(key: key);

  @override
  _MajorEventItemState createState() => _MajorEventItemState();
}

class _MajorEventItemState extends State<MajorEventItem> {

  Event event;
  @override
  Widget build(BuildContext context) {
    event=widget.event;
    final TextTheme textTheme=Theme.of(context).textTheme;
    return event==null ? _shimmerWidget(textTheme) : _loadedWidget(textTheme);
  }

  Widget _shimmerWidget(TextTheme textTheme){
    return Shimmer.fromColors(
      baseColor: colorAccent, 
      highlightColor: colorWhite,
      period: Duration(seconds: 3),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: colorAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Container(
            //     width: 30.w,
            //     height: 30.w,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(30.w),
            //       color: Color.fromRGBO(152, 152, 152, .4),
            //     ),
            //     child: Center(child: SvgPicture.asset(iconCancel)),
            //   ),
            // ),
            Expanded(child: SizedBox.shrink()),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // for(String date in event.eventDates)
                  //   Text(
                  //     '$date',
                  //     maxLines: 1,
                  //     style: textTheme.subtitle2.copyWith(
                  //       color: colorWhite, 
                  //       height: 1.5
                  //     ),
                  //   ),
                  SizedBox(height: 5.h,),
                  Container(
                    width: double.infinity,
                    height: 22,
                  ),
                  SizedBox(height: 5.h,),
                  Container(
                    width: double.infinity,
                    height: 22,
                  ),
                  SizedBox(height: 11.h,),
                  Row(
                    children: [
                      // category
                      _eventInfo(null, null),
                      SizedBox(width: 10,),
                      // amount
                      _eventInfo(null, null),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadedWidget(TextTheme textTheme){
    String amountRange='${event.minCost}';
    if(event.minCost!=event.maxCost)amountRange+=' - ${event.maxCost}';
    String banner=event.banner?.replaceFirst('public/', '');
    banner='$IMAGE_BASE_URL/$banner';

    return FutureBuilder(
      future: _getDominantColor(banner),
      builder: (_, snapshot) {
        return CachedNetworkImage(
          imageUrl: '$banner',
          progressIndicatorBuilder: (context, url, downloadProgress) => 
            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => Container(
            width: double.infinity,
            height: double.infinity,
            child: Icon(Icons.error, color: colorAccent,),
            decoration: BoxDecoration(
              // color: colorAccent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colorAccent),
            ),
          ),
          imageBuilder: (context, imageProvider) => ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  // fit: BoxFit.fitWidth,
                  frameBuilder: (BuildContext context, Widget child, int frame, bool wasSyncLoaded){
                    if(wasSyncLoaded || frame!=null){
                      return Container(
                        child: child,
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              // Colors.transparent,
                              // Colors.transparent,
                              // Colors.transparent,
                              // Colors.transparent,
                              // Color.fromRGBO(6, 11, 44, .32),
                              // Color.fromRGBO(0, 7, 163, .39),
                              Color.fromRGBO(0, 0, 0, 0),
                              Color.fromRGBO(0, 0, 0, .33),
                              // snapshot.data ?? const Color(0x33111010),
                              // snapshot.data ?? const Color(0x33111010),
                              // snapshot.data ?? const Color(0x33111010),
                            ]
                          ),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${DateFormat.yMMMEd().format(DateTime.tryParse(event.nextEventDate))}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.subtitle2.copyWith(color: colorWhite),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        '${event.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline3,
                      ),
                      SizedBox(height: 11.h,),
                      Row(
                      children: [
                        // category
                        _eventInfo(textTheme, event.category.name),
                        SizedBox(width: 10,),
                        // amount
                        _eventInfo(textTheme, amountRange, iconPath: iconTicket),
                      ],
                    ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _eventInfo(TextTheme textTheme, String value, {String iconPath}){
    return value==null ?
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
          ),
          SizedBox(width: 4,),
          Container(
            width: 63,
            height: 12,
          ),
        ],
      ) :
      Row(
        children: [
          iconPath==null ? 
            SvgPicture.network(
              '$IMAGE_BASE_URL/icons/${value.replaceAll(' ', '-')}.svg', 
              color: colorWhite, 
              width: 15, 
              height: 15,
            ) :
            SvgPicture.asset(
              iconPath,
              color: colorWhite, 
              width: 15, 
              height: 15,
            ),
          SizedBox(width: 4,),
          Text(
            '$value',
            maxLines: 1,
            style: textTheme.subtitle2.copyWith(color: colorWhite),
          ),
        ],
      );
  }

  int called=0;
  Future<Color> _getDominantColor(String url) async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(url),
    );
    return Color(0x33111010);// paletteGenerator.dominantColor.color.withOpacity(.8);
  }
}