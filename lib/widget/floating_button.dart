import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/screens/prescription_manager.dart';

class ActionFloatingButton extends StatelessWidget {
  final bool state = SharedFunctions.isClientLogged;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      visible: state,
      backgroundColor: mainColor,
      foregroundColor: Colors.white,
      elevation: 1,
      overlayOpacity: 0.5,
      overlayColor: backColor,
      tooltip: Messages.PICK_MESSAGE,
      icon: CupertinoIcons.add,
      activeIcon: CupertinoIcons.xmark,
      marginBottom: 10,
      marginEnd: 5,
      orientation: SpeedDialOrientation.Up,
      curve: Curves.linearToEaseOut,
      animationSpeed: 250,
      children: [
        SpeedDialChild(
          label: Messages.LABEL_CAMERA,
          labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
          child: Icon(CupertinoIcons.camera_fill),
          backgroundColor: Colors.white,
          foregroundColor: mainColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrescriptionManager(
                  source: ImageSource.camera,
                ),
              ),
            );
          },
        ),
        SpeedDialChild(
          label: Messages.LABEL_GALLERY,
          labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
          child: Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
          backgroundColor: Colors.white,
          foregroundColor: mainColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrescriptionManager(
                  source: ImageSource.gallery,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
