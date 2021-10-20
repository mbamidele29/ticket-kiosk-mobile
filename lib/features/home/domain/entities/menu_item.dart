import 'package:flutter/material.dart';

class MenuItem {
  final int index;
  final Widget view;
  final String title, image;

  MenuItem({@required this.index, @required this.view, @required this.title, @required this.image});
}