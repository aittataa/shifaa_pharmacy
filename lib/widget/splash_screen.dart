import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/widget/spin_indicator.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: screenHeight * 0.25,
            width: screenHeight * 0.25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Messages.APP_ICON_ROUND),
              ),
              boxShadow: [Constant.boxShadow],
            ),
          ),
        ),
        SpinIndicator(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          title: Text(
            Messages.APP_TITLE,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          subtitle: Text(
            Messages.APP_DESC,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
