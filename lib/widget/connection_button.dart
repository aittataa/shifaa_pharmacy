import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class ConnectionButton extends StatelessWidget {
  final String image;
  final Function onTap;
  ConnectionButton({this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        shadowColor: backColor,
        elevation: 10,
        child: Image.asset(
          "images/$image",
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
