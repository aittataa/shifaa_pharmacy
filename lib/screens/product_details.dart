import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/controllers/products_controller.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/products_provider.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class ProductDetails extends StatefulWidget {
  static const String id = "ProductDetailsScreen";
  final ProductsController controller;
  final int index;
  final List<Product> myList;
  ProductDetails({
    this.controller,
    this.index,
    this.myList,
  });
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductsController controller;
  List<Product> myList;
  int index;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
    myList = widget.myList;
    index = widget.index;
    pageController = PageController(initialPage: index);
  }

  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
        productProvider.loadProducts;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: BackIconButton(color: mainColor),
            actions: [
              FunctionIconButton(
                icon: Icons.shopping_cart,
                color: mainColor,
                onPressed: () {
                  Navigator.pushNamed(context, ShoppingScreen.id);
                },
              ),
              FunctionIconButton(
                icon: Icons.favorite,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(
                        myList: favoriteProductsList.where((product) {
                          return product.isFav == true;
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: PageView.builder(
            controller: pageController,
            itemCount: myList.length,
            itemBuilder: (context, index) {
              Product product = myList[index];
              bool isFav = isProductFavorite(product);
              return displayProductDetails(
                product: product,
                isFav: isFav,
                onShopTap: (bool isLiked) async {
                  setState(() {
                    if (isClientLogged) {
                      onShopProductTap(product, context);
                    } else {
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                    return isLiked;
                  });
                },
                onBuyTap: () {
                  setState(() {
                    if (isClientLogged) {
                      onShopProductTap(product, context);
                      productProvider.loadProducts;
                      Navigator.pushNamed(context, ShoppingScreen.id);
                    } else {
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                  });
                },
                onFavTap: (bool isLiked) async {
                  setState(() {
                    if (isClientLogged) {
                      onFavProductTap(product);
                      isFav = !isFav;
                    } else {
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                    return isFav;
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}
