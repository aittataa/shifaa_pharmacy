import 'package:flutter/material.dart';

class VerticalButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  VerticalButton({this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      tileColor: title.contains("Home") ? Colors.black12 : Colors.transparent,
      contentPadding: EdgeInsets.zero.copyWith(left: 10),
      leading: Icon(icon),
      title: Text(
        "$title",
        maxLines: 1,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
