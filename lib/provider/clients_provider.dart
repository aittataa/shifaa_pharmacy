import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifaa_pharmacy/classes/client.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class ClientsProvider extends ChangeNotifier {
  get loadClients async {
    isClientLogged;
    myClientsList = await DataBaseProvider.getAllClients;
    notifyListeners();
  }

  getClientByID(int id) async => await DataBaseProvider.getClientByID(id);
  getClientByInfo(Client client) async => await DataBaseProvider.getClientByInfo(client);

  addNewClient(Client client) async {
    bool state = await DataBaseProvider.addNewClient(client);
    loadClients;
    notifyListeners();
    return state;
  }

  updateClientInfo(Client client) async {
    bool state = await DataBaseProvider.updateClientInfo(client);
    loadClients;
    notifyListeners();
    return state;
  }

  updateClientAddress(Client client) async {
    bool state = await DataBaseProvider.updateClientAddress(client);
    loadClients;
    notifyListeners();
    return state;
  }

  get clear async {
    final session = await SharedPreferences.getInstance();
    session.clear();
    Constant.signInClient = null;
    isClientLogged;
    loadClients;
    notifyListeners();
  }
}
