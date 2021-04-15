import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/classes/prescription.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/orders_provider.dart';
import 'package:shifaa_pharmacy/provider/prescriptions_provider.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';
import 'package:shifaa_pharmacy/widget/modal_progress_indicator.dart';

class PrescriptionManager extends StatefulWidget {
  static const String id = "PrescriptionScreen";
  final ImageSource source;
  PrescriptionManager({this.source});
  @override
  _PrescriptionManagerState createState() => _PrescriptionManagerState();
}

class _PrescriptionManagerState extends State<PrescriptionManager> {
  void initState() {
    super.initState();
    getImage(widget.source);
  }

  var description = TextEditingController();
  File imageFile;
  String imageString;
  final picker = ImagePicker();
  getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile.path != null) {
        imageFile = File(pickedFile.path);
        imageString = base64Encode(imageFile.readAsBytesSync());
      } else {
        print("No image selected.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<OrdersProvider, PrescriptionsProvider>(
      builder: (context, orderProvider, prescriptionProvider, child) {
        orderProvider.loadOrders;
        prescriptionProvider.loadPrescriptions;
        return ModalProgressIndicator(
          inAsyncCall: isAsyncCall,
          child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text("Send Prescription", style: TextStyle(fontWeight: FontWeight.bold)),
              leading: BackIconButton(),
              actions: [
                FunctionIconButton(
                  icon: CupertinoIcons.camera_fill,
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                ),
                FunctionIconButton(
                  icon: CupertinoIcons.photo_fill_on_rectangle_fill,
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                )
              ],
            ),
            body: BodyShape(
              enable: false,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: imageFile != null
                              ? Image.file(imageFile)
                              : Text(
                                  "Pick Prescription!",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: ListTile(
                        horizontalTitleGap: 5,
                        minVerticalPadding: 0,
                        contentPadding: EdgeInsets.zero,
                        title: TextField(
                          controller: description,
                          textInputAction: TextInputAction.done,
                          minLines: 1,
                          maxLines: 4,
                          cursorColor: Colors.black54,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                          scrollPadding: EdgeInsets.zero,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                width: 2,
                                color: mainColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                width: 2,
                                color: mainColor,
                              ),
                            ),
                            hintText: "Type Something ...",
                            hintStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            minimumSize: Size(0, 0),
                          ),
                          child: Icon(
                            CupertinoIcons.paperplane_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            try {
                              setState(() => isAsyncCall = true);
                              int id = signInClient.id;
                              String number = "${id}_${Random().nextInt(999999)}";
                              String picture = "${number}_${imageFile.path.split('/').last}";
                              listOfPrescriptions = await orderProvider.getPrescriptionOrder(id);
                              Order lastOrder;
                              if (listOfPrescriptions.isNotEmpty) {
                                lastOrder = listOfPrescriptions.first;
                                if (!lastOrder.isValid) {
                                  bool state = await prescriptionProvider.addPrescription(
                                    Prescription(
                                      picture: picture,
                                      file: imageString,
                                      description: description.text.trim(),
                                      order_id: lastOrder.id,
                                    ),
                                  );
                                  if (state) {
                                    isAsyncCall = false;
                                    Navigator.popAndPushNamed(context, PrescriptionScreen.id);
                                  }
                                } else {
                                  bool state = await orderProvider.addOrder(
                                    Order(type: "PRESCRIPTION", client_id: id),
                                  );
                                  if (state) {
                                    listOfPrescriptions =
                                        await orderProvider.getPrescriptionOrder(id);
                                    if (listOfPrescriptions.isNotEmpty) {
                                      lastOrder = listOfPrescriptions.first;
                                      bool state = await prescriptionProvider.addPrescription(
                                        Prescription(
                                          picture: picture,
                                          file: imageString,
                                          description: description.text.trim(),
                                          order_id: lastOrder.id,
                                        ),
                                      );
                                      if (state) {
                                        isAsyncCall = false;
                                        Navigator.popAndPushNamed(context, PrescriptionScreen.id);
                                      }
                                    }
                                  }
                                }
                              } else {
                                bool state = await orderProvider.addOrder(
                                  Order(type: "PRESCRIPTION", client_id: id),
                                );
                                if (state) {
                                  listOfPrescriptions =
                                      await orderProvider.getPrescriptionOrder(id);
                                  if (listOfPrescriptions.isNotEmpty) {
                                    lastOrder = listOfPrescriptions.first;
                                    bool state = await prescriptionProvider.addPrescription(
                                      Prescription(
                                        picture: picture,
                                        file: imageString,
                                        description: description.text.trim(),
                                        order_id: lastOrder.id,
                                      ),
                                    );
                                    if (state) {
                                      isAsyncCall = false;
                                      Navigator.popAndPushNamed(context, PrescriptionScreen.id);
                                    }
                                  }
                                }
                              }
                            } catch (e) {
                              setState(() => isAsyncCall = false);
                              errorSnackBar(
                                context,
                                title: "Prescription Error",
                                message: "Pick Prescription To Send",
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
