import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/local/local_storage.dart';
import '../../lang/lang_enum.dart';

class AppController extends GetxController {
  Rx<Locale> preferredLocale = const Locale('id', 'ID').obs;

  void loadPreferredLocale() async {
    final locale = await LocalStorage.getActiveLanguage();
    preferredLocale.value = locale;
    Get.updateLocale(locale);
  }

  Future<void> changePreferredLocale(Language lang) async {
    await LocalStorage.setActiveLanguage(lang);
    Locale locale;
    switch (lang) {
      case Language.indonesian:
        locale = const Locale('id', 'ID');
        break;
      case Language.mandarin:
        locale = const Locale('zh', 'CN');
        break;
      case Language.english:
      default:
        locale = const Locale('en', 'US');
    }

    preferredLocale.value = locale;
    Get.updateLocale(locale);
  }
}
