import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/controllers/clients_controller.dart';
import 'package:shifaa_pharmacy/controllers/orders_controller.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/modal_progress_indicator.dart';
import 'package:shifaa_pharmacy/widget/registration_button.dart';
import 'package:shifaa_pharmacy/widget/text_box.dart';

class OrderAddress extends StatefulWidget {
  static const String id = "OrderAddress";

  final int orderID;
  OrderAddress({this.orderID});

  @override
  _OrderAddressState createState() => _OrderAddressState();
}

class _OrderAddressState extends State<OrderAddress> {
  final ClientsController clientsController = Get.put(ClientsController());
  final OrdersController ordersController = Get.put(OrdersController());
  int orderID;
  @override
  void initState() {
    super.initState();
    orderID = widget.orderID;
  }

  var address = TextEditingController();
  var zipCode = TextEditingController();
  var city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressIndicator(
      inAsyncCall: isAsyncCall,
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          elevation: 1,
          title: Text("Delivery Address", style: TextStyle(fontWeight: FontWeight.bold)),
          leading: BackIconButton(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              if (Constant.signInClient.address.isNotEmpty)
                Column(
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        setState(() => isAsyncCall = true);
                        bool state = await ordersController.updateOrder(orderID);
                        if (state) {
                          isAsyncCall = false;
                          Navigator.pop(context);
                        }
                      },
                      color: mainColor,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      minWidth: double.infinity,
                      elevation: 3,
                      highlightElevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "${Constant.signInClient.address} - ${Constant.signInClient.zipCode} ${Constant.signInClient.city}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "- OR -",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              Column(
                children: [
                  TextBox(
                    controller: address,
                    hintText: "Address",
                    icon: CupertinoIcons.house_fill,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  TextBox(
                    controller: zipCode,
                    hintText: "Code Postal",
                    icon: CupertinoIcons.location_solid,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  TextBox(
                    controller: city,
                    hintText: "City",
                    icon: CupertinoIcons.building_2_fill,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: RegistrationButton(
                      text: "Save Address",
                      textColor: mainColor,
                      backColor: Colors.white,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        setState(() => isAsyncCall = true);
                        bool isAddress = GetUtils.isLengthGreaterThan(address.text.trim(), 6);
                        bool isZipCode = int.tryParse(zipCode.text.trim(), radix: 10) != null;
                        bool isCity = city.text.trim().isNotEmpty;

                        if (isAddress && isZipCode && isCity) {
                          int code = int.tryParse(zipCode.text.trim(), radix: 10);
                          bool state = await clientsController.updateClientAddress(
                            Client(
                              id: Constant.signInClient.id,
                              address: address.text.trim().toUpperCase(),
                              zipCode: code,
                              city: city.text.trim().toUpperCase(),
                            ),
                          );
                          if (state) {
                            bool state = await ordersController.updateOrder(orderID);
                            if (state) {
                              isAsyncCall = false;
                              Navigator.pop(context);
                            }
                          }
                        } else {
                          String title = "";
                          String message = "";
                          if (!isAddress) {
                            title = "Address Invalid";
                            message = "Type Your Address";
                          } else if (!isZipCode) {
                            title = "Zip Code Invalid";
                            message = "Type Valid Zip Code";
                          } else if (!isCity) {
                            title = "City Empty";
                            message = "Input City Name";
                          }
                          errorSnackBar(context, title: title, message: message);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
