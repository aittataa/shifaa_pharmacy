import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/constant/shared_functions.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class ClientsController extends GetxController {
  var myClientsList = <Client>[].obs;
  var signInClient = Client().obs;

  @override
  void onInit() {
    load;
    super.onInit();
  }

  get load async {
    var myList = await DataBaseProvider.getAllClients;
    if (myList != null) myClientsList.value = myList;
    update();
  }

  get clear async {
    final session = await SharedPreferences.getInstance();
    session.clear();
    Constant.signInClient = null;
    bool state = SharedFunctions.isClientLogged;
  }

  getClientByID(int id) async {
    return await DataBaseProvider.getClientByID(id);
  }

  getClientByInfo(Client client) async {
    return await DataBaseProvider.getClientByInfo(client);
  }

  addNewClient(Client client) async {
    bool state = await DataBaseProvider.addNewClient(client);
    return state;
  }

  updateClientInfo(Client client) async {
    bool state = await DataBaseProvider.updateClientInfo(client);
    return state;
  }

  updateClientAddress(Client client) async {
    bool state = await DataBaseProvider.updateClientAddress(client);
    return state;
  }
}
