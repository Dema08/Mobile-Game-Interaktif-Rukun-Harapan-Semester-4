import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'config/theme.dart';
import 'lang/localization_translations.dart';
import 'modules/controllers/app_controller.dart';
import 'routes/app_pages.dart';
import 'routes/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // Inisialisasi format tanggal berdasarkan lokal yang dipilih
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    // * Memuat bahasa yang sudah disimpan (jika ada)
    controller.loadPreferredLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'Aplikasi Game',
        theme: themeData, // Tema aplikasi
        getPages: AppPages.pages, // Routing aplikasi
        debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
        initialRoute: RouteNames.splashScreen, // Rute awal aplikasi
        locale: controller.preferredLocale.value, // Locale yang dipilih
        fallbackLocale:
            const Locale('id', 'ID'), // Locale cadangan jika tidak ditemukan
        translations:
            LocalizationTranslations(), // Terjemahan untuk berbagai bahasa
      );
    });
  }
}
