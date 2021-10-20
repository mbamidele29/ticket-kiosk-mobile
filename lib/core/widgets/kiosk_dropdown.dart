import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_kiosk/core/values/colors.dart';
import 'package:ticket_kiosk/core/values/dimensions.dart';
import 'package:ticket_kiosk/core/values/styles.dart';

class KioskDropdown extends StatelessWidget {
  final String selected;
  final String hintText;
  final Function(dynamic) onChange;
  final List<String> items;
  const KioskDropdown(this.items, this.selected, this.hintText, { Key key, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorTextFieldShadow,
            offset: Offset(0, 4),
            blurRadius: 20
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 11.h),
        child: Padding(
          padding: contentPadding,
          child: DropdownButton(
            style: textFieldStyle,
            isDense: true,
            isExpanded: true,
            value: selected,
            underline: SizedBox.shrink(),
            dropdownColor: colorWhite,
            items: items.map<DropdownMenuItem>((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: textFieldStyle,
              ),
            )).toList(),
            hint: Text(
              hintText,
              style: textFieldHintStyle,
            ),
            onChanged: onChange,
          ),
        ),
      ),
    );
  }
}