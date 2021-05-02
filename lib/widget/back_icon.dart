import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackIconButton extends StatelessWidget {
  final Color color;
  BackIconButton({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
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
