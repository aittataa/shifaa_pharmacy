import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';

import '../classes/product.dart';
import '../widget/empty_box.dart';

class OffersPage extends StatelessWidget {
  final controller;
  const OffersPage({this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Product> myList = controller.productsList;
      bool isNotEmpty = myList.isNotEmpty;
      if (isNotEmpty) {
        return Center(
          child: Text(
            Messages.LABEL_OFFERS,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        return EmptyBox();
      }
    });
  }
}
