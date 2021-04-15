import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/prescription.dart';

class PrescriptionDetails extends StatelessWidget {
  final Prescription prescription;
  PrescriptionDetails({this.prescription});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Center(
              child: FadeInImage.assetNetwork(
                placeholder: "assets/twirl.gif",
                image: "${prescription.picture}",
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(5),
            color: Colors.black38,
            constraints: BoxConstraints(maxHeight: 256),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Text(
                "${prescription.description}",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
