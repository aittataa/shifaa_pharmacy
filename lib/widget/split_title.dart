import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class SplitTitle extends StatelessWidget {
  final String title;
  final Function onPressed;
  SplitTitle({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      leading: Container(
        width: 5,
        height: 50,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      title: Text(
        "$title",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: mainColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          minimumSize: Size(0, 0),
        ),
        child: Text("More", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
