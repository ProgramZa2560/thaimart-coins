import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFEF7FF);
  static const cardBackground = Color(0xFFFBEAF6);
  static const textPrimary = Color(0xFF000000);
  static const textSecondary = Color(0xFFB9B7BA);
  static const red = Color(0xFFEF5350);
  static const redBorder = Color(0xFFEE3E37);
  static const green = Color(0xFF66BB6A);
  static const greenBorder = Color(0xFF49B54F);
  static const accent = Color(0xFF8B5CF6);
  static const divider = Color(0xFFDAD3DE);
  static const searchField = Color(0xFFEFEDF0);
}

class AppTheme {
  /// Bundled SF Pro Display — same font on every platform including web.
  static const fontFamily = 'SF Pro Display';

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily,
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
