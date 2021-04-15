import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/favorite.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class ProductsProvider extends ChangeNotifier {
  get loadProducts async {
    productsList = await DataBaseProvider.getAllProduct;
    appSettings = await DataBaseProvider.getSettings;
    isClientLogged;
    if (isClientLogged) {
      int id = signInClient.id;
      favoriteProductsList = await DataBaseProvider.getFavorite(id);
    } else {
      favoriteProductsList = [];
    }
    notifyListeners();
  }

  addFavorite(Favorite favorite) async {
    bool state = await DataBaseProvider.addFavorite(favorite);
    notifyListeners();
    return state;
  }

  updateFavorite(Favorite favorite) async {
    bool state = await DataBaseProvider.updateFavorite(favorite);
    notifyListeners();
    return state;
  }
}
