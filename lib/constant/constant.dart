import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';

class Constant {
  /// TODO : REST API
  static const String SERVER_URL = "http://192.168.1.27/.shifaa_pharmacy";

  /// TODO : Sign In Client
  static Client signInClient;

  /// TODO : Page Index
  static int pageIndex = 2;
  static PageController pageController = PageController();

  /// TODO : Duration
  static const Curve curve = Curves.linearToEaseOut;
  static const Duration duration = Duration(milliseconds: 1500);
  static const Duration durationCupertinoAlertDialog = Duration(milliseconds: 1500);

  /// TODO : Constant Titles
  static const List<String> listTitles = [
    Messages.LABEL_MEDICINES,
    Messages.LABEL_CATEGORIES,
    Messages.APP_TITLE,
    Messages.LABEL_BRANDS,
    Messages.LABEL_OFFERS,
  ];

  static const boxShadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 90,
    spreadRadius: -15,
  );
}

///Main Color
const Color mainColor = Color(0xFF0EBE60);
//const Color mainColor = Color(0xFF0FC864);
//const Color mainColor = Color(0xFF01BE6E);
//const Color mainColor = Color(0xFF10E874);
//const Color mainColor = Color(0xFF00FF04);
//const Color mainColor = Color(0xFF01CC7D);
//const Color mainColor = Color(0xFF0EBE60);
//const Color mainColor = Color(0xFF10E874);

///Back Color
const Color backColor = Color(0xFFF0F0F0);

///Device Resolution
double screenWidth = Get.width;
double screenHeight = Get.height;
