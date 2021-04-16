import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/classes/prescription.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/orders_provider.dart';
import 'package:shifaa_pharmacy/provider/prescriptions_provider.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/order_address.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';
import 'package:shifaa_pharmacy/widget/prescription_details.dart';

class PrescriptionScreen extends StatelessWidget {
  static const String id = "PrescriptionDetails";
  final bool isNotEmpty = myPrescriptionList.isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Consumer2<OrdersProvider, PrescriptionsProvider>(
      builder: (context, orderProvider, prescriptionProvider, child) {
        orderProvider.loadOrders;
        prescriptionProvider.loadPrescriptions;
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text("Prescription", style: TextStyle(fontWeight: FontWeight.bold)),
            leading: BackIconButton(),
            actions: [
              FunctionIconButton(
                icon: Icons.shopping_cart,
                onPressed: () {
                  Navigator.popAndPushNamed(context, ShoppingScreen.id);
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
                  )
                : EmptyBox(),
          ),
        );
      },
    );
  }
}
