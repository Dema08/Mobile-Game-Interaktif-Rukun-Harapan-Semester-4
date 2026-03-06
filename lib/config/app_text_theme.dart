import 'package:flutter/material.dart';

class AppTextTheme {
  const AppTextTheme(this._themeData);

  final ThemeData _themeData;

  TextStyle get titleLarge => _themeData.textTheme.titleLarge!;
  TextStyle get titleMedium => _themeData.textTheme.titleMedium!;
  TextStyle get titleSmall => _themeData.textTheme.titleSmall!;
  TextStyle get bodyLarge => _themeData.textTheme.bodyLarge!;
  TextStyle get bodyMedium => _themeData.textTheme.bodyMedium!;
  TextStyle get bodySmall => _themeData.textTheme.bodySmall!;
}
