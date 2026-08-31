import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFDF3F9);
  static const cardBackground = Color(0xFFFBEAF6);
  static const textPrimary = Color(0xFF1B1B1F);
  static const textSecondary = Color(0xFF9A96A3);
  static const red = Color(0xFFF0364B);
  static const redBackground = Color(0xFFFDE4E7);
  static const green = Color(0xFF14B85C);
  static const greenBackground = Color(0xFFE2F6E9);
  static const accent = Color(0xFF8B5CF6);
  static const divider = Color(0xFFF0E4EC);
  static const searchField = Color(0xFFEFEDF0);
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          surface: AppColors.background,
        ),
        dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      );
}
