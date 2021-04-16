import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/clients_provider.dart';
import 'package:shifaa_pharmacy/provider/orders_provider.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/modal_progress_indicator.dart';
import 'package:shifaa_pharmacy/widget/registration_button.dart';
import 'package:shifaa_pharmacy/widget/text_box.dart';

class OrderAddress extends StatefulWidget {
  static const String id = "OrderAddress";

  final int orderID;
  final int clientID;
  OrderAddress({
    this.orderID,
    this.clientID,
  });

  @override
  _OrderAddressState createState() => _OrderAddressState();
}

class _OrderAddressState extends State<OrderAddress> {
  @override
  void initState() {
    super.initState();
    isAddressExist = signInClient.address.isNotEmpty;

    clientID = widget.clientID;
    orderID = widget.orderID;
    address.text = "";
    zipCode.text = "";
    city.text = "";
  }

  int clientID;
  int orderID;
  var address = TextEditingController();
  var zipCode = TextEditingController();
  var city = TextEditingController();

  bool isAddressValid = false;
  bool isZipCodeValid = false;
  bool isCityValid = false;

  bool isAddressExist;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ClientsProvider, OrdersProvider>(
      builder: (context, clientProvider, orderProvider, child) {
        clientProvider.loadClients;
        orderProvider.loadOrders;
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
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  if (isAddressExist)
                    MaterialButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        setState(() => isAsyncCall = true);
                        bool state = await orderProvider.updateOrder(orderID);
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
                        '''${signInClient.address} - ${signInClient.zipCode} ${signInClient.city}''',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  if (isAddressExist)
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
                  Column(
                    children: [
                      TextBox(
                        controller: address,
                        hintText: "Address",
                        icon: Icons.home,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      TextBox(
                        controller: zipCode,
                        hintText: "Code Postal",
                        icon: Icons.location_on,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                      TextBox(
                        controller: city,
                        hintText: "City",
                        icon: Icons.location_city,
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

                            isAddressValid =
                                address.text.trim().isNotEmpty && address.text.trim().length > 5;
                            isZipCodeValid = int.tryParse(zipCode.text.trim(), radix: 10) != null;
                            isCityValid = city.text.trim().isNotEmpty;

                            if (isAddressValid && isZipCodeValid && isCityValid) {
                              int code = int.tryParse(zipCode.text.trim(), radix: 10);
                              bool state = await clientProvider.updateClientAddress(
                                Client(
                                  id: clientID,
                                  address: address.text.trim().toUpperCase(),
                                  zipCode: code,
                                  city: city.text.trim().toUpperCase(),
                                ),
                              );
                              if (state) {
                                bool state = await orderProvider.updateOrder(orderID);
                                if (state) {
                                  isAsyncCall = false;
                                  Navigator.pop(context);
                                }
                              }
                            } else {
                              String title = "";
                              String message = "";
                              if (!isAddressValid) {
                                title = "Address Invalid";
                                message = "Type Your Address";
                              } else if (!isZipCodeValid) {
                                title = "Zip Code Invalid";
                                message = "Type Valid Zip Code";
                              } else if (!isCityValid) {
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
      },
    );
  }
}
