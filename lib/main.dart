import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/categories_provider.dart';
import 'package:shifaa_pharmacy/provider/clients_provider.dart';
import 'package:shifaa_pharmacy/provider/contains_provider.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';
import 'package:shifaa_pharmacy/provider/orders_provider.dart';
import 'package:shifaa_pharmacy/provider/prescriptions_provider.dart';
import 'package:shifaa_pharmacy/provider/products_provider.dart';
import 'package:shifaa_pharmacy/provider/settings_provider.dart';
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
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(ShifaaPharmacy());
}

class ShifaaPharmacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DataBaseProvider()),
        ChangeNotifierProvider.value(value: SettingsProvider()),
        ChangeNotifierProvider.value(value: ClientsProvider()),
        ChangeNotifierProvider.value(value: CategoriesProvider()),
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: OrdersProvider()),
        ChangeNotifierProvider.value(value: ContainsProvider()),
        ChangeNotifierProvider.value(value: PrescriptionsProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "$appTitle",
          color: mainColor,
          themeMode: ThemeMode.dark,
          theme: ThemeData.dark().copyWith(
            primaryColor: mainColor,
            scaffoldBackgroundColor: backColor,
          ),
          home: AnimatedSplashScreen.withScreenFunction(
            screenFunction: () async {
              print("Start App");
              ClientsProvider clientProvider = ClientsProvider();
              clientProvider.loadClients;
              final session = await SharedPreferences.getInstance();
              int id = session.getInt("id");
              if (id != null) {
                print("User Deja Exist");
                signInClient = await clientProvider.getClientByID(id);
                bool state = session.getBool("state");
                if (state == false) {
                  print("Not Remember");
                  return LoginScreen(mode: rememberMode.no);
                } else {
                  print("Remember");
                  return InitialScreen();
                }
              } else {
                bool skip = session.getBool("skip");
                if (skip == true) {
                  print("Skip");
                  return InitialScreen();
                } else {
                  print("First Time");
                  return LoginScreen();
                }
              }
            },
            splash: SplashScreen(),
            curve: Curves.linearToEaseOut,
            backgroundColor: backColor,
            splashTransition: SplashTransition.fadeTransition,
            animationDuration: Duration(milliseconds: 1500),
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
      },
    );
  }
}
