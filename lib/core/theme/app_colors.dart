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

  /// Grey surface fill for Announcement card, Month Selector pill, and surface containers (Figma #F2F2F2)
  static const Color surfaceAnnouncement = Color(0xFFF2F2F2);
  static const Color surfaceContainer = Color(0xFFF2F2F2);

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

  // ─────────────────────────────────────────────
  // Profile, Activity & Rewards Colors (Screens 62, 64, 81–85)
  // ─────────────────────────────────────────────
  /// Soft pink background for voucher expiring announcement (Screen 85)
  static const Color rewardBackground = Color(0xFFFDECEE);

  /// Red border and alert text for expiring vouchers (Screen 83)
  static const Color voucherWarning = Color(0xFFFF3B30);

  /// Soft pink background fill for expiring voucher ticket (Screen 83)
  static const Color voucherWarningBg = Color(0xFFFFF0F2);

  /// Coral red text for voucher "Valid Until" date (Screen 82, 83)
  static const Color voucherValidDate = Color(0xFFFF6060);

  /// Blue segment in My Activity donut chart (Screen 64 - Clothing 50.1%)
  static const Color chartBlue = Color(0xFF004BFE);

  /// Green segment in My Activity donut chart (Screen 64 - Lingerie 25.2%)
  static const Color chartGreen = Color(0xFF70B92B);

  /// Orange segment in My Activity donut chart (Screen 64 - Shoes 12.9%)
  static const Color chartOrange = Color(0xFFF48A25);

  /// Red/Pink segment in My Activity donut chart (Screen 64 - Bags 11.8%)
  static const Color chartRed = Color(0xFFE60049);

  /// Red badge background for "Live" stories indicator (Screen 62, 81, 85)
  static const Color storyLiveRed = Color(0xFFFF1744);

  /// Primary blue for reward progress icons and badges (Screen 84)
  static const Color rewardIconBlue = Color(0xFF004BFE);

  /// Light gray fill for inactive progress tab pill (Screen 82, 84)
  static const Color tabInactiveBg = Color(0xFFE8ECEF);

  // ─────────────────────────────────────────────
  // Chat Feature Colors (Screens 68–80)
  // ─────────────────────────────────────────────
  /// Gradient top for Chat background (Screens 68–79)
  static const Color chatBgTop = Color(0xFFE8F1FD);

  /// Gradient middle for Chat background (Screens 68–79)
  static const Color chatBgMiddle = Color(0xFFFFFFFF);

  /// Gradient bottom for Chat background (Screens 68–79)
  static const Color chatBgBottom = Color(0xFFE8F1FD);

  /// Soft blue background for bot message bubbles & appbar avatar (#004CFF26)
  static const Color chatBubbleBg = Color(0x26004CFF);

  /// Background for bot message bubbles (Screens 68–71) - #004CFF26
  static const Color botBubbleBg = chatBubbleBg;

  /// Primary blue for user message bubbles (Screens 71–79)
  static const Color userBubbleBg = primary400;

  /// Primary blue for agent message bubbles (Screens 73–79)
  static const Color agentBubbleBg = primary400;

  /// Active background for selected issue chip (Screens 68, 69)
  static const Color chipActiveBg = primary400;

  /// Border color for inactive issue chips (Screens 68, 69)
  static const Color chipInactiveBorder = primary400;

  /// Background for inactive issue chips (Screens 68, 69)
  static const Color chipInactiveBg = Color(0xFFFFFFFF);

  /// Grey color for 3-dot typing and connecting indicators (Screens 71, 72, 73)
  static const Color typingDot = Color(0xFF8E8E93);

  /// Gold color for selected rating stars in customer care review (Screen 80)
  static const Color chatReviewStar = Color(0xFFFFAE00);

  /// Soft light blue tint for comment input field in review modal (Screen 80)
  static const Color chatReviewFieldBg = Color(0xFFF0F5FF);

  /// Subtle light blue border for comment input field in review modal (Screen 80)
  static const Color chatReviewFieldBorder = Color(0xFFD6E4FF);

  /// Light blue background for selected order summary cards in chat (Screens 70–79)
  static const Color chatOrderCardBg = Color(0xFFDCEBFE);

  /// Soft light blue background for count badge in chat order card
  static const Color chatOrderPillBg = Color(0xFFD4E2F6);

  // ─────────────────────────────────────────────
  // Settings Feature Colors (Screens 86–100)
  // ─────────────────────────────────────────────
  /// Soft pink background for Delete My Account button (Screen 87)
  static const Color deleteAccountBg = Color(0xFFFFECEB);

  /// Circular light grey background for Delete warning dialog icon badge (Screen 99)
  static const Color deleteWarningBg = Color(0xFFEAEAEA);

  /// Coral red shopping bag icon color for debit transactions in Payment History (Screen 92)
  static const Color historyDebitIcon = Color(0xFFFF5B60);

  /// Soft pink background fill for debit transaction card in Payment History (Screen 92)
  static const Color historyDebitCardBg = Color(0xFFFFF0F2);

  /// Primary blue shopping bag icon color for credit transactions in Payment History (Screen 92)
  static const Color historyCreditIcon = Color(0xFF004BFE);

  /// Soft blue radial glow color at top of About ShopX screen (Screen 100)
  static const Color aboutGlow = Color(0xFFE1EDFF);

  /// Active selection background for language, currency, sizes, and country tiles
  static const Color activeSelectionBg = Color(0xFFE6EEFF);

  /// Divider color between settings menu items (Figma #0000001A)
  static const Color settingsDivider = Color(0x1A000000);

  /// Soft blue tint for card input fields and profile fields (Figma #004CFF1A)
  static const Color cardFieldBg = Color(0x1A004CFF);

  /// Grey color for "Required" placeholder text in card fields (Figma #969CA7)
  static const Color cardFieldRequired = Color(0xFF969CA7);

  /// Background for Edit Information button in profile (Figma #00000026)
  static const Color profileEditButtonBg = Color(0x26000000);

  /// Selected preference option tile background (Figma #004CFF26)
  static const Color selectedOptionBg = Color(0x26004CFF);

  /// Unselected preference option tile background (Figma #0000001A)
  static const Color unselectedOptionBg = Color(0x1A000000);
}
