import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'app_fonts.dart';

/// Button theme definitions for [ElevatedButton], [OutlinedButton], and
/// [TextButton] — shared across light and dark modes.
class AppButtonThemes {
  AppButtonThemes._();

  // ─── Elevated ─────────────────────────────────
  static final ElevatedButtonThemeData elevatedLight =
      ElevatedButtonThemeData(style: _elevatedStyle(AppColors.primary));

  static final ElevatedButtonThemeData elevatedDark =
      ElevatedButtonThemeData(style: _elevatedStyle(AppColors.primary));

  static ButtonStyle _elevatedStyle(Color bg) => ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontFamily: AppFonts.appFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      );

  // ─── Outlined ─────────────────────────────────
  static final OutlinedButtonThemeData outlinedLight =
      OutlinedButtonThemeData(style: _outlinedStyle(AppColors.primary));

  static final OutlinedButtonThemeData outlinedDark =
      OutlinedButtonThemeData(style: _outlinedStyle(AppColors.primary300));

  static ButtonStyle _outlinedStyle(Color accent) => OutlinedButton.styleFrom(
        foregroundColor: accent,
        side: BorderSide(color: accent),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontFamily: AppFonts.appFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      );

  // ─── Text Button ──────────────────────────────
  static final TextButtonThemeData textLight =
      TextButtonThemeData(style: _textStyle(AppColors.primary));

  static final TextButtonThemeData textDark =
      TextButtonThemeData(style: _textStyle(AppColors.primary300));

  static ButtonStyle _textStyle(Color accent) => TextButton.styleFrom(
        foregroundColor: accent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: const TextStyle(
          fontFamily: AppFonts.appFontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );
}
