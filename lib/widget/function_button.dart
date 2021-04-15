import 'package:flutter/material.dart';

class FunctionIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onPressed;
  FunctionIconButton({
    this.icon,
    this.color = Colors.white,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(icon, color: color, size: 27),
    );
  }
}
