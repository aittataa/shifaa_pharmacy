import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {
  final Color color;
  BackIconButton({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Image.asset(
        "images/left.png",
        color: color,
        height: 20,
        width: 20,
      ),
    );
  }
}
