import 'package:get/get.dart';
import 'package:shifaa_pharmacy/classes/settings.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class SettingsController extends GetxController {
  var appSettings = Settings().obs;

  @override
  void onInit() {
    loadSettings;
    super.onInit();
  }

  get loadSettings async {
    var settings = await DataBaseProvider.getSettings;
    if (settings != null) {
      appSettings.value = settings;
    }
    update();
  }
}
