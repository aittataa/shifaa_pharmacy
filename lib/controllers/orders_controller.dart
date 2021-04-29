import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/order.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class OrdersController extends GetxController {
  var listOfOrders = <Order>[].obs;
  var myShoppingList = <Order>[].obs;
  var listOfPrescriptions = <Order>[].obs;
  var myPrescriptionList = <Order>[].obs;

  @override
  void onInit() {
    loadOrders;
    super.onInit();
  }

  get loadOrders async {
    bool state = Constant.isClientLogged;
    if (state) {
      int id = signInClient.id;
      var orders = await DataBaseProvider.getNormalOrder(id);
      var shoppingList = await DataBaseProvider.getShoppingList(id);
      var prescriptions = await DataBaseProvider.getPrescriptionOrder(id);
      var prescriptionList = await DataBaseProvider.getPrescriptionList(id);
      if (orders != null) listOfOrders.value = orders;
      if (shoppingList != null) myShoppingList.value = orders;
      if (prescriptions != null) listOfPrescriptions.value = orders;
      if (prescriptionList != null) myPrescriptionList.value = orders;
    }
  }

  getNormalOrder(int id) async => await DataBaseProvider.getNormalOrder(id);

  getPrescriptionOrder(int id) async => await DataBaseProvider.getPrescriptionOrder(id);

  addOrder(Order order) async {
    bool state = await DataBaseProvider.addOrder(order);
    return state;
  }

  updateOrder(int id) async {
    bool state = await DataBaseProvider.updateOrder(id);
    return state;
  }
}
