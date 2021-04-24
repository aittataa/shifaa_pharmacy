import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/contain.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/classes/prescription.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/contains_provider.dart';
import 'package:shifaa_pharmacy/provider/orders_provider.dart';
import 'package:shifaa_pharmacy/provider/prescriptions_provider.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/order_address.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';
import 'package:shifaa_pharmacy/widget/prescription_details.dart';

class ShoppingScreen extends StatelessWidget {
  static const String id = "ShoppingScreen";
  final bool isNotEmpty = myShoppingList.isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Consumer3<OrdersProvider, ContainsProvider, PrescriptionsProvider>(
      builder: (context, orderProvider, containProvider, prescriptionProvider, child) {
        orderProvider.loadOrders;
        containProvider.loadContains;
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text("My Card", style: TextStyle(fontWeight: FontWeight.bold)),
            leading: BackIconButton(),
            actions: [
              // FunctionIconButton(
              //   icon: Icons.receipt_long,
              //   onPressed: () {
              //     Navigator.popAndPushNamed(context, PrescriptionScreen.id);
              //   },
              // ),
              FunctionIconButton(
                icon: Icons.favorite,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(
                        myList: favoriteProductsList.where((product) {
                          return product.isFav == true;
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: PageView(
            children: [
              ListView.builder(
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
              ),
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5),
                physics: BouncingScrollPhysics(),
                itemCount: myPrescriptionList.length,
                itemBuilder: (context, index) {
                  Order order = myPrescriptionList[index];
                  List<Prescription> myList = prescriptionList.where((prescription) {
                    return prescription.orderID == order.id;
                  }).toList();
                  return ExpansionTile(
                    initiallyExpanded: !order.isValid,
                    tilePadding: EdgeInsets.zero,
                    title: displayPrescriptionList(
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
                      Prescription prescription = myList[index];
                      return displayPrescription(
                        prescription: prescription,
                        isValid: order.isValid,
                        onTap: () async {
                          int id = prescription.id;
                          bool state = await prescriptionProvider.updatePrescription(id);
                          if (state) {
                            prescriptionProvider.loadPrescriptions;
                          }
                        },
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return PrescriptionDetails(prescription: prescription);
                            },
                            backgroundColor: Colors.black54,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
