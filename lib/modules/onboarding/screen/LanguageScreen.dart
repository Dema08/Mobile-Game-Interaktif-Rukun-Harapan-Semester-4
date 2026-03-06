import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:NumeriGo/constants/colors.dart';
import 'package:NumeriGo/routes/route_names.dart';
import 'package:NumeriGo/modules/onboarding/widget/LeanguageCard.dart';
import 'package:NumeriGo/modules/home/widget/WavesBackground.dart';
import '../../../lang/lang_enum.dart';
import '../../controllers/app_controller.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  Future<void> _handleChangeLanguage(String value) async {
    final _appController = Get.find<AppController>();
    Language activeLanguage;

    // Tentukan bahasa yang dipilih
    if (value == 'Bahasa Indonesia') {
      activeLanguage = Language.indonesian;
    } else if (value == 'Mandarin') {
      activeLanguage = Language.mandarin;
    } else {
      activeLanguage = Language.english;
    }

    // Ubah bahasa melalui AppController
    await _appController.changePreferredLocale(activeLanguage);

    // Arahkan ke OnboardingScreen setelah bahasa diubah
    Get.toNamed(RouteNames.onboardingScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const WavesBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Which Language Do You Speak?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 20),
                // Pilihan bahasa menggunakan LanguageCard
                LanguageCard(
                  language: 'Bahasa Indonesia',
                  flag: '🇮🇩',
                  onTap: () async {
                    await _handleChangeLanguage('Bahasa Indonesia');
                  },
                ),
                LanguageCard(
                  language: 'Mandarin',
                  flag: '🇨🇳',
                  onTap: () async {
                    await _handleChangeLanguage('Mandarin');
                  },
                ),
                LanguageCard(
                  language: 'English',
                  flag: '🇺🇸',
                  onTap: () async {
                    await _handleChangeLanguage('English');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
