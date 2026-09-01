import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFEF7FF);
  static const textPrimary = Color(0xFF000000);
  static const textSecondary = Color(0xFFB9B7BA);
  static const textMuted = Color(0xFF5A585C);
  static const textTertiary = Color(0xFF6B7280);
  static const red = Color(0xFFEF5350);
  static const redBorder = Color(0xFFEE3E37);
  static const green = Color(0xFF66BB6A);
  static const greenBorder = Color(0xFF49B54F);
  static const accent = Color(0xFF8B5CF6);
  static const tryAgain = Color(0xFF715EA9);
  static const readMore = Color(0xFF66AAF4);
  static const divider = Color(0xFFDAD3DE);
  static const searchField = Color(0xFFEFEDF0);
  static const top3CardBg = Color(0xFFF7F2FA);
  static const top3CardShadow = Color(0xFFE1DBE2);
  static const top3Price = Color(0xFF5A585C);
  static const detailValue = Color(0xFF6D6A6F);
  static const inviteIcon = Color(0xFF6A43B8);
  static const inviteHead = Color(0xFF5E31B2);
  static const inviteSub = Color(0xFFA994D3);
  static const inviteBg = Color(0xFFEDE7F6);
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
