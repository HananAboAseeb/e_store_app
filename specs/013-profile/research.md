# Phase 0 Research: User Profile, Activity Dashboard & Rewards Center

**Feature**: `013-profile`  
**Date**: 2026-11-01  
**Status**: Completed  

---

## Technical Decisions & Architecture Analysis

### 1. Unification of Screens 62, 81, and 85 (Profile Home)

- **Decision**: Screens 62, 81, and 85 are represented by a single `ProfilePage` backed by `ProfileCubit`.
- **Rationale**: The layout structure, header, greeting, recently viewed carousel, order tabs, and stories across Screens 62, 81, and 85 are 100% identical. The ONLY variation is the announcement card state:
  - **Screen 62**: Regular announcement (light gray container, "Announcement" title, copy text, blue circular right-arrow button).
  - **Screen 81**: Reward announcement (light gray container, circular blue heart badge on left, "You just got a Reward" title, copy text).
  - **Screen 85**: Voucher expiring reminder (soft pink container `AppColors.rewardBackground`, circular red shopping bag badge on left, "Your Voucher will expire in 3 days" title, copy text).
  - *Secondary difference*: The notification dot on the `To Recieve` tab is red in Screen 62 and green in Screens 81/85.
- **Pattern**: An enum `ProfileAnnouncementType { regular, rewardEarned, voucherExpiring }` inside `AnnouncementEntity` drives the state in `ProfileState`. A specialized `AnnouncementCard` renders the appropriate styling and icons cleanly based on this enum without duplicating page code.
- **Alternatives Considered**: Creating three distinct pages was rejected because it introduces ~90% code duplication, breaks DRY, and makes route management convoluted.

---

### 2. Unification of Screens 82 and 83 (Active Vouchers)

- **Decision**: Screens 82 and 83 are represented by a single view (`VouchersTab` / `VouchersPage`) within `RewardsPage` backed by `RewardsCubit`.
- **Rationale**: Both screens render the exact same list of active vouchers. Screen 83 simply exhibits an urgent expiration state for the first voucher ("From Customer Care"):
  - **Screen 82**: Normal voucher styling (blue outline, coral expiration date "Valid Until 5.16.20").
  - **Screen 83**: Expiring voucher styling (red outline `AppColors.voucherWarning`, soft pink fill `AppColors.voucherWarningBg`, red dashed line, bold red "3 days left" text).
- **Pattern**: `VoucherEntity` has flags `isExpiring: bool` and `daysLeft: int`. `VoucherCard` inspects `isExpiring`:
  - If `true`: applies `AppColors.voucherWarning` border, `AppColors.voucherWarningBg` background, and renders "${daysLeft} days left".
  - If `false`: applies `AppColors.primary` border, white background, and renders "Valid Until ${validUntil}".
- **Alternatives Considered**: Creating separate pages for expiring vs non-expiring states was rejected as it violates standard domain modeling where expiration is an attribute of voucher data.

---

### 3. Screen 84 (Rewards Progress) & Tab Navigation

- **Decision**: Screens 82, 83, and 84 are unified under `RewardsPage` mounted at `/profile/rewards`, housing two tabs: `Active Rewards` (Screens 82, 83) and `Progress` (Screen 84).
- **Rationale**: The top tab bar (`RewardsTabs`) has two options: "Active Rewards" and "Progress". When "Active Rewards" is selected, vouchers are shown. When "Progress" is selected, the 2-column by 3-row grid of milestone badges is shown.
- **Pattern**: `RewardsCubit` manages `RewardsTab { activeRewards, progress }`. Toggling tabs updates state in memory instantly (<100ms) with zero layout thrashing or redundant network requests.
- **Milestone Grid Design**: A 2-column grid (`GridView.builder` or wrapped rows) displaying 6 achievement cards:
  - First Purchase (Earned checkmark)
  - Loyal Customer (Earned checkmark)
  - Review Maker
  - Big Soul
  - Cloth Expert
  - 10+ Orders
  - Earned badges reuse `VerifiedCheckBadge` from `lib/shared/widgets/verified_check_badge.dart`.

---

### 4. Donut Chart Implementation Approach (Screen 64 - My Activity)

- **Decision**: Implement a custom lightweight `DonutChartPainter` using Flutter's native `CustomPainter` (`canvas.drawArc`).
- **Rationale**:
  - Zero external chart dependencies (e.g. `fl_chart`), preserving minimal binary footprint and preventing version conflicts with Flutter 3.44.6.
  - Pixel-perfect control over stroke width, sweep angles, segment gaps, and centered typography.
  - Proportions are calculated directly from `CategorySpendingEntity.amount / totalAmount`:
    - Clothing: $183.00 / $365.00 = 50.1% -> ~180.5° (Blue `AppColors.chartBlue`)
    - Lingerie: $92.00 / $365.00 = 25.2% -> ~90.7° (Green `AppColors.chartGreen`)
    - Shoes: $47.00 / $365.00 = 12.9% -> ~46.4° (Orange `AppColors.chartOrange`)
    - Bags: $43.00 / $365.00 = 11.8% -> ~42.4° (Red/Pink `AppColors.chartRed`)
  - Center of the donut displays `Total` in `AppTypography.caption` and `$365,00` in bold `AppTypography.h1`.
- **Alternatives Considered**: Using an external chart package was rejected because existing packages require rigid configuration, may not match Figma corner geometry or radius accurately, and add unnecessary bloat.

---

### 5. Ticket Voucher Shape & Dashed Line Implementation

- **Decision**: Custom clipper or painter `TicketShapePainter` for voucher cards.
- **Rationale**:
  - The voucher card in Screens 82 and 83 features rounded outer corners with concave circular semicircular cutouts (notches) on the left and right edges.
  - A horizontal dashed divider line connects the notch centers across the card width.
  - Above the divider: "Voucher" title and expiration date / warning.
  - Below the divider: Icon, title, and discount description.
  - `TicketShapePainter` draws the outline, background fill, notches via `Path.arcToPoint`, and dashed line via iterating dash segments.

---

### 6. Component Reuse & DRY Strategy Confirmation

| Widget | Reuse Status | Source / Justification |
|---|---|---|
| `CustomBottomNavBar` | **REUSE** | `lib/shared/navigation/custom_bottom_nav_bar.dart` (Profile tab index 4) |
| `PrimaryButton` | **REUSE** | `lib/shared/widgets/primary_button.dart` (Order History CTA in Screen 64) |
| `MetaPill` | **REUSE** | `lib/shared/widgets/meta_pill.dart` (My Orders tabs, category spending legend pills) |
| `ProductItemRow` | **REUSE** | `lib/shared/widgets/product_item_row.dart` (Recently viewed horizontal list items) |
| `NoDataFoundWidget` | **REUSE** | `lib/shared/widgets/no_data_found_widget.dart` (Empty states for vouchers/recently viewed) |
| `VerifiedCheckBadge` | **REUSE** | `lib/shared/widgets/verified_check_badge.dart` (Earned badge checkmarks on Screen 84) |
| `ProfileHeader` | **NEW** | Composite header: avatar + "My Activity" button + 3 circular utility buttons (Scan, Menu, Settings). No existing header has this layout. |
| `AnnouncementCard` | **NEW** | Specialized card supporting 3 distinct Figma announcement variants with custom badges and action triggers. |
| `RecentlyViewedHorizontalList` | **NEW** | Horizontal scroll container hosting compact recently viewed items. |
| `MyOrdersTabs` | **NEW** | Order filter row with status badge dot on "To Recieve" and navigation to `/orders?tab=...`. |
| `StoriesSection` | **NEW** | Horizontal creator story cards with red "Live" badge and play icon overlay. |
| `DonutChart` | **NEW** | Native 4-segment canvas-drawn financial donut chart with centered total. |
| `CategoryLegendPills` | **NEW** | 2x2 grid container formatting category spending pills using `MetaPill`. |
| `OrderStatsCircles` | **NEW** | Row of 3 circular stat badges ("Ordered", "Recieved", "To Recieve"). |
| `MonthSelector` | **NEW** | Pill container with month text and month navigation buttons. |
| `VoucherCard` | **NEW** | Ticket-shaped card with concave side notches, dashed separator, and expiring alert styling. |
| `RewardMilestoneCard` | **NEW** | 2-column grid item with milestone badge, checkmark, and criteria description. |
| `RewardsTabs` | **NEW** | Dual toggle pill row for switching between Active Rewards and Progress. |

---

### 7. Design Tokens to Add to `AppColors`

All tokens must be added to `lib/core/theme/app_colors.dart` before widget implementation:

```dart
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
```

