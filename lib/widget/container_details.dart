import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class ContainerDetails extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;
  ContainerDetails({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.only(top: 5, bottom: 1),
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                "$text",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Image.asset(
              "images/right.png",
              width: 25,
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
