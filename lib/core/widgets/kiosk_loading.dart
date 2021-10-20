import 'package:flutter/material.dart';

class KioskLoading extends StatelessWidget {
  const KioskLoading({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black.withOpacity(.4),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}