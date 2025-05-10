import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF0D47A1); // Deep Blue
  static const Color white = Colors.white;
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryBlue,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryBlue,
    foregroundColor: AppColors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.white,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.primaryBlue),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryBlue,
    foregroundColor: AppColors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryBlue),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryBlue),
    ),
  ),
);
