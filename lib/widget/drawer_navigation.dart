import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/clients_provider.dart';
import 'package:shifaa_pharmacy/screens/about_screen.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/screens/profile_screen.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/divider_line.dart';
import 'package:shifaa_pharmacy/widget/horizontal_button.dart';
import 'package:shifaa_pharmacy/widget/vertical_button.dart';

class DrawerNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClientsProvider>(
      builder: (context, clientProvider, child) {
        clientProvider.loadClients;
        return AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.linearToEaseOut,
          color: mainColor,
          width: screenWidth * 0.75,
          child: SafeArea(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: screenHeight * 0.15,
                      height: screenHeight * 0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: isClientLogged
                              ? NetworkImage("${signInClient.picture}")
                              : AssetImage("icons/icon_round.png"),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 90,
                            spreadRadius: -15,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      dense: true,
                      minLeadingWidth: 0,
                      minVerticalPadding: 0,
                      horizontalTitleGap: 0,
                      contentPadding: EdgeInsets.zero.copyWith(left: 10),
                      title: Text(
                        isClientLogged ? "${signInClient.fullname}" : appTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        isClientLogged ? "${signInClient.email}" : appDesc,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () => Navigator.popAndPushNamed(
                          context,
                          isClientLogged ? ProfileScreen.id : LoginScreen.id,
                        ),
                        icon: Icon(Icons.edit, color: Colors.white, size: 30),
                      ),
                    ),
                  ],
                ),
                DividerLine(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HorizontalButton(
                      icon: Icons.shopping_cart,
                      title: "Shopping",
                      onPressed: () {
                        Navigator.popAndPushNamed(context, ShoppingScreen.id);
                      },
                    ),
                    HorizontalButton(
                      icon: Icons.receipt_long,
                      title: "Prescription",
                      onPressed: () {
                        Navigator.popAndPushNamed(context, PrescriptionScreen.id);
                      },
                    ),
                    HorizontalButton(
                      icon: Icons.favorite,
                      title: "WishList",
                      onPressed: () {
                        List<Product> myList = productsList.where((product) {
                          return product.isFav == true;
                        }).toList();
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FavoriteScreen(myList: myList)),
                        );
                      },
                    ),
                  ],
                ),
                DividerLine(),
                Expanded(
                  child: Column(
                    children: [
                      VerticalButton(
                        icon: CupertinoIcons.house_alt_fill,
                        title: "Home",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      VerticalButton(
                        icon: CupertinoIcons.gear_alt_fill,
                        title: "Settings",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                DividerLine(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HorizontalButton(
                      icon: Icons.info,
                      title: "About Us",
                      onPressed: () {
                        Navigator.popAndPushNamed(context, AboutScreen.id);
                      },
                    ),
                    HorizontalButton(
                      icon: isClientLogged ? Icons.logout : Icons.login,
                      title: isClientLogged ? "Sign Out" : "Sign In",
                      onPressed: () {
                        clientProvider.clear;
                        Navigator.pop(context);
                        Navigator.popAndPushNamed(context, LoginScreen.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
