import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shifaa_pharmacy/provider/categories_provider.dart';
import 'package:shifaa_pharmacy/widget/empty_box.dart';

class OffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, categoryProvider, child) {
        categoryProvider.loadCategories;
        if (true) {
          return Center(
            child: Text(
              "Offers !",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          return EmptyBox();
        }
      },
    );
  }
}
