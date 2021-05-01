import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/screens/product_details.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class FavoriteScreen extends StatelessWidget {
  static const String id = "FavoriteScreen";
  final ProductsController controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("WishList", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: BackIconButton(),
        actions: [
          FunctionIconButton(
            icon: Icons.shopping_cart,
            onPressed: () {
              Get.to(ShoppingScreen());
            },
          ),
          FunctionIconButton(
            icon: Icons.receipt_long,
            onPressed: () {
              Get.to(PrescriptionScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        final List<Product> myList = controller.favoriteProductsList.where((product) {
          return product.isFav == true;
        }).toList();
        final bool isNotEmpty = myList.isNotEmpty;
        if (isNotEmpty) {
          return BodyShape(
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SharedFunctions.gridDelegate(2),
              itemCount: myList.length,
              itemBuilder: (context, index) {
                Product product = myList[index];
                bool isFav = SharedFunctions.isProductFavorite(product);
                return displayProduct(
                  product: product,
                  isFav: isFav,
                  onTap: () {
                    Get.to(
                      ProductDetails(
                        myList: myList,
                        index: index,
                      ),
                    );
                  },
                  onShopTap: (bool isLiked) async {
                    //if (isClientLogged) {
                    //  onShopProductTap(product, context);
                    //} else {
                    //  Get.offAll(LoginScreen());
                    //}
                    return isLiked;
                  },
                  onFavTap: (bool isLiked) async {
                    //if (isClientLogged) {
                    //  onFavProductTap(product);
                    //  isFav = !isFav;
                    //} else {
                    //  Get.offAll(LoginScreen());
                    //}
                    return isLiked;
                  },
                );
              },
            ),
          );
        } else {
          return EmptyBox();
        }
      }),
    );
  }
}
