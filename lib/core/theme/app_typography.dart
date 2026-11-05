import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle get h1 => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.25,
        letterSpacing: -0.28,
      );

  static TextStyle get h2 => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.28,
      );

  /// Card Sheet Modal Title (Figma Screens 90, 91: Raleway, 700, 24px, line-height: 36px, letter-spacing: -0.28px)
  static TextStyle get sheetTitle => h2.copyWith(height: 36 / 24);

  /// Form Field Label (Figma Screens 90, 91: Raleway, 600, 16px, line-height: 36px, letter-spacing: -0.28px)
  static TextStyle get fieldLabel => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 36 / 16,
        letterSpacing: -0.28,
      );

  static TextStyle get h3 => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        height: 19 / 16,
        letterSpacing: -0.15,
      );

  /// Card Title (Figma: Raleway, 700, 16px, line-height: 19px, letter-spacing: -0.15px)
  static TextStyle get cardTitle => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 19 / 16,
        letterSpacing: -0.15,
      );

  /// Card Description (Figma: Nunito Sans, 400, 12px, line-height: 18px, letter-spacing: 0px)
  static TextStyle get cardDescription => TextStyle(
        fontFamily: 'Nunito Sans',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 18 / 12,
        letterSpacing: 0,
      );

  static TextStyle get body => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySecondary => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodySmall => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get price => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get buttonText => TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      );

  // ─── Modal Sheet & Dialog Typography (Figma Screens 58, 61) ────
  static TextStyle get modalTitle => TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w900,
        color: const Color(0xFF000000),
        height: 1.15,
      );

  static TextStyle get modalSubtitle => TextStyle(
        fontSize: 18.5.sp,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF000000),
        height: 1.25,
        letterSpacing: -0.18,
      );

  static TextStyle get modalBody => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1E293B),
        height: 1.45,
        letterSpacing: 0,
      );

  // ─── Orders & Tracking Typography (Figma Screens 57, 59, 60, 63) ─
  static TextStyle get orderCardTitle => TextStyle(
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF111827),
        height: 1.15,
      );

  static TextStyle get orderCardSubtitle => TextStyle(
        fontSize: 12.5.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF4B5563),
        height: 1.15,
      );

  static TextStyle get orderCardCount => TextStyle(
        fontSize: 13.5.sp,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF111827),
        height: 1.15,
      );

  static TextStyle get trackingStepTitle => TextStyle(
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  static TextStyle get timestampPill => TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1F2937),
      );
}
