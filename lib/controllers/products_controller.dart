import 'package:get/get.dart';

import '../classes/favorite.dart';
import '../classes/product.dart';
import '../constant/constant.dart';
import '../provider/database_provider.dart';

class ProductsController extends GetxController {
  var productsList = <Product>[].obs;
  var favoriteProductsList = <Product>[].obs;

  @override
  void onInit() {
    loadProducts;
    super.onInit();
  }

  get loadProducts async {
    var products = await DataBaseProvider.getAllProduct;
    if (products != null) productsList.value = products;
    bool state = Constant.isClientLogged;
    if (state) {
      int id = Constant.signInClient.id;
      var favoriteProducts = await DataBaseProvider.getFavorite(id);
      if (favoriteProducts != null) {
        favoriteProductsList.value = favoriteProducts;
      } else {
        favoriteProductsList.value = null;
      }
    }
    update();
  }

  addFavorite(Favorite favorite) async {
    bool state = await DataBaseProvider.addFavorite(favorite);
    update();
    return state;
  }

  updateFavorite(Favorite favorite) async {
    bool state = await DataBaseProvider.updateFavorite(favorite);
    update();
    return state;
  }
}
