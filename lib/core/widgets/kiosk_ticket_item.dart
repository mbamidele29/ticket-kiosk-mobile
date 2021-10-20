import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_kiosk/core/entities/ticket.dart';
import 'package:ticket_kiosk/core/values/assets.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_round_button.dart';

class KioskTicketItem extends StatelessWidget {
  final Ticket ticket;
  final bool hasRemove;
  final Function onRemoveTap;
  const KioskTicketItem(this.ticket, { Key key, this.hasRemove=false, this.onRemoveTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color=colorAccent;
    String ticketsAvailable='${ticket.quantity} tickets available';
    if(ticket.quantity==1) ticketsAvailable='${ticket.quantity} ticket available';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: color.withOpacity(.15),
            ),
            child: Center(
              child: SvgPicture.asset(iconTicket, color: color, width: 20.w, height: 20.w,),
            ),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${ticket.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 18.sp, 
                        height: 1,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      '$ticketsAvailable',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(height: 1)
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12,),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${ticket.cost}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontSize: 18.sp, 
                      height: 1,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    'per ticket',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2.copyWith(height: 1)
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: hasRemove,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: KioskRoundButton(
                iconCancel,
                hasShadow: false,
                onTap: onRemoveTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}