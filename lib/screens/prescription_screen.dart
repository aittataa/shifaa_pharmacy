import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/classes/prescription.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/controllers/orders_controller.dart';
import 'package:shifaa_pharmacy/controllers/prescriptions_controller.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/order_address.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class PrescriptionScreen extends StatelessWidget {
  static const String id = "PrescriptionDetails";
  final ordersController = Get.put(OrdersController());
  final prescriptionsController = Get.put(PrescriptionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          Messages.PRESCRIPTION_SCREEN_TITLE,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackIconButton(),
        actions: [
          FunctionIconButton(
            icon: Icons.shopping_cart,
            onPressed: () {
              Get.off(ShoppingScreen());
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
        final List<Order> myPrescriptionList = ordersController.myPrescriptionList;
        final bool isNotEmpty = myPrescriptionList.isNotEmpty;
        if (isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5),
            physics: BouncingScrollPhysics(),
            itemCount: myPrescriptionList.length,
            itemBuilder: (context, index) {
              Order order = myPrescriptionList[index];
              var myList = prescriptionsController.prescriptionList.where((prescription) {
                return prescription.orderID == order.id;
              }).toList();
              return ExpansionTile(
                initiallyExpanded: !order.isValid,
                tilePadding: EdgeInsets.zero,
                title: displayPrescriptionList(
                  order: order,
                  onTap: () => Get.to(OrderAddress(orderID: order.id)),
                ),
                children: List.generate(myList.length, (index) {
                  Prescription prescription = myList[index];
                  return displayPrescription(
                    prescription: prescription,
                    isValid: order.isValid,
                    onTap: () async {
                      int id = prescription.id;
                      bool state = await prescriptionsController.updatePrescription(id);
                      print(state);
                    },
                    /*
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
                    */
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
