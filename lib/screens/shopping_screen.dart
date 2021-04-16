import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/contain.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/contains_provider.dart';
import 'package:shifaa_pharmacy/provider/orders_provider.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/order_address.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class ShoppingScreen extends StatelessWidget {
  static const String id = "ShoppingScreen";
  final bool isNotEmpty = myShoppingList.isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Consumer2<OrdersProvider, ContainsProvider>(
      builder: (context, orderProvider, containProvider, child) {
        orderProvider.loadOrders;
        containProvider.loadContains;
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text("Shopping", style: TextStyle(fontWeight: FontWeight.bold)),
            leading: BackIconButton(),
            actions: [
              FunctionIconButton(
                icon: Icons.receipt_long,
                onPressed: () {
                  Navigator.popAndPushNamed(context, PrescriptionScreen.id);
                },
              ),
              FunctionIconButton(
                icon: Icons.favorite,
                onPressed: () async {
                  var myList = favoriteProductsList.where((product) {
                    return product.isFav == true;
                  }).toList();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(myList: myList),
                    ),
                  );
                },
              ),
            ],
          ),
          body: BodyShape(
            enable: false,
            child: isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    physics: BouncingScrollPhysics(),
                    itemCount: myShoppingList.length,
                    itemBuilder: (context, index) {
                      Order order = myShoppingList[index];
                      List<Contain> myList = containList.where((contain) {
                        return contain.orderID == order.id;
                      }).toList();
                      return ExpansionTile(
                        initiallyExpanded: !order.isValid,
                        tilePadding: EdgeInsets.zero,
                        title: displayShippingList(
                          order: order,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderAddress(
                                  orderID: order.id,
                                  clientID: signInClient.id,
                                ),
                              ),
                            );
                          },
                        ),
                        children: List.generate(myList.length, (index) {
                          Contain contain = myList[index];
                          return displayContain(
                            contain: contain,
                            isValid: order.isValid,
                            onTap: () async {
                              int id = contain.id;
                              bool state = await containProvider.updateContain(id);
                              if (state) {
                                await containProvider.loadContains;
                              }
                            },
                          );
                        }),
                      );
                    },
                  )
                : EmptyBox(),
          ),
        );
      },
    );
  }
}
