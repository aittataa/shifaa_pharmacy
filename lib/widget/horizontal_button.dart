import 'package:flutter/material.dart';

class HorizontalButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onPressed;

  HorizontalButton({
    this.icon,
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10),
        minimumSize: Size.zero,
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(height: 5),
          Text(
            "$title",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
