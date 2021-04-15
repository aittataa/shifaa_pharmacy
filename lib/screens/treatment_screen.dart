import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/drawer_navigation.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class TreatmentScreen extends StatelessWidget {
  static const String id = "TreatmentScreen";
  final bool isThatTrue = true;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, dataProvider, child) {
        return WillPopScope(
          onWillPop: () => isWillPop(context),
          child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text("Treatment", style: TextStyle(fontWeight: FontWeight.bold)),
              leading: BackIconButton(),
              actions: [
                FunctionIconButton(
                  icon: Icons.shopping_cart,
                  onPressed: () {
                    Navigator.pushNamed(context, ShoppingScreen.id);
                  },
                ),
                FunctionIconButton(
                  icon: Icons.receipt_long,
                  onPressed: () {
                    Navigator.pushNamed(context, PrescriptionScreen.id);
                  },
                ),
                FunctionIconButton(
                  icon: Icons.favorite,
                  onPressed: () async {
                    var myList = favoriteProductsList.where((product) {
                      return product.isFav == true;
                    }).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(myList: myList),
                      ),
                    );
                  },
                ),
              ],
            ),
            drawer: DrawerNavigation(),
            body: BodyShape(
              child: isThatTrue
                  ? Center(
                      child: Text(
                        "Treatment !",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : EmptyBox(),
            ),
          ),
        );
      },
    );
  }
}
