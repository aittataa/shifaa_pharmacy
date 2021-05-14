import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';

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
      tileColor: title.contains(Messages.LABEL_HOME) ? Colors.black12 : Colors.transparent,
      leading: Icon(icon),
      title: Text(
        "$title",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
