import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/brand.dart';
import 'package:shifaa_pharmacy/classes/categories.dart';
import 'package:shifaa_pharmacy/classes/medicine.dart';
import 'package:shifaa_pharmacy/classes/sub_categories.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class CategoriesController extends GetxController {
  var medicinesList = <Medicine>[].obs;
  var categoriesList = <Categories>[].obs;
  var subcategoriesList = <SubCategories>[].obs;
  var brandsList = <Brand>[].obs;

  @override
  void onInit() {
    loadCategories;
    super.onInit();
  }

  get loadCategories async {
    var medicines = await DataBaseProvider.getMedicineCategories;
    var categories = await DataBaseProvider.getCategories;
    var subcategories = await DataBaseProvider.getSubCategories;
    var brands = await DataBaseProvider.getAllBrands;

    if (medicines != null) medicinesList.value = medicines;
    if (categories != null) categoriesList.value = categories;
    if (subcategories != null) subcategoriesList.value = subcategories;
    if (brands != null) brandsList.value = brands;
    update();
  }
}
