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
      elevation: 10,
      currentIndex: index,
      backgroundColor: mainColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          label: "Medicines",
          icon: Icon(CupertinoIcons.bandage),
          activeIcon: Icon(CupertinoIcons.bandage_fill),
        ),
        BottomNavigationBarItem(
          label: "Categories",
          icon: Icon(CupertinoIcons.layers_alt),
          activeIcon: Icon(CupertinoIcons.layers_alt_fill),
        ),
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(CupertinoIcons.house_alt),
          activeIcon: Icon(CupertinoIcons.house_alt_fill),
        ),
        BottomNavigationBarItem(
          label: "Brands",
          icon: Icon(CupertinoIcons.shield_lefthalf_fill),
          activeIcon: Icon(CupertinoIcons.shield_fill),
        ),
        BottomNavigationBarItem(
          label: "Offers",
          icon: Icon(CupertinoIcons.checkmark_seal),
          activeIcon: Icon(CupertinoIcons.checkmark_seal_fill),
        ),
      ],
    );
  }
}
