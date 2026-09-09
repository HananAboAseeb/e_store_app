import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'app_fonts.dart';
import 'app_text_theme.dart';
import 'button_themes.dart';
import 'color_schemes.dart';
import 'component_themes.dart';
import 'input_themes.dart';
import 'navigation_themes.dart';

/// Application theme configuration.
///
/// Composes [ThemeData] from modular sub-theme files:
/// - [AppColorSchemes]       — light/dark [ColorScheme]
/// - [AppButtonThemes]       — elevated, outlined, text buttons
/// - [AppInputThemes]        — input decoration
/// - [AppNavigationThemes]   — app bar, bottom nav
/// - [AppComponentThemes]    — card, chip, divider, FAB
///
/// **No ScreenUtil** — raw `double` values only. Widgets apply responsive
/// sizing (`.w`, `.h`, `.sp`, `.r`) at the widget level.
class AppTheme {
  AppTheme._();

  // ─── Light Theme ──────────────────────────────
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: AppFonts.appFontFamily,
        colorScheme: AppColorSchemes.light,
        textTheme: AppTextTheme.textTheme,
        // Navigation
        appBarTheme: AppNavigationThemes.appBarLight,
        bottomNavigationBarTheme: AppNavigationThemes.bottomNavLight,
        // Buttons
        elevatedButtonTheme: AppButtonThemes.elevatedLight,
        outlinedButtonTheme: AppButtonThemes.outlinedLight,
        textButtonTheme: AppButtonThemes.textLight,
        // Inputs
        inputDecorationTheme: AppInputThemes.light,
        // Components
        cardTheme: AppComponentThemes.cardLight,
        chipTheme: AppComponentThemes.chipLight,
        dividerTheme: AppComponentThemes.dividerLight,
        floatingActionButtonTheme: AppComponentThemes.fabLight,
      );

  // ─── Dark Theme ───────────────────────────────
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.darkBackground,
        fontFamily: AppFonts.appFontFamily,
        colorScheme: AppColorSchemes.dark,
        textTheme: AppTextTheme.textTheme,
        // Navigation
        appBarTheme: AppNavigationThemes.appBarDark,
        bottomNavigationBarTheme: AppNavigationThemes.bottomNavDark,
        // Buttons
        elevatedButtonTheme: AppButtonThemes.elevatedDark,
        outlinedButtonTheme: AppButtonThemes.outlinedDark,
        textButtonTheme: AppButtonThemes.textDark,
        // Inputs
        inputDecorationTheme: AppInputThemes.dark,
        // Components
        cardTheme: AppComponentThemes.cardDark,
        chipTheme: AppComponentThemes.chipDark,
        dividerTheme: AppComponentThemes.dividerDark,
        floatingActionButtonTheme: AppComponentThemes.fabDark,
      );
}
