import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class ClientsController extends GetxController {
  var myClientsList = <Client>[].obs;

  @override
  void onInit() {
    loadClients;
    super.onInit();
  }

  get loadClients async {
    var myList = await DataBaseProvider.getAllClients;
    if (myList != null) myClientsList.value = myList;
  }

  getClientByID(int id) async => await DataBaseProvider.getClientByID(id);
  getClientByInfo(Client client) async => await DataBaseProvider.getClientByInfo(client);

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
