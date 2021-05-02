import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  final double value;
  const DividerLine({this.value = 0});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 5,
      thickness: 1,
      indent: value,
      endIndent: value,
      color: Colors.white,
    );
  }
}
