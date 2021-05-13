import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class ListTileDetails extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;
  ListTileDetails({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: mainColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          "$text",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
