import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class SpinIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: 64,
      color: mainColor,
      duration: Constant.duration,
    );
  }
}
