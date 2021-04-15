import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/classes/prescription.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class PrescriptionsProvider extends ChangeNotifier {
  get loadPrescriptions async {
    isClientLogged;
    if (isClientLogged) {
      int id = signInClient.id;
      prescriptionList = await DataBaseProvider.getPrescription(id);
    } else {
      prescriptionList = [];
    }
    notifyListeners();
  }

  addPrescription(Prescription prescription) async {
    bool state = await DataBaseProvider.addPrescription(prescription);
    loadPrescriptions;
    notifyListeners();
    return state;
  }

  updatePrescription(int id) async {
    bool state = await DataBaseProvider.updatePrescription(id);
    loadPrescriptions;
    notifyListeners();
    return state;
  }
}
