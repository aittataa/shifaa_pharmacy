import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/contain.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class ContainsController extends GetxController {
  var containList = <Contain>[].obs;
  @override
  void onInit() {
    loadContains;
    super.onInit();
  }

  get loadContains async {
    bool state = SharedFunctions.isClientLogged;
    if (state) {
      int id = Constant.signInClient.id;
      var contains = await DataBaseProvider.getContain(id);
      if (contains != null) containList.value = contains;
    }
    update();
  }

  addContain(Contain contain) async {
    bool state = await DataBaseProvider.addContain(contain);
    update();
    return state;
  }

  updateContain(int id) async {
    bool state = await DataBaseProvider.updateContain(id);
    update();
    return state;
  }
}
