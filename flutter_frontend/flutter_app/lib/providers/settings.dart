import 'package:flutter/material.dart';

import '../models/setting.dart';

class Settings with ChangeNotifier {
  List<Setting> _settings = [
    Setting(
      id: "showOnlyWithImage",
      display_name: "Show recipes only with image (restricted to home screen)",
      value: 0,
    ),
    Setting(
      id: "enableSVD",
      display_name: "Enable SVD recommendation",
      value: 0,
    ),
  ];

  int _getSettingIdxById(String settingId) {
    return _settings.indexWhere((element) => element.id == settingId);
  }

  int getValueById(String settingId) {
    return _settings[_getSettingIdxById(settingId)].value;
  }

  void switchValueOfSetting(String settingId) {
    _settings[_getSettingIdxById(settingId)].value ^= 1;
    notifyListeners();
  }

  List<Setting> get items {
    return [..._settings];
  }
}
