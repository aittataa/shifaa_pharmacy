import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
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
  @override
  void initState() {
    super.initState();
    username.text = "AIT TATA ABDERRAHIM";
    email.text = "aittata.a@hotmail.com";
    password.text = "qwerty123456";
    phone.text = "0600000000";
  }

  bool obscureText = false;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

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
                    "icons/app_icon.png",
                    color: mainColor,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    TextBox(
                      controller: username,
                      hintText: "Name",
                      icon: CupertinoIcons.person_crop_circle,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    TextBox(
                      controller: email,
                      hintText: "Email",
                      icon: CupertinoIcons.mail_solid,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    TextBox(
                      hintText: "Password",
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
                      hintText: "Phone : 0600000000",
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
                          text: "Register",
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
                                  signInClient = await controller.getClientByInfo(
                                    Client(
                                      email: email.text.trim(),
                                      password: password.text.trim(),
                                    ),
                                  );
                                  bool state = Constant.isClientLogged;
                                  if (state) {
                                    final session = await SharedPreferences.getInstance();
                                    session.setInt("id", signInClient.id);
                                    session.setBool("state", true);
                                    Get.off(InitialScreen());
                                  } else {
                                    errorSnackBar(
                                      context,
                                      title: "Registration Error",
                                      message: "Something Wrong !! Please Try Again",
                                    );
                                  }
                                } else {
                                  errorSnackBar(
                                    context,
                                    title: "Internet Error",
                                    message: "Connection Error !! Please Try Again",
                                  );
                                }
                              } else {
                                errorSnackBar(
                                  context,
                                  title: "Validation Error",
                                  message: "This Email is Already Used",
                                );
                              }
                            } else {
                              String title = "";
                              String message = "";
                              //if (!isFullnameNotEmpty) {
                              //  title = "Name Empty";
                              //  message = "Name is Required";
                              //} else if (!isFullNameValid) {
                              //  title = "Name Invalid";
                              //  message = "Name Must Contain Least 5 Characters";
                              //} else if (!isEmailNotEmpty) {
                              //  title = "Email Empty";
                              //  message = "Email is Required";
                              //} else if (!isEmailValid) {
                              //  title = "Email Invalid";
                              //  message = "Type Valid Email";
                              //} else if (!isPasswordNotEmpty) {
                              //  title = "Password Empty";
                              //  message = "Password is Required";
                              //} else if (!isPasswordValid) {
                              //  title = "Password Invalid";
                              //  message = "Password Must Contain at Least 8 Characters";
                              //} else if (!isPhoneNotEmpty) {
                              //  title = "Phone Empty";
                              //  message = "Phone Number is Required";
                              //} else if (!isPhoneValid) {
                              //  title = "Phone Number Invalid";
                              //  message = "Phone Number must contain 10 Numbers";
                              //}
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
                      Expanded(flex: 1, child: SizedBox(width: 1)),
                      Expanded(
                        flex: 10,
                        child: RegistrationButton(
                          text: "Skip",
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
                  title: "Already Have Account",
                  route: LoginScreen.id,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
