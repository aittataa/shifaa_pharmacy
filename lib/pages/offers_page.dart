import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/favorite.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';

import '../widget/empty_box.dart';

class OffersPage extends StatelessWidget {
  final ProductsController controller;
  const OffersPage({this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Favorite> myList = controller.favoriteProductsList;
      bool isNotEmpty = myList.isNotEmpty;
      if (isNotEmpty) {
        return ListView.builder(itemBuilder: (context, index) {
          Favorite favorite = myList[index];
          return ListTile(
            leading: Text("${favorite.id}"),
            title: Text("${favorite.clientID} ${favorite.productID}"),
          );
        });
        // return Center(
        //   child: Text(
        //     Messages.LABEL_OFFERS,
        //     style: TextStyle(
        //       color: Colors.black54,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // );
      } else {
        return EmptyBox();
      }
    });
  }
}
