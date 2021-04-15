import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final String route;
  const BottomButton({this.title, this.route});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => Navigator.popAndPushNamed(context, route),
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
