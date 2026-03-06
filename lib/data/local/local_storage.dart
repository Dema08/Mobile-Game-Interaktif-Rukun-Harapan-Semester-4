import 'dart:convert';
import 'dart:developer';

import 'package:NumeriGo/data/models/Kelas.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../lang/lang_enum.dart';
import '../models/Siswa.dart';

class LocalStorage {
  // * KEYS FOR STORING SESSION VALUE
  static const String isOnboard = 'IS_ONBOARD';
  static const String language = 'LANGUAGE';
  static const String isGuest = 'IS_GUEST';
  static const String isLoggedIn = 'IS_LOGGED_IN';
  static const String bearerToken = 'BEARER_TOKEN';
  static const String userData = 'USER_DATA';
  static const String kelasData = 'KELAS_DATA';

  static Future<bool> checkIsOnboard() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isOnboard) ?? false;
  }

  static Future saveUser(Siswa user) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(userData, jsonEncode(user));
  }

  static Future deleteUser() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(userData);
  }

  static Future<Siswa?> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(userData);
    log(data.toString(), name: 'GET USER LOCAL STORAGE');
    if (data == null) return null;
    return Siswa.fromJson(jsonDecode(data));
  }

  static Future<Kelas?> getKelas() async {
    final preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(kelasData);
    if (data == null) return null;
    return Kelas.fromJson(jsonDecode(data));
  }

  static Future saveKelas(Kelas kelas) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(kelasData, jsonEncode(kelas));
  }

  static Future<bool> setIsOnboard() async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isOnboard, true);
  }

  static Future<Locale> getActiveLanguage() async {
    final preferences = await SharedPreferences.getInstance();
    final locale = preferences.getString(language) ?? "ID";

    switch (locale) {
      case "ID":
        return const Locale("id", "ID");
      case "EN":
        return const Locale("en", "US");
      case "ZH":
        return const Locale("zh", "CN");
      default:
        return const Locale("id", "ID");
    }
  }

  static Future<bool> setActiveLanguage(Language selectedLanguage) async {
    final preferences = await SharedPreferences.getInstance();

    switch (selectedLanguage) {
      case Language.indonesian:
        return await preferences.setString(language, "ID");
      case Language.english:
        return await preferences.setString(language, "EN");
      case Language.mandarin:
        return await preferences.setString(language, "ZH");
      default:
        return await preferences.setString(language, "ID");
    }
  }

  static Future<bool> checkIsLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isLoggedIn) ?? false;
  }

  static Future<bool> saveSession(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(isLoggedIn, true);
    return await preferences.setString(bearerToken, token);
  }

  static Future<String> getBearerToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(bearerToken) ?? "";
  }

  static Future<bool> clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(isLoggedIn);
    await preferences.remove(isGuest);
    return await preferences.remove(bearerToken);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('auth_token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
