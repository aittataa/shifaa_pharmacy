import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/classes/brand.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/display_function/display_function.dart';
import 'package:shifaa_pharmacy/provider/categories_provider.dart';
import 'package:shifaa_pharmacy/screens/product_screen.dart';
import 'package:shifaa_pharmacy/widget/body_shape.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

class BrandsPage extends StatefulWidget {
  @override
  _BrandsPageState createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  bool isNotEmpty;
  List<Brand> myList = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    myList = brandsList;
    isNotEmpty = myList.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, categoryProvider, child) {
        categoryProvider.loadCategories;
        if (isNotEmpty) {
          return BodyShape(
            controller: controller,
            onPressed: () {
              setState(() {
                controller.clear();
                myList = brandsList;
              });
            },
            onChanged: (value) {
              setState(() {
                myList = brandsList.where((brand) {
                  return brand.title.toLowerCase().contains(value.toLowerCase());
                }).toList();
              });
            },
            child: GridView.builder(
              padding: EdgeInsets.all(5),
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1,
              ),
              itemCount: myList.length,
              itemBuilder: (context, index) {
                Brand brand = myList[index];
                return displayCategories(
                  item: brand,
                  fit: BoxFit.fill,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          title: brand.title,
                          myList: productsList.where((product) {
                            return product.brand_title == brand.title;
                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else {
          return EmptyBox();
        }
      },
    );
  }
}
