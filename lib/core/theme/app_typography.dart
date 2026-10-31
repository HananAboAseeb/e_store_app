import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle get h1 => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get h2 => TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get body => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get buttonText => TextStyle(
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
