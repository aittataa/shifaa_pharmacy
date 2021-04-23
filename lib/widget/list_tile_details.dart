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
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      leading: Container(
        decoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
        padding: EdgeInsets.all(5),
        child: Icon(icon, color: Colors.white, size: 30),
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
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
