import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final String title;
  SubCategoriesScreen({this.myList, this.title});

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  List<SubCategories> myList;
  String title;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    myList = widget.myList;
    subIndex = 0;
    if (myList.isNotEmpty) {
      myListProduct = getProductList(myList[subIndex], subIndex);
      searchProductList = myListProduct;
    }
  }

  int subIndex;
  List<Product> myListProduct = [];
  List<Product> searchProductList = [];
  TextEditingController controller = TextEditingController();

  getProductList(subcategory, index) {
    return productsList.where((product) {
      return product.subcategoryID == subcategory.id;
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
          body: myList.isNotEmpty
              ? BodyShape(
                  controller: controller,
                  onPressed: () {
                    setState(() {
                      controller.clear();
                      searchProductList = myListProduct;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      searchProductList = findProduct(myListProduct, value);
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 45,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: myList.length,
                          itemBuilder: (context, index) {
                            SubCategories subCategory = myList[index];
                            return displaySubCategories(
                              subCategory: subCategory,
                              option: subIndex == index,
                              onTap: () {
                                setState(() {
                                  subIndex = index;
                                  myListProduct = getProductList(subCategory, index);
                                });
                              },
                            );
                          },
                        ),
                      ),
                      DividerLine(value: 10),
                      Expanded(
                        child: searchProductList.isNotEmpty
                            ? GridView.builder(
                                padding: EdgeInsets.only(top: 25, right: 5, left: 5),
                                physics: BouncingScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                ),
                                itemCount: searchProductList.length,
                                itemBuilder: (context, index) {
                                  Product product = searchProductList[index];
                                  bool isFav = isProductFavorite(product);
                                  return displayProduct(
                                    product: product,
                                    isFav: isFav,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                            myList: myListProduct,
                                            initialIndex: index,
                                          ),
                                        ),
                                      );
                                    },
                                    onShopTap: (bool isLiked) async {
                                      setState(() {
                                        if (isClientLogged) {
                                          onShopProductTap(product, context);
                                        } else {
                                          Navigator.popAndPushNamed(context, LoginScreen.id);
                                        }
                                        return isLiked;
                                      });
                                    },
                                    onFavTap: (bool isLiked) async {
                                      setState(() {
                                        if (isClientLogged) {
                                          onFavProductTap(product);
                                          isFav = !isFav;
                                        } else {
                                          Navigator.popAndPushNamed(context, LoginScreen.id);
                                        }
                                        return isFav;
                                      });
                                    },
                                  );
                                },
                              )
                            : EmptyBox(),
                      )
                    ],
                  ),
                )
              : EmptyBox(),
        );
      },
    );
  }
}
