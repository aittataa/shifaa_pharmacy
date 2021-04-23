import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class TextBox extends StatelessWidget {
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String hintText;
  final IconData icon;
  final Widget suffixIcon;
  final bool obscureText;
  final TextEditingController controller;

  TextBox({
    this.controller,
    this.textInputType,
    this.textInputAction,
    this.hintText,
    this.icon,
    this.suffixIcon,
    this.obscureText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        textInputAction: textInputAction,
        controller: controller,
        keyboardType: textInputType,
        cursorColor: Colors.white,
        obscureText: hintText.contains("Password") ? obscureText : false,
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: Colors.white),
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
