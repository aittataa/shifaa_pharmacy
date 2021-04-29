import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/clients_provider.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/modal_progress_indicator.dart';
import 'package:shifaa_pharmacy/widget/registration_button.dart';
import 'package:shifaa_pharmacy/widget/text_box.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "ProfileScreen";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool obscureText = true;

  var fullname = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();

  bool isFullnameNotEmpty = false;
  bool isPasswordNotEmpty = false;
  bool isPhoneNotEmpty = false;

  bool isFullNameValid = false;
  bool isPasswordValid = false;
  bool isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    fullname.text = signInClient.username;
    password.text = signInClient.password;
    phone.text = signInClient.phone;

    imageBytes = "";
    imageState = false;
  }

  bool imageState;
  File imagePath;
  String imageBytes;

  pickProfilePic(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      if (pickedFile.path != null) {
        imageState = true;
        imagePath = File(pickedFile.path);
        imageBytes = base64Encode(imagePath.readAsBytesSync());
      } else {
        print("No image selected.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientsProvider>(
      builder: (context, clientProvider, child) {
        clientProvider.loadClients;
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text("Update Account", style: TextStyle(fontWeight: FontWeight.bold)),
            leading: BackIconButton(),
          ),
          body: Builder(builder: (context) {
            return ModalProgressIndicator(
              inAsyncCall: isAsyncCall,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      width: screenHeight * 0.25,
                      height: screenHeight * 0.25,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageState
                              ? FileImage(imagePath)
                              : NetworkImage("${signInClient.picture}"),
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  setState(() => pickProfilePic(ImageSource.gallery));
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: mainColor,
                                  padding: EdgeInsets.all(10),
                                  minimumSize: Size(0, 0),
                                  shape: CircleBorder(),
                                ),
                                child: Icon(CupertinoIcons.camera_fill, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextBox(
                      hintText: "Full Name",
                      icon: CupertinoIcons.person_crop_circle,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      controller: fullname,
                    ),
                    TextBox(
                      hintText: "Password",
                      controller: password,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      icon: CupertinoIcons.lock_shield_fill,
                      obscureText: obscureText,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Icon(
                          Icons.remove_red_eye,
                          color: obscureText ? Colors.black12 : Colors.white,
                        ),
                      ),
                    ),
                    TextBox(
                      hintText: "Phone",
                      controller: phone,
                      icon: CupertinoIcons.phone_fill,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: RegistrationButton(
                        text: "Update",
                        textColor: Colors.white,
                        backColor: mainColor,
                        onPressed: () async {
                          setState(() => isAsyncCall = true);
                          FocusScope.of(context).unfocus();

                          isFullnameNotEmpty = fullname.text.trim().isNotEmpty;
                          isPasswordNotEmpty = password.text.trim().isNotEmpty;
                          isPhoneNotEmpty = phone.text.trim().isNotEmpty;

                          isFullNameValid = fullname.text.trim().length >= 5;
                          isPasswordValid = password.text.length >= 8;
                          isPhoneValid = phone.text.length >= 10;

                          if (isFullnameNotEmpty &&
                              isPasswordValid &&
                              isPhoneNotEmpty &&
                              isFullNameValid &&
                              isPasswordValid &&
                              isPhoneValid) {
                            String imageName = imageState
                                ? "${signInClient.id}_${imagePath.path.split('/').last}"
                                : "${signInClient.picture.split('/').last}";
                            bool state = await clientProvider.updateClientInfo(
                              Client(
                                id: signInClient.id,
                                username: fullname.text.toUpperCase(),
                                email: signInClient.email,
                                password: password.text.trim(),
                                phone: phone.text.trim(),
                                picture: imageName,
                                profile: imageBytes,
                              ),
                            );
                            if (state) {
                              List<Client> myClient = myClientsList.where((client) {
                                return client.email == signInClient.email &&
                                    client.password == password.text.trim();
                              }).toList();
                              if (myClient.isNotEmpty) {
                                signInClient = myClient.first;
                                Navigator.pop(context);
                              }
                            }
                          } else {
                            String title = "";
                            String message = "";
                            if (!isFullnameNotEmpty) {
                              title = "Name Empty";
                              message = "Type Your Name";
                            } else if (!isFullNameValid) {
                              title = "Name Invalid";
                              message = "Name Must Contain Least 5 Characters";
                            } else if (!isPasswordNotEmpty) {
                              title = "Password Empty";
                              message = "Type Your Password";
                            } else if (!isPasswordValid) {
                              title = "Password Invalid";
                              message = "Password Must Contain at Least 8 Characters";
                            } else if (!isPhoneNotEmpty) {
                              title = "Phone Empty";
                              message = "Type Your Phone Number";
                            } else if (!isPhoneValid) {
                              title = "Phone Number Invalid";
                              message = "Check Your Phone Number";
                            }
                            errorSnackBar(
                              context,
                              title: title,
                              message: message,
                            );
                          }
                          setState(() => isAsyncCall = false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
