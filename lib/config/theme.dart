import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'app_text_theme.dart';

// * BORDER
// final defaultBorder = BorderRadius.circular(10);
// final smallBorder = BorderRadius.circular(6);

// * SHADOW
final defaultShadow = BoxShadow(
  blurRadius: 2,
  color: blackColor.withOpacity(0.08),
);

// * THEME
final themeData = ThemeData(
  fontFamily: 'Inter',
  useMaterial3: false,
  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: whiteColor,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primary90Color,
        fontFamily: 'Inter'),
    titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: primary90Color,
        fontFamily: 'Inter'),
    titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primary90Color,
        fontFamily: 'Inter'),
    bodyLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primary90Color,
        fontFamily: 'Inter'),
    bodyMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: primary90Color,
        fontFamily: 'Inter'),
    bodySmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: primary90Color,
      fontFamily: 'Inter',
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.5,
    centerTitle: true,
    backgroundColor: whiteColor,
    titleTextStyle: TextStyle(
      fontSize: 18,
      color: primary90Color,
      fontWeight: FontWeight.w500,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1,
      backgroundColor: base50Color,
      fixedSize: const Size(150, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      backgroundColor: whiteColor,
      fixedSize: const Size(150, 45),
      foregroundColor: primary90Color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(width: 1, color: neutral70Color),
      ),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      labelStyle: const TextStyle(color: neutral70Color),
      floatingLabelStyle: const TextStyle(color: primary90Color),
      hintStyle: const TextStyle(
        fontSize: 14,
        color: neutral70Color,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: neutral50Color),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primary90Color),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: error50Color),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: error50Color),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: neutral50Color),
        borderRadius: BorderRadius.circular(10),
      ),
      errorStyle: const TextStyle(color: error50Color),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    alignLabelWithHint: true,
    labelStyle: const TextStyle(color: neutral70Color),
    floatingLabelStyle: const TextStyle(color: primary90Color),
    hintStyle: const TextStyle(
      fontSize: 14,
      color: neutral70Color,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutral50Color),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: primary90Color),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: error50Color),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: error50Color),
      borderRadius: BorderRadius.circular(10),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutral50Color),
      borderRadius: BorderRadius.circular(10),
    ),
    errorStyle: const TextStyle(color: error50Color),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: primary90Color,
    unselectedLabelColor: neutral70Color,
    labelStyle: TextStyle(
      color: primary90Color,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Inter',
      color: neutral70Color,
      fontWeight: FontWeight.w500,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: true,
    backgroundColor: whiteColor,
    selectedItemColor: primary90Color,
    unselectedItemColor: neutral70Color,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
      color: primary90Color,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(color: neutral70Color),
    selectedIconTheme: IconThemeData(color: primary90Color),
    unselectedIconTheme: IconThemeData(color: neutral70Color),
  ),
  datePickerTheme: const DatePickerThemeData(
    todayBackgroundColor: WidgetStatePropertyAll(accent50Color),
  ),
);

final appTextTheme = AppTextTheme(themeData);
