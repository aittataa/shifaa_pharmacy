import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/products_provider.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/screens/product_details.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class ProductScreen extends StatelessWidget {
  static const String id = "ProductScreen";

  final String title;
  final List<Product> myList;
  ProductScreen({this.title, this.myList});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
        productProvider.loadProducts;
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text("$title", style: TextStyle(fontWeight: FontWeight.bold)),
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
          body: BodyShape(
            child: myList.isNotEmpty
                ? GridView.builder(
                    padding: EdgeInsets.only(top: 5, right: 5, left: 5),
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 1,
                    ),
                    itemCount: myList.length,
                    itemBuilder: (context, index) {
                      Product product = myList[index];
                      bool isFav = isProductFavorite(product);
                      return displayProduct(
                        product: product,
                        isFav: isFav,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                myList: myList,
                                initialIndex: index,
                              ),
                            ),
                          );
                        },
                        onShopTap: (bool isLiked) async {
                          if (isClientLogged) {
                            onShopProductTap(product, context);
                          } else {
                            Navigator.popAndPushNamed(context, LoginScreen.id);
                          }
                          return isLiked;
                        },
                        onFavTap: (bool isLiked) async {
                          if (isClientLogged) {
                            onFavProductTap(product);
                            isFav = !isFav;
                          } else {
                            Navigator.popAndPushNamed(context, LoginScreen.id);
                          }
                          return isFav;
                        },
                      );
                    },
                  )
                : EmptyBox(),
          ),
        );
      },
    );
  }
}
