import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import 'app_fonts.dart';

/// [AppBarTheme] and [BottomNavigationBarThemeData] for light and dark modes.
class AppNavigationThemes {
  AppNavigationThemes._();

  // ─── AppBar ───────────────────────────────────
  static const AppBarTheme appBarLight = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
    titleTextStyle: TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
  );

  static const AppBarTheme appBarDark = AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: AppColors.white),
    titleTextStyle: TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
  );

  // ─── Bottom Navigation ────────────────────────
  static const BottomNavigationBarThemeData bottomNavLight =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.gray400,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    selectedLabelStyle: TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  );

  static const BottomNavigationBarThemeData bottomNavDark =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.primary300,
    unselectedItemColor: AppColors.gray500,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    selectedLabelStyle: TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  );
}
