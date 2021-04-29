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
    this.enable = false,
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
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 90,
                  spreadRadius: -15,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero.copyWith(left: 10),
                minLeadingWidth: 0,
                minVerticalPadding: 0,
                horizontalTitleGap: 5,
                leading: Icon(Icons.search, color: mainColor),
                title: TextField(
                  onChanged: onChanged,
                  controller: controller,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  cursorColor: mainColor,
                  scrollPadding: EdgeInsets.zero,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                  ),
                ),
                trailing: IconButton(
                  onPressed: onPressed,
                  color: mainColor,
                  icon: Icon(Icons.clear_outlined),
                ),
              ),
            ),
          ),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
