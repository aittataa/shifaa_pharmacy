import 'package:flutter/material.dart';

class EmptyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Empty",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
