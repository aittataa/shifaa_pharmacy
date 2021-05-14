import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';

class EmptyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Messages.EMPTY_MESSAGE,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
