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
import 'package:shifaa_pharmacy/screens/register_screen.dart';
import 'package:shifaa_pharmacy/widget/bottom_button.dart';
import 'package:shifaa_pharmacy/widget/modal_progress_indicator.dart';
import 'package:shifaa_pharmacy/widget/registration_button.dart';
import 'package:shifaa_pharmacy/widget/text_box.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "LoginScreen";
  final bool state;
  LoginScreen({this.state = false});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ClientsController controller = Get.put(ClientsController());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool state;

  @override
  void initState() {
    super.initState();
    state = widget.state;

    /// TODO : Initialisation
    email.text = state ? Constant.signInClient.email : "aittataa@gmail.com";
    password.text = state ? Constant.signInClient.password : "0123456789";
  }

  bool rememberMe = true;
  bool obscureText = true;
  bool isAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressIndicator(
        inAsyncCall: isAsyncCall,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
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
                      controller: email,
                      hintText: Messages.HINT_EMAIL,
                      icon: CupertinoIcons.mail_solid,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    TextBox(
                      controller: password,
                      hintText: Messages.HINT_PASSWORD,
                      icon: CupertinoIcons.lock_shield_fill,
                      obscureText: obscureText,
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => obscureText = !obscureText),
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: obscureText ? Colors.black26 : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Checkbox(
                    value: rememberMe,
                    activeColor: mainColor,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value;
                      });
                    },
                  ),
                  title: Text(
                    Messages.REMEMBER_MESSAGE,
                    style: TextStyle(
                      color: rememberMe ? Colors.black54 : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: RegistrationButton(
                        text: Messages.LOGIN_BUTTON,
                        textColor: Colors.white,
                        backColor: mainColor,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          setState(() => isAsyncCall = true);

                          bool isEmail = GetUtils.isEmail(email.text.trim());
                          bool isPassword = GetUtils.isLengthGreaterThan(password.text.trim(), 8);
                          if (isPassword && isEmail) {
                            try {
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
                                session.setBool("state", rememberMe);
                                Get.off(InitialScreen());
                              }
                            } catch (e) {
                              SharedFunctions.snackBar(
                                title: "Identification Incorrect",
                                message: "Email or Password is Incorrect, Please Try Again",
                              );
                            }
                          } else {
                            SharedFunctions.snackBar(
                              title: "Identification Incorrect",
                              message: "Check Your Email or Password",
                            );
                          }

                          setState(() => isAsyncCall = false);
                        },
                      ),
                    ),
                    Expanded(child: SizedBox(width: 1)),
                    Expanded(
                      flex: 10,
                      child: RegistrationButton(
                        text: Messages.SKIP_BUTTON,
                        textColor: mainColor,
                        backColor: Colors.white,
                        onPressed: () async {
                          final session = await SharedPreferences.getInstance();
                          session.setBool("skip", true);
                          Get.off(InitialScreen());
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    Messages.OR_MESSAGE,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BottomButton(
                  title: Messages.REGISTER_ACCOUNT_TITLE,
                  screen: RegisterScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
