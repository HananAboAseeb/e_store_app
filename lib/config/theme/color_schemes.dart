import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Centralized [ColorScheme] definitions for light and dark themes.
///
/// Uses the canonical Figma ShopX tokens from [AppColors].
class AppColorSchemes {
  AppColorSchemes._();

  static const ColorScheme light = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: AppColors.primary100,
    secondary: AppColors.primary300,
    secondaryContainer: AppColors.primary50,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.textPrimary,
    onError: AppColors.white,
  );

  static const ColorScheme dark = ColorScheme.dark(
    primary: AppColors.primary300,
    primaryContainer: AppColors.primary,
    secondary: AppColors.primary200,
    secondaryContainer: AppColors.primary600,
    surface: AppColors.darkSurface,
    error: AppColors.error,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.white,
    onError: AppColors.white,
  );
}
