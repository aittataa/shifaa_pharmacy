import 'package:flutter/material.dart';
import 'package:shifaa_pharmacy/constant/constant.dart';
import 'package:shifaa_pharmacy/provider/database_provider.dart';

class SettingsProvider extends ChangeNotifier {
  get loadSettings async {
    appSettings = await DataBaseProvider.getSettings;
    notifyListeners();
  }
}
