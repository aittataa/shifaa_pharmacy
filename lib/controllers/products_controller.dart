import 'package:get/get.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';

import '../classes/favorite.dart';
import '../classes/product.dart';
import '../constant/constant.dart';
import '../provider/database_provider.dart';

class ProductsController extends GetxController {
  var productsList = <Product>[].obs;
  var favoriteProductsList = <Favorite>[].obs;

  @override
  void onInit() {
    loadProducts;
    super.onInit();
  }

  get loadProducts async {
    var products = await DataBaseProvider.getAllProduct;
    if (products != null) productsList.value = products;
    bool state = SharedFunctions.isClientLogged;
    if (state) {
      int id = Constant.signInClient.id;
      var favorites = await DataBaseProvider.getFavorite(id);
      if (favorites != null) favoriteProductsList.value = favorites;
    }
  }

  addFavorite(Favorite favorite) async {
    return await DataBaseProvider.addFavorite(favorite);
  }

  updateFavorite(Favorite favorite) async {
    return await DataBaseProvider.updateFavorite(favorite);
  }
}
