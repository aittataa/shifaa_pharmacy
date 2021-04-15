import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class BodyShape extends StatelessWidget {
  final Widget child;
  final bool enable;
  final Function onChanged;
  final Function onPressed;
  final TextEditingController controller;
  BodyShape({
    @required this.child,
    this.enable = true,
    this.controller,
    this.onChanged,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (enable)
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, color: mainColor),
                ),
                Expanded(
                  child: TextField(
                    onChanged: onChanged,
                    controller: controller,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.red,
                  onPressed: onPressed,
                  icon: Icon(Icons.close, color: Colors.black38),
                ),
              ],
            ),
          ),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
