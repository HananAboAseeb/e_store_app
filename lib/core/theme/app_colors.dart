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
  // Payment Brand & Surface Colors (Screens 51–56)
  // ─────────────────────────────────────────────
  /// Soft blush background tint for Visa payment card (Screen 52)
  static const Color blushSoft = Color(0xFFFFECEB);

  /// Dark navy blue for Visa branding logo (Screen 52)
  static const Color visaBlue = Color(0xFF1A1F71);

  /// Mastercard brand red circle logo (Screen 51, 52)
  static const Color mastercardRed = Color(0xFFEB001B);

  /// Mastercard brand yellow/orange circle logo (Screen 51, 52)
  static const Color mastercardYellow = Color(0xFFF79E1B);

  /// PayPal brand blue circular badge (Screen 53)
  static const Color paypalBlue = Color(0xFF0079C1);

  // ─────────────────────────────────────────────
  // Surfaces & Backgrounds
  // ─────────────────────────────────────────────
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);

  /// Product image card background (Figma ShopX)
  static const Color surfaceCardImage = Color(0xFFF5F5F5);

  /// Subtle card shadow for elevated product cards and calendars (Figma ShopX)
  static const Color cardShadow = Color(0x1F000000);

  /// Shipping Address & Contact Information card background in Checkout (Screen 47)
  static const Color surfaceAddress = Color(0xFFF2F2F2);

  /// Unselected Shipping Options & Payment Methods chip background in Checkout (Screen 47)
  static const Color surfaceOption = Color(0xFFE6E6E6);

  // ─────────────────────────────────────────────
  // Text Colors
  // ─────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textCardTitle = Color(0xFF292929);
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

  /// Discount & promotional badge pink accent (Figma ShopX)
  static const Color discount = Color(0xFFFF5790);

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
  // Keypad & Input Fill Colors
  // ─────────────────────────────────────────────
  static const Color keyFill = Color(0xFFE5E5E5);

  // ─────────────────────────────────────────────
  // Orders & Shipment Status Colors (Screens 57–67)
  // ─────────────────────────────────────────────
  /// Amber/Orange status color for Packed milestone (Screen 57, 59)
  static const Color statusPacked = Color(0xFFFFAE00);

  /// Primary blue status color for Shipped milestone (Screen 57, 59)
  static const Color statusShipped = Color(0xFF004BFE);

  /// Green status color for Delivered milestone (Screen 57, 63)
  static const Color statusDelivered = Color(0xFF34C759);

  /// Alert red color for failed delivery attempt milestone (Screen 60, 61)
  static const Color statusFailed = Color(0xFFFF3B30);

  /// Golden yellow color for interactive and displayed rating stars (Screen 66, 67)
  static const Color starGold = Color(0xFFFFAE00);

  /// Neutral gray vertical timeline connecting line (Screen 59, 61, 63)
  static const Color timelineLine = Color(0xFFE5E7EB);

  /// Header circular action button background (Screen 57)
  static const Color headerActionBg = Color(0xFFF0F4F8);

  /// Gray pill background for item count (Screen 57)
  static const Color countPillBg = Color(0xFFE8ECEF);

  /// Image background inside thumbnail collage card (Screen 57)
  static const Color thumbnailBg = Color(0xFFF2F4F7);

  /// Modal close button circular background: #000000 with 10% opacity (Screen 58, 61)
  static const Color closeButtonBg = Color(0x1A000000);

  /// Modal close button icon: #000000 with 50% opacity (Screen 58, 61)
  static const Color closeButtonIcon = Color(0x7F000000);
}
