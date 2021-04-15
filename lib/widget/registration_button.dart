import 'package:flutter/material.dart';

class RegistrationButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backColor;
  final Function onPressed;
  RegistrationButton({this.text, this.textColor, this.backColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 45,
      minWidth: double.infinity,
      elevation: 1,
      highlightElevation: 1,
      color: backColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        "$text",
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
