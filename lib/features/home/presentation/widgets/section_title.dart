import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Widget trailing;

  const SectionTitle(this.title, { Key key, this.trailing }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$title',
            style: Theme.of(context).textTheme.headline2,
          ),
          trailing ?? SizedBox.shrink()
        ],
      ),
    );
  }
}