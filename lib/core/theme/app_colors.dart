import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─────────────────────────────────────────────
  // Primary Palette (Figma ShopX Tokens)
  // ─────────────────────────────────────────────
  static const Color primary900 = Color(0xFF001850);
  static const Color primary800 = Color(0xFF002272);
  static const Color primary700 = Color(0xFF002E9C);
  static const Color primary600 = Color(0xFF003AC1);
  static const Color primary500 = Color(0xFF0040DB);
  static const Color primary400 = Color(0xFF004BFE); // Main Primary Accent
  static const Color primary300 = Color(0xFF2968FF);
  static const Color primary200 = Color(0xFF5184FF);
  static const Color primary100 = Color(0xFF789FFE);
  static const Color primary50 = Color(0xFFBFD2FF);

  /// Convenience alias — maps to the main primary accent `primary400`.
  static const Color primary = primary400;

  /// Soft light blue tint for subtle backgrounds, chips, and input fills (Screens 47–50)
  static const Color primarySoft = Color(0xFFE6EEFF);

  // ─────────────────────────────────────────────
  // Surfaces & Backgrounds
  // ─────────────────────────────────────────────
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);

  /// Shipping Address & Contact Information card background in Checkout (Screen 47)
  static const Color surfaceAddress = Color(0xFFF2F2F2);

  /// Unselected Shipping Options & Payment Methods chip background in Checkout (Screen 47)
  static const Color surfaceOption = Color(0xFFE6E6E6);

  // ─────────────────────────────────────────────
  // Text Colors
  // ─────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textWhite = Color(0xFFFFFFFF);

  // ─────────────────────────────────────────────
  // Neutrals (Base + Gray Scale)
  // ─────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // ─────────────────────────────────────────────
  // Status & Feedback Colors
  // ─────────────────────────────────────────────
  static const Color success = Color(0xFF34C759);
  static const Color error = Color(0xFFFF3B30);
  static const Color warning = Color(0xFFFF9500);

  // ─────────────────────────────────────────────
  // Borders & Dividers
  // ─────────────────────────────────────────────
  static const Color border = Color(0xFFE5E5E5);
  static const Color divider = Color(0xFFEAECF0);

  // ─────────────────────────────────────────────
  // Dark Theme Colors
  // ─────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF334155);
  static const Color darkBorder = Color(0xFF475569);

  // ─────────────────────────────────────────────
  // Radii Tokens
  // ─────────────────────────────────────────────
  static const double buttonRadius = 24.0;
  static const double inputRadius = 24.0;
  static const double cardRadius = 20.0;
  static const double pinBoxRadius = 12.0;

  // ─────────────────────────────────────────────
  // Keypad & Input Fill Colors
  // ─────────────────────────────────────────────
  static const Color keyFill = Color(0xFFE5E5E5);
}
