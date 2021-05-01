import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/contain.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class ContainsProvider extends ChangeNotifier {
  get loadContains async {
    isClientLogged;
    if (isClientLogged) {
      int id = Constant.signInClient.id;
      containList = await DataBaseProvider.getContain(id);
    } else {
      containList = [];
    }
    notifyListeners();
  }

  addContain(Contain contain) async {
    bool state = await DataBaseProvider.addContain(contain);
    loadContains;
    notifyListeners();
    return state;
  }

  updateContain(int id) async {
    bool state = await DataBaseProvider.updateContain(id);
    loadContains;
    notifyListeners();
    return state;
  }
}
