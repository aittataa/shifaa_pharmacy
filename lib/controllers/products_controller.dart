import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/product.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class ProductsController extends GetxController {
  var productsList = <Product>[].obs;

  @override
  void onInit() {
    loadProducts;
    super.onInit();
  }

  get loadProducts async {
    var products = await DataBaseProvider.getAllProduct;
    if (products != null) {
      productsList.value = products;
    }
  }
}
