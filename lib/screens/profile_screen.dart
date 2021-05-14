import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/clients_controller.dart';
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
  final ClientsController controller = Get.put(ClientsController());
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();

  bool obscureText = true;
  bool isAsyncCall = false;

  @override
  void initState() {
    super.initState();
    username.text = Constant.signInClient.username;
    password.text = Constant.signInClient.password;
    phone.text = Constant.signInClient.phone;

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
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          Messages.PROFILE_SCREEN_TITLE,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackIconButton(),
      ),
      body: ModalProgressIndicator(
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
                        : NetworkImage("${Constant.signInClient.picture}"),
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
                            //setState(() => pickProfilePic(ImageSource.gallery));
                            print(Constant.signInClient.picture);
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
                controller: username,
                hintText: Messages.HINT_USERNAME,
                icon: CupertinoIcons.person_crop_circle,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              TextBox(
                hintText: Messages.HINT_PASSWORD,
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
                hintText: Messages.HINT_PHONE,
                controller: phone,
                icon: CupertinoIcons.phone_fill,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RegistrationButton(
                  text: Messages.UPDATE_BUTTON,
                  textColor: Colors.white,
                  backColor: mainColor,
                  onPressed: () async {
                    setState(() => isAsyncCall = true);
                    FocusScope.of(context).unfocus();
                    bool isUsername = GetUtils.isLengthGreaterThan(username.text.trim(), 5);
                    bool isPassword = GetUtils.isLengthGreaterThan(password.text.trim(), 8);
                    bool isPhoneNumber = GetUtils.isPhoneNumber(phone.text.trim());

                    if (isUsername && isPassword && isPhoneNumber) {
                      String imageName = imageState
                          ? "${Constant.signInClient.id}_${imagePath.path.split('/').last}"
                          : "${Constant.signInClient.picture.split('/').last}";
                      bool state = await controller.updateClientInfo(
                        Client(
                          id: Constant.signInClient.id,
                          username: username.text.toUpperCase(),
                          email: Constant.signInClient.email,
                          password: password.text.trim(),
                          phone: phone.text.trim(),
                          picture: imageName,
                          profile: imageBytes,
                        ),
                      );
                      if (state) {
                        var myClient = controller.myClientsList.where((client) {
                          return client.email == Constant.signInClient.email &&
                              client.password == password.text.trim();
                        }).toList();
                        if (myClient.isNotEmpty) {
                          Constant.signInClient = myClient.first;
                          Navigator.pop(context);
                        }
                      }
                    } else {
                      String title = "";
                      String message = "";
                      if (!isUsername) {
                        title = "Name Invalid";
                        message = "Your Name Is To Short";
                      } else if (!isPassword) {
                        title = "Password Invalid";
                        message = "Password Must Contain at Least 8 Characters";
                      } else if (!isPhoneNumber) {
                        title = "Phone Number Invalid";
                        message = "Check Your Phone Number";
                      }
                      SharedFunctions.snackBar(
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
      ),
    );
  }
}
