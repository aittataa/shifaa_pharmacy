import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class BackIconButton extends StatelessWidget {
  final Color color;
  BackIconButton({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Image.asset(
        "images/left.png",
        color: color,
        height: 20,
        width: 20,
      ),
      onPressed: () {
        isAsyncCall = false;
        Navigator.pop(context);
      },
    );
  }
}
