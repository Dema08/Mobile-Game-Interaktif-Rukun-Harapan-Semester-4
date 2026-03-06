import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/lang/lang_enum.dart';
import 'package:NumeriGo/modules/controllers/app_controller.dart';
import 'package:NumeriGo/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:NumeriGo/modules/onboarding/widget/LeanguageCard.dart';
import 'package:get/get.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  static Future<void> handleChangeLanguage(String value) async {
    final _appController = Get.find<AppController>();
    Language activeLanguage;

    if (value == 'Bahasa Indonesia') {
      activeLanguage = Language.indonesian;
    } else if (value == 'Mandarin') {
      activeLanguage = Language.mandarin;
    } else {
      activeLanguage = Language.english;
    }

    await _appController.changePreferredLocale(activeLanguage);
    Get.toNamed(RouteNames.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        title: Text(
          'choose_language'.tr,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primary90Color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary90Color, primary70Color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              LanguageCard(
                language: 'Bahasa Indonesia',
                flag: '🇮🇩',
                onTap: () async {
                  await LanguageSettingsPage.handleChangeLanguage(
                      'Bahasa Indonesia');
                },
              ),
              LanguageCard(
                language: 'Mandarin',
                flag: '🇨🇳',
                onTap: () async {
                  await LanguageSettingsPage.handleChangeLanguage('Mandarin');
                },
              ),
              LanguageCard(
                language: 'English',
                flag: '🇺🇸',
                onTap: () async {
                  await LanguageSettingsPage.handleChangeLanguage('English');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
