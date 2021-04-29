import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/prescription.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class PrescriptionsController extends GetxController {
  var prescriptionList = <Prescription>[].obs;
  @override
  void onInit() {
    loadPrescriptions;
    super.onInit();
  }

  get loadPrescriptions async {
    bool state = Constant.isClientLogged;
    if (state) {
      int id = signInClient.id;
      var prescriptions = await DataBaseProvider.getPrescription(id);
      if (prescriptions != null) prescriptionList.value = prescriptions;
    }
  }

  addPrescription(Prescription prescription) async {
    bool state = await DataBaseProvider.addPrescription(prescription);
    return state;
  }

  updatePrescription(int id) async {
    bool state = await DataBaseProvider.updatePrescription(id);
    return state;
  }
}
