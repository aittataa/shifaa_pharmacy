import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final Widget screen;
  const BottomButton({this.title, this.screen});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => Get.off(screen),
      elevation: 0,
      highlightElevation: 0,
      color: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        "$title",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
