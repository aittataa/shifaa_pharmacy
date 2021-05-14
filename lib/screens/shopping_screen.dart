import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/contain.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/controllers/contains_controller.dart';
import 'package:shifaa_pharmacy/controllers/orders_controller.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/order_address.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class ShoppingScreen extends StatelessWidget {
  static const String id = "ShoppingScreen";
  final OrdersController ordersController = Get.put(OrdersController());
  final ContainsController containsController = Get.put(ContainsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          Messages.SHOPPING_SCREEN_TITLE,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackIconButton(),
        actions: [
          FunctionIconButton(
            icon: Icons.receipt_long,
            onPressed: () {
              Get.off(PrescriptionScreen());
            },
          ),
          FunctionIconButton(
            icon: Icons.favorite,
            onPressed: () {
              Get.to(FavoriteScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        final List<Order> myShoppingList = ordersController.myShoppingList;
        final bool isNotEmpty = myShoppingList.isNotEmpty;
        if (isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5),
            physics: BouncingScrollPhysics(),
            itemCount: myShoppingList.length,
            itemBuilder: (context, index) {
              Order order = myShoppingList[index];
              var myList = containsController.containList.where((contain) {
                return contain.orderID == order.id;
              }).toList();
              return ExpansionTile(
                initiallyExpanded: !order.isValid,
                tilePadding: EdgeInsets.zero,
                title: displayShippingList(
                  order: order,
                  onTap: () => Get.to(OrderAddress(orderID: order.id)),
                ),
                children: List.generate(myList.length, (index) {
                  Contain contain = myList[index];
                  return displayContain(
                    contain: contain,
                    isValid: order.isValid,
                    onTap: () async {
                      int id = contain.id;
                      bool state = await containsController.updateContain(id);
                      print(state);
                    },
                  );
                }),
              );
            },
          );
        } else {
          return EmptyBox();
        }
      }),
    );
  }
}
