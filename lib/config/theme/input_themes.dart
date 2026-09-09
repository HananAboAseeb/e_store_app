import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'app_fonts.dart';

/// [InputDecorationTheme] definitions for text fields.
///
/// Uses a shared [_border] helper to eliminate the 5× repeated
/// [OutlineInputBorder] construction in the old monolithic theme.
class AppInputThemes {
  AppInputThemes._();

  // ─── Light ────────────────────────────────────
  static final InputDecorationTheme light = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.gray100,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: _border(),
    enabledBorder: _border(),
    focusedBorder: _border(color: AppColors.primary, width: 2),
    errorBorder: _border(color: AppColors.error, width: 1),
    focusedErrorBorder: _border(color: AppColors.error, width: 2),
    hintStyle: const TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 14,
      color: AppColors.gray400,
    ),
    labelStyle: const TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 14,
      color: AppColors.gray600,
    ),
    errorStyle: const TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 12,
      color: AppColors.error,
    ),
  );

  // ─── Dark ─────────────────────────────────────
  static final InputDecorationTheme dark = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkCard,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: _border(),
    enabledBorder: _border(color: AppColors.darkBorder, width: 1),
    focusedBorder: _border(color: AppColors.primary, width: 2),
    errorBorder: _border(color: AppColors.error, width: 1),
    focusedErrorBorder: _border(color: AppColors.error, width: 2),
    hintStyle: const TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 14,
      color: AppColors.gray500,
    ),
    labelStyle: const TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 14,
      color: AppColors.gray400,
    ),
    errorStyle: const TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 12,
      color: AppColors.error,
    ),
  );

  // ─── Helper ───────────────────────────────────
  static OutlineInputBorder _border({Color? color, double width = 0}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: color != null
            ? BorderSide(color: color, width: width)
            : BorderSide.none,
      );
}
