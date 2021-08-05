import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/messages.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/clients_controller.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/screens/about_screen.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/initial_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/screens/order_address.dart';
import 'package:shifaa_pharmacy/screens/prescription_manager.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/screens/product_details.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/screens/profile_screen.dart';
import 'package:shifaa_pharmacy/screens/register_screen.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/screens/subcategories_screen.dart';
import 'package:shifaa_pharmacy/widget/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: backColor,
      //systemNavigationBarDividerColor: Colors.transparent,
      //systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(ShifaaPharmacy());
}

class ShifaaPharmacy extends StatelessWidget {
  final ClientsController clients = Get.put(ClientsController());
  final ProductsController products = Get.put(ProductsController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Messages.APP_TITLE,
      color: mainColor,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark().copyWith(
        primaryColor: mainColor,
        scaffoldBackgroundColor: backColor,
      ),
      home: AnimatedSplashScreen.withScreenFunction(
        screenFunction: () async => await SharedFunctions.nextScreen(clients),
        splash: SplashScreen(),
        curve: Constant.curve,
        backgroundColor: backColor,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: Constant.duration,
        splashIconSize: double.infinity,
      ),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        InitialScreen.id: (context) => InitialScreen(),
        ProductScreen.id: (context) => ProductScreen(),
        ProductDetails.id: (context) => ProductDetails(),
        SubCategoriesScreen.id: (context) => SubCategoriesScreen(),
        ShoppingScreen.id: (context) => ShoppingScreen(),
        PrescriptionScreen.id: (context) => PrescriptionScreen(),
        OrderAddress.id: (context) => OrderAddress(),
        PrescriptionManager.id: (context) => PrescriptionManager(),
        FavoriteScreen.id: (context) => FavoriteScreen(),
        AboutScreen.id: (context) => AboutScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}
