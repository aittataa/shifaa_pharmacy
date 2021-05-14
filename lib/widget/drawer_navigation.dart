import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/clients_controller.dart';
import 'package:shifaa_pharmacy/screens/profile_screen.dart';

import '../constant/constant.dart';
import '../screens/about_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/login_screen.dart';
import '../screens/prescription_screen.dart';
import '../screens/shopping_screen.dart';
import 'divider_line.dart';
import 'horizontal_button.dart';
import 'vertical_button.dart';

class DrawerNavigation extends StatelessWidget {
  final ClientsController controller;
  DrawerNavigation({this.controller});

  final bool state = SharedFunctions.isClientLogged;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1500),
        curve: Curves.linearToEaseOut,
        color: mainColor,
        width: screenWidth * 0.85,
        child: SafeArea(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: screenHeight * 0.15,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: state
                            ? NetworkImage("${Constant.signInClient.picture}")
                            : AssetImage(Messages.APP_ICON_ROUND),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 90,
                          spreadRadius: -15,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero.copyWith(left: 10),
                    title: Text(
                      state ? "${Constant.signInClient.username}" : Messages.APP_TITLE,
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      state ? "${Constant.signInClient.email}" : Messages.APP_DESC,
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (state) {
                          Navigator.pop(context);
                          Get.to(ProfileScreen());
                        } else {
                          Get.offAll(LoginScreen());
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  ),
                ],
              ),
              DividerLine(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HorizontalButton(
                    icon: Icons.shopping_cart,
                    title: Messages.LABEL_SHOPPING,
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(ShoppingScreen());
                    },
                  ),
                  HorizontalButton(
                    icon: Icons.receipt_long,
                    title: Messages.LABEL_PRESCRIPTION,
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(PrescriptionScreen());
                    },
                  ),
                  HorizontalButton(
                    icon: Icons.favorite,
                    title: Messages.LABEL_WISH_LIST,
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(FavoriteScreen());
                    },
                  ),
                ],
              ),
              DividerLine(),
              Expanded(
                child: Column(
                  children: [
                    VerticalButton(
                      icon: CupertinoIcons.house_alt_fill,
                      title: Messages.LABEL_HOME,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    VerticalButton(
                      icon: CupertinoIcons.gear_alt_fill,
                      title: Messages.LABEL_SETTINGS,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              DividerLine(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HorizontalButton(
                    icon: Icons.info,
                    title: Messages.LABEL_ABOUT,
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(AboutScreen());
                    },
                  ),
                  HorizontalButton(
                    icon: CupertinoIcons.escape,
                    title: state ? Messages.LABEL_SIGN_OUT : Messages.LABEL_SIGN_IN,
                    onPressed: () {
                      controller.clear;
                      Get.offAll(LoginScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
