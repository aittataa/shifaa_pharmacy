import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../classes/order.dart';
import '../classes/prescription.dart';
import '../constant/constant.dart';
import '../controllers/orders_controller.dart';
import '../controllers/prescriptions_controller.dart';
import '../screens/prescription_screen.dart';
import '../widget/back_icon.dart';
import '../widget/function_button.dart';
import '../widget/modal_progress_indicator.dart';

class PrescriptionManager extends StatefulWidget {
  static const String id = "PrescriptionScreen";
  final ImageSource source;
  PrescriptionManager({this.source});
  @override
  _PrescriptionManagerState createState() => _PrescriptionManagerState();
}

class _PrescriptionManagerState extends State<PrescriptionManager> {
  final OrdersController ordersController = Get.put(OrdersController());
  final PrescriptionsController prescriptionsController = Get.put(PrescriptionsController());

  void initState() {
    super.initState();
    getImage(widget.source);
  }

  var description = TextEditingController();
  File imageFile;
  String imageString;
  getImage(ImageSource source) async {
    final picker = ImagePicker();
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

  bool isAsyncCall = false;

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(1),
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
              ListTile(
                horizontalTitleGap: 5,
                minVerticalPadding: 5,
                contentPadding: EdgeInsets.zero,
                title: TextField(
                  controller: description,
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  maxLines: 3,
                  style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  cursorColor: mainColor,
                  scrollPadding: EdgeInsets.zero,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: mainColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        width: 2.5,
                        color: mainColor,
                      ),
                    ),
                    hintText: "Type Something...",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                trailing: TextButton(
                  child: Icon(CupertinoIcons.paperplane_fill, color: Colors.white),
                  style: TextButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                    minimumSize: Size(0, 0),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    setState(() => isAsyncCall = true);
                    try {
                      int id = Constant.signInClient.id;
                      String number = "${id}_${Random().nextInt(999999)}";
                      String picture = "${number}_${imageFile.path.split('/').last}";
                      listOfPrescriptions = await ordersController.getPrescriptionOrder(id);
                      Order lastOrder;
                      if (listOfPrescriptions.isNotEmpty) {
                        lastOrder = listOfPrescriptions.first;
                        if (!lastOrder.isValid) {
                          bool state = await prescriptionsController.addPrescription(
                            Prescription(
                              picture: picture,
                              file: imageString,
                              description: description.text.trim(),
                              orderID: lastOrder.id,
                            ),
                          );
                          if (state) {
                            isAsyncCall = false;
                            Navigator.popAndPushNamed(context, PrescriptionScreen.id);
                          } else {
                            setState(() => isAsyncCall = false);
                            errorSnackBar(
                              context,
                              title: "Prescription Error",
                              message: "Something Wrong, Try Again",
                            );
                          }
                        } else {
                          bool state = await ordersController.addOrder(
                            Order(type: "PRESCRIPTION", clientID: id),
                          );
                          if (state) {
                            listOfPrescriptions = await ordersController.getPrescriptionOrder(id);
                            if (listOfPrescriptions.isNotEmpty) {
                              lastOrder = listOfPrescriptions.first;
                              bool state = await prescriptionsController.addPrescription(
                                Prescription(
                                  picture: picture,
                                  file: imageString,
                                  description: description.text.trim(),
                                  orderID: lastOrder.id,
                                ),
                              );
                              if (state) {
                                isAsyncCall = false;
                                Navigator.popAndPushNamed(context, PrescriptionScreen.id);
                              } else {
                                setState(() => isAsyncCall = false);
                                errorSnackBar(
                                  context,
                                  title: "Prescription Error",
                                  message: "Something Wrong, Try Again",
                                );
                              }
                            }
                          }
                        }
                      } else {
                        bool state = await ordersController.addOrder(
                          Order(type: "PRESCRIPTION", clientID: id),
                        );
                        if (state) {
                          listOfPrescriptions = await ordersController.getPrescriptionOrder(id);
                          if (listOfPrescriptions.isNotEmpty) {
                            lastOrder = listOfPrescriptions.first;
                            bool state = await prescriptionsController.addPrescription(
                              Prescription(
                                picture: picture,
                                file: imageString,
                                description: description.text.trim(),
                                orderID: lastOrder.id,
                              ),
                            );
                            if (state) {
                              isAsyncCall = false;
                              Navigator.popAndPushNamed(context, PrescriptionScreen.id);
                            } else {
                              setState(() => isAsyncCall = false);
                              errorSnackBar(
                                context,
                                title: "Prescription Error",
                                message: "Something Wrong, Try Again",
                              );
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
            ],
          ),
        ),
      ),
    );
  }
}
