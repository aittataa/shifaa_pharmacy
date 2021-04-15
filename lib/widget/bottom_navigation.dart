import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class BottomNavigation extends StatelessWidget {
  final int index;
  final Function onTap;
  BottomNavigation({this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      backgroundColor: mainColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: false,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          label: "Medicines",
          icon: Icon(CupertinoIcons.bandage_fill),
        ),
        BottomNavigationBarItem(
          label: "Categories",
          icon: Icon(CupertinoIcons.layers_alt_fill),
        ),
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(CupertinoIcons.house_alt_fill),
        ),
        BottomNavigationBarItem(
          label: "Brands",
          icon: Icon(CupertinoIcons.shield_lefthalf_fill),
        ),
        BottomNavigationBarItem(
          label: "Offers",
          icon: Icon(CupertinoIcons.checkmark_seal_fill),
        ),
      ],
    );
  }
}
