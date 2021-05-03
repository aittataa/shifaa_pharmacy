import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/sub_categories.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class SubCategoryShape extends StatelessWidget {
  final SubCategories subCategory;
  final bool option;
  final Function onTap;
  const SubCategoryShape({this.subCategory, this.option, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: option ? mainColor : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          "${subCategory.title}",
          style: TextStyle(
            color: option ? Colors.white : Colors.black26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
