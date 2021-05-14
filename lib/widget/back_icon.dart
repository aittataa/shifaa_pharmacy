import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';

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
        Messages.IMAGE_LEFT,
        color: color,
        height: 20,
        width: 20,
      ),
    );
  }
}
