import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/clients_controller.dart';
import 'package:shifaa_pharmacy/screens/initial_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/widget/bottom_button.dart';
import 'package:shifaa_pharmacy/widget/modal_progress_indicator.dart';
import 'package:shifaa_pharmacy/widget/registration_button.dart';
import 'package:shifaa_pharmacy/widget/text_box.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "RegisterScreen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ClientsController controller = Get.put(ClientsController());
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    username.text = "AIT TATA ABDERRAHIM";
    email.text = "aittata.a@hotmail.com";
    password.text = "qwerty123456";
    phone.text = "0600000000";
  }

  bool obscureText = false;
  bool isAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressIndicator(
        inAsyncCall: isAsyncCall,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Image.asset(
                    Messages.ICON,
                    color: mainColor,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    TextBox(
                      controller: username,
                      hintText: Messages.HINT_USERNAME,
                      icon: CupertinoIcons.person_crop_circle,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    TextBox(
                      controller: email,
                      hintText: Messages.HINT_EMAIL,
                      icon: CupertinoIcons.mail_solid,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    TextBox(
                      hintText: Messages.HINT_PASSWORD,
                      controller: password,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      icon: CupertinoIcons.lock_shield_fill,
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: obscureText ? Colors.black12 : Colors.white,
                        ),
                      ),
                    ),
                    TextBox(
                      hintText: Messages.HINT_PHONE,
                      controller: phone,
                      icon: CupertinoIcons.phone_fill,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: RegistrationButton(
                          text: Messages.REGISTER_BUTTON,
                          textColor: Colors.white,
                          backColor: mainColor,
                          onPressed: () async {
                            setState(() => isAsyncCall = true);
                            FocusScope.of(context).unfocus();
                            bool isUsername = GetUtils.isLengthGreaterThan(username.text.trim(), 5);
                            bool isEmail = GetUtils.isEmail(email.text.trim());
                            bool isPassword = GetUtils.isLengthGreaterThan(password.text.trim(), 8);
                            bool isPhoneNumber = GetUtils.isPhoneNumber(phone.text.trim());

                            if (isUsername && isEmail && isPassword && isPhoneNumber) {
                              List<Client> myClient = controller.myClientsList.where((client) {
                                return client.email == email.text.trim();
                              }).toList();
                              if (myClient.isEmpty) {
                                bool state = await controller.addNewClient(
                                  Client(
                                    username: username.text.toUpperCase(),
                                    email: email.text.trim().toLowerCase(),
                                    password: password.text.trim(),
                                    phone: phone.text.trim(),
                                  ),
                                );
                                if (state) {
                                  Constant.signInClient = await controller.getClientByInfo(
                                    Client(
                                      email: email.text.trim(),
                                      password: password.text.trim(),
                                    ),
                                  );
                                  bool state = SharedFunctions.isClientLogged;
                                  if (state) {
                                    final session = await SharedPreferences.getInstance();
                                    session.setInt("id", Constant.signInClient.id);
                                    session.setBool("state", true);
                                    Get.off(InitialScreen());
                                  } else {
                                    SharedFunctions.snackBar(
                                      title: "Registration Error",
                                      message: "Something Wrong !! Please Try Again",
                                    );
                                  }
                                } else {
                                  SharedFunctions.snackBar(
                                    title: "Internet Error",
                                    message: "Connection Error !! Please Try Again",
                                  );
                                }
                              } else {
                                SharedFunctions.snackBar(
                                  title: "Validation Error",
                                  message: "This Email is Already Used",
                                );
                              }
                            } else {
                              String title = "";
                              String message = "";
                              if (!isUsername) {
                                title = "Name To Short";
                                message = "Name Must Contain Least 5 Characters";
                              } else if (!isEmail) {
                                title = "Invalid Email";
                                message = "Invalid Email Format";
                              } else if (!isPassword) {
                                title = "Password To Short";
                                message = "Password Must Contain at Least 8 Characters";
                              } else if (!isPhoneNumber) {
                                title = "Invalid Phone Number";
                                message = "Phone Number must contain 10 Numbers";
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
                      Expanded(flex: 1, child: SizedBox(width: 1)),
                      Expanded(
                        flex: 10,
                        child: RegistrationButton(
                          text: Messages.SKIP_BUTTON,
                          textColor: mainColor,
                          backColor: Colors.white,
                          onPressed: () async {
                            final session = await SharedPreferences.getInstance();
                            session.setBool("skip", true);
                            Navigator.popAndPushNamed(context, InitialScreen.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                BottomButton(
                  title: Messages.LOGIN_ACCOUNT_TITLE,
                  screen: LoginScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
