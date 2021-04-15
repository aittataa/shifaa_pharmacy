import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  final double value;
  const DividerLine({this.value = 0});

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: value,
      endIndent: value,
      height: 5,
      thickness: 1,
      color: Colors.white70,
    );
  }
}
