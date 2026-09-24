import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'app_fonts.dart';

/// Miscellaneous component themes: Card, Chip, Divider, FAB.
class AppComponentThemes {
  AppComponentThemes._();

  // ─── Card ─────────────────────────────────────
  // NOTE: ThemeData.cardTheme requires CardThemeData, NOT CardTheme.
  // CardTheme is the InheritedWidget; CardThemeData is the data class.
  static final CardThemeData cardLight = CardThemeData(
    color: AppColors.card,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.zero,
  );

  static final CardThemeData cardDark = CardThemeData(
    color: AppColors.darkCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.zero,
  );

  // ─── Chip ─────────────────────────────────────
  static final ChipThemeData chipLight = ChipThemeData(
    backgroundColor: AppColors.gray100,
    selectedColor: AppColors.primary50,
    labelStyle: const TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 12,
      color: AppColors.gray700,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    side: BorderSide.none,
  );

  static final ChipThemeData chipDark = ChipThemeData(
    backgroundColor: AppColors.darkCard,
    selectedColor: AppColors.primary700,
    labelStyle: const TextStyle(
      fontFamily: AppFonts.appFontFamily,
      fontSize: 12,
      color: AppColors.gray300,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    side: const BorderSide(color: AppColors.darkBorder),
  );

  // ─── Divider ──────────────────────────────────
  static const DividerThemeData dividerLight = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
  );

  static const DividerThemeData dividerDark = DividerThemeData(
    color: AppColors.darkBorder,
    thickness: 1,
  );

  // ─── FAB ──────────────────────────────────────
  static final FloatingActionButtonThemeData fabLight =
      FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  static final FloatingActionButtonThemeData fabDark =
      FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
