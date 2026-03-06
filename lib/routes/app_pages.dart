import 'package:NumeriGo/modules/home/Page/HomePage.dart';
import 'package:NumeriGo/modules/home/screen/HomeScreen.dart';
import 'package:NumeriGo/modules/ujian_1/Screen/MapLevelScreen.dart';
import 'package:NumeriGo/modules/ujian_1/Screen/UjianSelesai.dart';
import 'package:NumeriGo/modules/ujian_1/Screen/soalUjianPage.dart';
import 'package:NumeriGo/modules/ujian_1/Screen/SoalSelesai.dart';
import 'package:NumeriGo/modules/ujian_2/Screen/MapLevelScreenCard.dart';
import 'package:NumeriGo/modules/ujian_2/Screen/SoalSelesaiCard.dart';
import 'package:NumeriGo/modules/ujian_2/Screen/soalUjianPageCard.dart';
import '../modules/ujian_2/Screen/UjianSelesaiCard.dart';
import 'package:NumeriGo/modules/ujian_2/Screen/ScanBarcode.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart'
    as get_transition;
import '../modules/authentication/screen/login_screen.dart';
import '../modules/onboarding/screen/LanguageScreen.dart';
import '../modules/onboarding/screen/OnboardingScreen.dart';
import '../modules/onboarding/screen/splash_screen.dart';
import 'route_names.dart';

import 'package:NumeriGo/modules/animation/zoom_transition.dart';
import 'package:NumeriGo/modules/animation/fade_zoom_transition.dart';
import 'package:NumeriGo/modules/animation/slide_up_transition.dart';

class AppPages {
  static final pages = [
    // * SPLASH
    GetPage(
      name: RouteNames.splashScreen,
      page: () => const SplashScreen(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: RouteNames.languageScreen,
        page: () => LanguageScreen(),
        curve: Curves.easeInOut,
        customTransition: FadeZoomTransition()),
    GetPage(
      name: RouteNames.onboardingScreen,
      page: () => OnboardingScreen(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.loginscreen,
      page: () => const LoginScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteNames.homeScreen,
      page: () => const HomeScreen(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
    ),

    //Game1
    GetPage(
      name: RouteNames.MapLevelScreen,
      page: () => MapLevelScreen(),
      curve: Curves.easeInOut,
      customTransition: ZoomInTransition(),
    ),
    GetPage(
      name: RouteNames.SoalUjianPage,
      page: () => SoalUjianPage(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteNames.UjianSelesai,
      page: () => UjianSelesai(),
      curve: Curves.easeInOut,
      customTransition: SlideUpTransition(),
    ),
    GetPage(
      name: RouteNames.SoalSelesai,
      page: () => SoalSelesai(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
    ),

    //Game2
    GetPage(
      name: RouteNames.MapLevelScreenCard,
      page: () => MapLevelScreenCard(),
      curve: Curves.easeInOut,
      customTransition: ZoomInTransition(),
    ),
    GetPage(
      name: RouteNames.SoalUjianPageCard,
      page: () => SoalUjianPageCard(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteNames.UjianSelesaiCard,
      page: () => UjianSelesaiCard(),
      curve: Curves.easeInOut,
      customTransition: SlideUpTransition(),
    ),
    GetPage(
      name: RouteNames.SoalSelesaiCard,
      page: () => SoalSelesaiCard(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteNames.ScanBarcode,
      page: () => ScanBarcode(),
      curve: Curves.easeInOut,
      transition: Transition.rightToLeft,
    )
  ];
}
