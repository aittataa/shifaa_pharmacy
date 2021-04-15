import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/products_provider.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class ProductDetails extends StatefulWidget {
  static const String id = "ProductDetailsScreen";
  final List<Product> myList;
  final int initialIndex;
  ProductDetails({this.myList, this.initialIndex});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<Product> myList;
  int initialIndex;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
    myList = widget.myList;
    initialIndex = widget.initialIndex;
    controller = PageController(initialPage: initialIndex);
  }

  PageController controller;

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
                color: mainColor,
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
          body: PageView.builder(
            controller: controller,
            itemCount: myList.length,
            itemBuilder: (context, index) {
              Product product = myList[index];
              bool isFav = isProductFavorite(product);
              return displayProductDetails(
                product: product,
                isFav: isFav,
                onShopTap: (bool isLiked) async {
                  if (isClientLogged) {
                    onShopProductTap(product, context);
                  } else {
                    Navigator.pushNamed(context, LoginScreen.id);
                  }
                  return isLiked;
                },
                onBuyTap: () {
                  if (isClientLogged) {
                    onShopProductTap(product, context);
                    productProvider.loadProducts;
                    Navigator.pushNamed(context, ShoppingScreen.id);
                  } else {
                    Navigator.pushNamed(context, LoginScreen.id);
                  }
                },
                onFavTap: (bool isLiked) async {
                  if (isClientLogged) {
                    onFavProductTap(product);
                    isFav = !isFav;
                  } else {
                    Navigator.pushNamed(context, LoginScreen.id);
                  }
                  return isFav;
                },
              );
            },
          ),
        );
      },
    );
  }
}
