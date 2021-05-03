import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';

class FooterNavigation extends StatelessWidget {
  const FooterNavigation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 50,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavigationButton(
              index: 0,
              label: "Medicines",
              icon: CupertinoIcons.bandage_fill,
            ),
            NavigationButton(
              index: 1,
              label: "Categories",
              icon: CupertinoIcons.layers_alt_fill,
            ),
            NavigationButton(
              index: 2,
              label: "Home",
              icon: CupertinoIcons.house_alt_fill,
            ),
            NavigationButton(
              index: 3,
              label: "Brands",
              icon: CupertinoIcons.shield_lefthalf_fill,
            ),
            NavigationButton(
              index: 4,
              label: "Offers",
              icon: CupertinoIcons.checkmark_seal_fill,
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final Function onPressed;
  const NavigationButton({this.index, this.icon, this.label, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10),
          minimumSize: Size.zero,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            if (SharedFunctions.pageIndex == index)
              Text(
                "$label",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //decoration: BoxDecoration(color: mainColor),
        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 90,
              spreadRadius: -15,
            ),
          ],
        ),
        child: ListTile(),
      ),
    );
  }
}
