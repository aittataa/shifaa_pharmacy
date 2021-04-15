import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/clients_provider.dart';
import 'package:shifaa_pharmacy/screens/initial_screen.dart';
import 'package:shifaa_pharmacy/screens/register_screen.dart';
import 'package:shifaa_pharmacy/widget/bottom_button.dart';
import 'package:shifaa_pharmacy/widget/modal_progress_indicator.dart';
import 'package:shifaa_pharmacy/widget/registration_button.dart';
import 'package:shifaa_pharmacy/widget/text_box.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "LoginScreen";
  final Client client;
  final rememberMode mode;
  LoginScreen({this.client, this.mode});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Client client;
  rememberMode mode;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    client = widget.client;
    mode = widget.mode;

    email.text = mode == rememberMode.no ? signInClient.email : "aittataa@gmail.com";
    password.text = mode == rememberMode.no ? signInClient.password : "1234567890";
  }

  var email = TextEditingController();
  var password = TextEditingController();

  bool rememberMe = true;
  bool obscureText = true;

  bool isEmailValid = false;
  bool isEmailNotEmpty = false;

  bool isPasswordNotEmpty = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientsProvider>(
      builder: (context, clientProvider, child) {
        clientProvider.loadClients;
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
                        "icons/app_icon.png",
                        color: mainColor,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        TextBox(
                          controller: email,
                          hintText: "Email",
                          icon: CupertinoIcons.mail_solid,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        TextBox(
                          controller: password,
                          hintText: "Password",
                          icon: CupertinoIcons.lock_shield_fill,
                          obscureText: obscureText,
                          textInputAction: TextInputAction.done,
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => obscureText = !obscureText),
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: obscureText ? Colors.black12 : Colors.white,
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
                            print(rememberMe);
                          });
                        },
                      ),
                      title: Text(
                        "Remember Me",
                        style: TextStyle(
                          color: rememberMe ? Colors.black54 : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // trailing: Text(
                      //   "Forget Password ?",
                      //   style: TextStyle(
                      //     color: Colors.black54,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: RegistrationButton(
                            text: "Login",
                            textColor: Colors.white,
                            backColor: mainColor,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              setState(() => isAsyncCall = true);

                              isEmailValid = email.text.trim().isNotEmpty &&
                                  EmailValidator.validate(email.text.trim());
                              isPasswordValid =
                                  password.text.trim().isNotEmpty && password.text.length >= 8;

                              if (isPasswordValid && isEmailValid) {
                                try {
                                  signInClient = await clientProvider.getClientByInfo(
                                    Client(
                                      email: email.text.trim(),
                                      password: password.text.trim(),
                                    ),
                                  );
                                  final session = await SharedPreferences.getInstance();
                                  session.setInt("id", signInClient.id);
                                  session.setBool("state", rememberMe);
                                  Navigator.popAndPushNamed(context, InitialScreen.id);
                                } catch (e) {
                                  errorSnackBar(
                                    context,
                                    title: "Identification Incorrect",
                                    message: "Email or Password is Incorrect, Please Try Again",
                                  );
                                }
                              } else {
                                errorSnackBar(
                                  context,
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
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "- OR -",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BottomButton(
                      title: "Create New Account",
                      route: RegisterScreen.id,
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
