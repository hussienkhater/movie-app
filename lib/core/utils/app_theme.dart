import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';

abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.white,
            fontSize: 16,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.white,
            fontSize: 14,
          ),
          bodyMedium: TextStyle(
              fontFamily: 'Poppins',
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.primary,
          selectedItemColor: AppColors.secondary,
          unselectedItemColor: AppColors.grey,
          selectedLabelStyle:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ));
  }
}
