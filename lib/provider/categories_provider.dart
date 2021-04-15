import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class CategoriesProvider extends ChangeNotifier {
  get loadCategories async {
    medicinesList = await DataBaseProvider.getMedicineCategories;
    categoriesList = await DataBaseProvider.getCategories;
    subcategoriesList = await DataBaseProvider.getSubCategories;
    brandsList = await DataBaseProvider.getAllBrands;
    notifyListeners();
  }
}
