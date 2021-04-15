import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/classes/sub_categories.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/categories_provider.dart';
import 'package:shifaa_pharmacy/provider/products_provider.dart';
import 'package:shifaa_pharmacy/screens/favorite_screen.dart';
import 'package:shifaa_pharmacy/screens/login_screen.dart';
import 'package:shifaa_pharmacy/screens/prescription_screen.dart';
import 'package:shifaa_pharmacy/screens/product_details.dart';
import 'package:shifaa_pharmacy/screens/shopping_screen.dart';
import 'package:shifaa_pharmacy/widget/back_icon.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/divider_line.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';
import 'package:shifaa_pharmacy/widget/function_button.dart';

class SubCategoriesScreen extends StatefulWidget {
  static const String id = "SubCategoriesScreen";

  final List<SubCategories> myList;
  final Categories category;
  SubCategoriesScreen({this.myList, this.category});

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  List<SubCategories> myList;
  Categories category;

  @override
  void initState() {
    super.initState();
    myList = widget.myList;
    category = widget.category;
    subIndex = 0;
    if (myList.isNotEmpty) getProductList(myList[subIndex], subIndex);
  }

  int subIndex = 0;
  List<Product> productList = [];

  getProductList(category, index) {
    subIndex = index;
    productList = productsList.where((product) {
      return product.subcategory_title == category.title;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoriesProvider, ProductsProvider>(
      builder: (context, categoryProvider, productProvider, child) {
        categoryProvider.loadCategories;
        productProvider.loadProducts;
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text("${category.title}", style: TextStyle(fontWeight: FontWeight.bold)),
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
                ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 45,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: myList.length,
                          itemBuilder: (context, index) {
                            var category = myList[index];
                            return displaySubCategories(
                              category: category,
                              option: subIndex == index,
                              onTap: () {
                                setState(() => getProductList(category, index));
                              },
                            );
                          },
                        ),
                      ),
                      DividerLine(value: 10),
                      Expanded(
                        child: productList.isNotEmpty
                            ? GridView.builder(
                                padding: EdgeInsets.only(top: 25, right: 5, left: 5),
                                physics: BouncingScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 1,
                                ),
                                itemCount: productList.length,
                                itemBuilder: (context, index) {
                                  Product product = productList[index];
                                  bool isFav = isProductFavorite(product);
                                  return displayProduct(
                                    product: product,
                                    isFav: isFav,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                            myList: productList,
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
                      )
                    ],
                  )
                : EmptyBox(),
          ),
        );
      },
    );
  }
}
