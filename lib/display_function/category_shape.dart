import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';

class CategoryShape extends StatelessWidget {
  final item;
  final BoxFit fit;
  final Function onTap;
  const CategoryShape({this.item, this.fit, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(fit: fit, image: NetworkImage("${item.picture}")),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
              child: Text(
                "${item.title}",
                softWrap: false,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
