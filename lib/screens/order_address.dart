import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
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
  final TextEditingController address = TextEditingController();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController city = TextEditingController();

  int orderID;
  @override
  void initState() {
    super.initState();
    orderID = widget.orderID;
  }

  bool isAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressIndicator(
      inAsyncCall: isAsyncCall,
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          elevation: 1,
          title: Text(Messages.ORDER_ADDRESS_TITLE, style: TextStyle(fontWeight: FontWeight.bold)),
          leading: BackIconButton(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              if (Constant.signInClient.address.isNotEmpty)
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: RegistrationButton(
                        text:
                            "${Constant.signInClient.address} - ${Constant.signInClient.zipCode} ${Constant.signInClient.city}",
                        backColor: mainColor,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          setState(() => isAsyncCall = true);
                          bool state = await ordersController.updateOrder(orderID);
                          if (state) {
                            isAsyncCall = false;
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        Messages.OR_MESSAGE,
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
                    hintText: Messages.HINT_ADDRESS,
                    icon: CupertinoIcons.house_fill,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  TextBox(
                    controller: zipCode,
                    hintText: Messages.HINT_ZIP_CODE,
                    icon: CupertinoIcons.location_solid,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  TextBox(
                    controller: city,
                    hintText: Messages.HINT_CITY,
                    icon: CupertinoIcons.building_2_fill,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: RegistrationButton(
                      text: Messages.SAVE_BUTTON,
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
