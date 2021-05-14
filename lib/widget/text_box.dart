import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class TextBox extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget suffixIcon;
  const TextBox({
    this.controller,
    this.icon,
    this.hintText,
    this.textInputType,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.only(left: 10, right: 5),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        cursorColor: Colors.white,
        obscureText: obscureText,
        obscuringCharacter: "●",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: Colors.white),
          suffixIcon: suffixIcon,
          hintText: hintText,
        ),
      ),
    );
  }
}
