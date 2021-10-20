import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/widgets/kiosk_round_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final KioskRoundButton trailing;
  const SectionTitle(this.title, { Key key, this.trailing }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$title',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 18.sp, height: 1),
            ),
          ),
          trailing ?? SizedBox.shrink()
        ],
      ),
    );
  }
}