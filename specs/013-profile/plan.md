# Implementation Plan: User Profile, Activity Dashboard & Rewards Center

**Branch**: `013-profile` | **Date**: 2026-11-01 | **Spec**: [specs/013-profile/spec.md](spec.md)

**Input**: Feature specification from `specs/013-profile/spec.md` covering Screens 62, 64, 81, 82, 83, 84, 85.

---

## Summary

The Profile feature provides a comprehensive account, activity, and loyalty hub:
1. **Profile Home (Screens 62, 81, 85)**: Main profile screen with avatar, greeting ("Hello, Romina!"), dynamic announcement cards (regular, reward earned, voucher expiring), recently viewed products, order status pills ("To Pay", "To Recieve", "To Review"), and creator stories with "Live" badges.
2. **My Activity (Screen 64)**: Financial activity dashboard with month selector ("April"), a proportional 4-segment canvas-drawn donut chart with centered `$365,00` total, 4 category legend pills, 3 circular order statistics badges, and full-width "Order History" CTA.
3. **My Vouchers (Screens 82, 83)**: Active rewards list featuring ticket-shaped notched cards with dashed dividers, validity dates, and dynamic red warning styling ("3 days left") for expiring vouchers.
4. **Rewards Progress (Screen 84)**: Gamified achievement progress view featuring a 2x3 grid of milestone badges with earned completion checkmarks.

The implementation strictly follows Feature-First Clean Architecture, the project Constitution v1.2.0, Rule #11 (Strict Design Tokens), Rule #12 (FVM-Only CLI), and DRY component reuse.

---

## Technical Context

**Language/Version**: Dart 3.5.4 (Flutter 3.44.6 via FVM)  
**Primary Dependencies**: `flutter_bloc`, `go_router`, `flutter_screenutil`, `get_it`, `dartz`, `equatable`, `shimmer`  
**Storage**: In-memory mock data source (`ProfileMockDataSourceImpl`)  
**Testing**: `flutter_test` (unit & widget tests in `test/features/profile/`)  
**Target Platform**: Android, iOS  
**Project Type**: Mobile Application Feature Module  
**Performance Goals**: Instant tab switching (< 100ms), 60 fps smooth donut chart rendering, zero layout jank  
**Constraints**: Zero hardcoded colors/dimensions (Rule #11), FVM CLI only (Rule #12), no analysis/testing until final phase (Rule #1), zero new asset generation (Rule #2)  
**Scale/Scope**: 7 design reference screens, 3 Cubits, 7 UseCases, 1 standalone feature module  

---

## Constitution & Rule Compliance Check

| Rule | Requirement | Compliance Plan |
|---|---|---|
| Rule 1 | Verification Timing | Save static analysis strictly for the final phase (`fvm flutter analyze` at completion) |
| Rule 2 | Asset Policy | Reuse existing assets from `assets/images/` and `assets/design_references/`; 0 new assets generated |
| Rule 3 | Architectural Adherence | Feature-First Clean Architecture (`domain/`, `data/`, `presentation/`, `di/`) |
| Rule 4 | Code Quality & Design Patterns | UseCases with `Either<Failure, T>`, `safeCall` in repository, Cubits with `Equatable` states |
| Rule 5 | Dimensions & Frameworks | ScreenUtil (`.w`, `.h`, `.r`, `.sp`), `go_router` for navigation, `flutter_bloc` |
| Rule 6 | Component Reuse (DRY) | Reuse `CustomBottomNavBar`, `PrimaryButton`, `MetaPill`, `ProductItemRow`, `NoDataFoundWidget`, `VerifiedCheckBadge` |
| Rule 7 | Clean Architecture Layers | Complete Domain, Data, Presentation layers with DI registration and routing |
| Rule 8 | Phase 1 Data Scope | Mock data source with 1 user, 3 announcements, 5 recently viewed products, 3 vouchers, 6 rewards, 1 activity summary |
| Rule 9 | Loading Experience | Shimmer placeholders for profile home, activity summary, and rewards views |
| Rule 10 | Visual Perfection | Pixel-perfect 1:1 match with Figma references (`62`, `64`, `81`, `82`, `83`, `84`, `85`) |
| Rule 11 | Strict Token Enforcement | 100% tokens from `AppColors`, `AppSpacing`, `AppTypography`. Add missing tokens to `app_colors.dart` FIRST |
| Rule 12 | FVM-Only CLI Commands | Always use `fvm flutter` for all verification and build commands |

---

## Component Reuse & DRY Strategy

### Existing Widgets to Reuse:
1. **`CustomBottomNavBar`** (`lib/shared/navigation/custom_bottom_nav_bar.dart`): Persistent bottom navigation shell; Profile tab (index 4) actively highlighted.
2. **`PrimaryButton`** (`lib/shared/widgets/primary_button.dart`): Reused for "Order History" CTA in My Activity (Screen 64).
3. **`MetaPill`** (`lib/shared/widgets/meta_pill.dart`): Reused for:
   - Order tabs ("To Pay", "To Recieve", "To Review")
   - Category spending legend pills in My Activity ("Clothing $183,00", etc.)
4. **`ProductItemRow`** (`lib/shared/widgets/product_item_row.dart`): Reused for Recently viewed items horizontal presentation.
5. **`NoDataFoundWidget`** (`lib/shared/widgets/no_data_found_widget.dart`): Reused for empty voucher or activity states.
6. **`VerifiedCheckBadge`** (`lib/shared/widgets/verified_check_badge.dart`): Reused for earned milestone checkmarks on Screen 84.

### Justification for New Feature Widgets:
- **`ProfileHeader`**: Composite row combining user avatar (~44x44), blue pill `My Activity` button, and 3 circular utility buttons (Scan, Menu, Settings). No existing header has this composite composition.
- **`AnnouncementCard`**: Specialized banner supporting 3 Figma states (regular, reward, voucher expiring) with custom icon badges and background color transitions.
- **`RecentlyViewedHorizontalList`**: Horizontal scrolling container hosting compact square preview cards of recently viewed items.
- **`MyOrdersTabs`**: Horizontal order status filter tabs with notification dot badge on "To Recieve" and navigation to `/orders?tab=<tab>`.
- **`StoriesSection`**: Horizontal creator stories carousel with red "Live" badge and play overlay.
- **`DonutChart`**: Custom canvas-drawn (`CustomPainter`) 4-segment proportional donut chart with centered text.
- **`CategoryLegendPills`**: 2x2 grid container formatting category spending pills using `MetaPill`.
- **`OrderStatsCircles`**: Row of 3 circular stat badges ("Ordered", "Recieved", "To Recieve").
- **`MonthSelector`**: Centered pill container with month text and circular previous/next navigation buttons.
- **`VoucherCard`**: Custom ticket-shaped card with concave side notches, dashed separator, and expiring alert styling.
- **`RewardMilestoneCard`**: 2-column grid item with milestone badge, checkmark, and criteria description.
- **`RewardsTabs`**: Dual toggle pill row for switching between Active Rewards and Progress.

---

## Technical Decisions

### 1. Unification of Screens 62, 81, and 85 (Profile Home)
- Unified into a single `ProfilePage` managed by `ProfileCubit`.
- State model contains `ProfileAnnouncementType { regular, rewardEarned, voucherExpiring }`.
- `AnnouncementCard` dynamically inspects the announcement type:
  - `regular`: Neutral background (`AppColors.surfaceCardImage`), "Announcement" title, circular blue right-arrow button.
  - `rewardEarned`: Neutral background, circular blue heart badge on left, "You just got a Reward" title.
  - `voucherExpiring`: Soft pink background (`AppColors.rewardBackground`), circular red shopping bag badge on left, "Your Voucher will expire in 3 days" title.
  - The notification dot on the `To Recieve` tab adapts color based on state (red dot in regular, green dot in reward/voucher).

### 2. Unification of Screens 82 and 83 (Active Vouchers)
- Unified into a single `VouchersTab` within `RewardsPage` managed by `RewardsCubit`.
- Each `VoucherEntity` has an `isExpiring: bool` and `daysLeft: int` field.
- If `isExpiring == true`, `VoucherCard` renders with `AppColors.voucherWarning` (red border), `AppColors.voucherWarningBg` (soft pink fill), red dashed divider, and `3 days left` red text. Otherwise, it renders standard blue border with coral "Valid Until" date.

### 3. Screen 84 (Rewards Progress) & Tab Navigation
- Unified into `RewardsPage` managed by `RewardsCubit` (enum `RewardsTab { activeRewards, progress }`).
- Switching between tabs updates state in memory instantly without redundant network calls.
- 2x3 grid displaying `RewardMilestoneEntity` items with badge icons and reusing `VerifiedCheckBadge`.

### 4. Donut Chart Implementation Approach (Screen 64 - My Activity)
- Implemented using Flutter's native `CustomPainter` (`canvas.drawArc`).
- Proportions are calculated directly from `CategorySpendingEntity.amount / totalAmount`:
  - Blue (`AppColors.chartBlue`): $183.00 / $365.00 = 50.1% -> ~180.5°
  - Green (`AppColors.chartGreen`): $92.00 / $365.00 = 25.2% -> ~90.7°
  - Orange (`AppColors.chartOrange`): $47.00 / $365.00 = 12.9% -> ~46.4°
  - Red (`AppColors.chartRed`): $43.00 / $365.00 = 11.8% -> ~42.4°
- Centered text renders "Total" in `AppTypography.caption` and `$365,00` in bold `AppTypography.h1`.

---

## Token Additions to `AppColors`

Add to `lib/core/theme/app_colors.dart` before widget implementation:

| Token Name | Hex Value | Purpose / Usage |
|---|---|---|
| `rewardBackground` | `0xFFFDECEE` | Soft pink background for voucher expiring announcement (Screen 85) |
| `voucherWarning` | `0xFFFF3B30` | Red border and alert text for expiring vouchers (Screen 83) |
| `voucherWarningBg` | `0xFFFFF0F2` | Soft pink background fill for expiring voucher ticket (Screen 83) |
| `voucherValidDate` | `0xFFFF6060` | Coral red text for voucher "Valid Until" date (Screen 82, 83) |
| `chartBlue` | `0xFF004BFE` | Blue segment in My Activity donut chart (Screen 64 - Clothing 50.1%) |
| `chartGreen` | `0xFF70B92B` | Green segment in My Activity donut chart (Screen 64 - Lingerie 25.2%) |
| `chartOrange` | `0xFFF48A25` | Orange segment in My Activity donut chart (Screen 64 - Shoes 12.9%) |
| `chartRed` | `0xFFE60049` | Red/Pink segment in My Activity donut chart (Screen 64 - Bags 11.8%) |
| `storyLiveRed` | `0xFFFF1744` | Red badge background for "Live" stories indicator (Screen 62, 81, 85) |
| `rewardIconBlue` | `0xFF004BFE` | Primary blue for reward progress icons and badges (Screen 84) |
| `tabInactiveBg` | `0xFFE8ECEF` | Light gray fill for inactive progress tab pill (Screen 82, 84) |

---

## Project Structure & Planned Files

```text
lib/
├── core/
│   └── theme/
│       └── app_colors.dart                                  [MODIFY: Add 11 new tokens]
│
├── config/
│   └── routing/
│       ├── route_names.dart                                 [MODIFY: Add kMyActivityPage, kRewardsPage]
│       └── app_router.dart                                  [MODIFY: Register /profile/my-activity and /profile/rewards]
│
└── features/
    └── profile/
        ├── profile_injection.dart                           [MODIFY: Register Cubits, UseCases, Repository, MockDataSource]
        │
        ├── domain/
        │   ├── entities/
        │   │   ├── user_profile_entity.dart                 [CREATE: User profile entity]
        │   │   ├── announcement_entity.dart                 [CREATE: Announcement entity with type enum]
        │   │   ├── recently_viewed_item_entity.dart         [CREATE: Recently viewed entity]
        │   │   ├── order_stats_entity.dart                  [CREATE: Order counts entity]
        │   │   ├── category_spending_entity.dart            [CREATE: Category spending entity]
        │   │   ├── activity_summary_entity.dart             [CREATE: Monthly spending summary entity]
        │   │   ├── voucher_entity.dart                      [CREATE: Voucher entity with expiring flag]
        │   │   ├── reward_milestone_entity.dart             [CREATE: Gamified reward entity]
        │   │   └── story_entity.dart                        [CREATE: Creator story entity]
        │   │
        │   ├── repositories/
        │   │   └── profile_repository.dart                  [MODIFY: Declare repository methods]
        │   │
        │   └── usecases/
        │       ├── get_user_profile_usecase.dart            [CREATE]
        │       ├── get_announcement_usecase.dart            [CREATE]
        │       ├── get_recently_viewed_usecase.dart         [CREATE]
        │       ├── get_stories_usecase.dart                 [CREATE]
        │       ├── get_activity_summary_usecase.dart        [CREATE]
        │       ├── get_vouchers_usecase.dart                [CREATE]
        │       └── get_rewards_usecase.dart                 [CREATE]
        │
        ├── data/
        │   ├── datasources/
        │   │   ├── profile_mock_data_source.dart            [CREATE: Mock data contract]
        │   │   └── profile_mock_data_source_impl.dart       [CREATE: Mock data provider with all 7 screens' data]
        │   │
        │   ├── models/
        │   │   ├── user_profile_model.dart                  [CREATE]
        │   │   ├── announcement_model.dart                  [CREATE]
        │   │   ├── recently_viewed_item_model.dart          [CREATE]
        │   │   ├── order_stats_model.dart                   [CREATE]
        │   │   ├── category_spending_model.dart             [CREATE]
        │   │   ├── activity_summary_model.dart              [CREATE]
        │   │   ├── voucher_model.dart                       [CREATE]
        │   │   ├── reward_milestone_model.dart              [CREATE]
        │   │   └── story_model.dart                         [CREATE]
        │   │
        │   └── repositories/
        │       └── profile_repository_impl.dart             [MODIFY: Implement repository with safeCall]
        │
        └── presentation/
            ├── manager/
            │   ├── profile/
            │   │   ├── profile_cubit.dart                   [MODIFY: State management for ProfilePage]
            │   │   └── profile_state.dart                   [MODIFY: Equatable states]
            │   ├── my_activity/
            │   │   ├── my_activity_cubit.dart               [CREATE: State management for MyActivityPage]
            │   │   └── my_activity_state.dart               [CREATE: Equatable states]
            │   └── rewards/
            │       ├── rewards_cubit.dart                   [CREATE: State management for RewardsPage]
            │       └── rewards_state.dart                   [CREATE: Equatable states]
            │
            ├── pages/
            │   ├── profile_page.dart                        [MODIFY: Overhaul to Figma Screens 62, 81, 85]
            │   ├── my_activity_page.dart                    [CREATE: Figma Screen 64]
            │   └── rewards_page.dart                        [CREATE: Figma Screens 82, 83, 84]
            │
            └── widgets/
                ├── profile_header.dart                      [CREATE: Avatar + My Activity button + 3 circular icons]
                ├── announcement_card.dart                   [CREATE: Dynamic 3-state announcement banner]
                ├── recently_viewed_horizontal_list.dart     [CREATE: Horizontal carousel of viewed items]
                ├── my_orders_tabs.dart                      [CREATE: Post-purchase tabs row with indicator dot]
                ├── stories_section.dart                     [CREATE: Horizontal creator story cards]
                ├── donut_chart.dart                         [CREATE: Native custom-painted 4-segment donut chart]
                ├── category_legend_pills.dart               [CREATE: 2x2 grid of category spending pills]
                ├── order_stats_circles.dart                 [CREATE: 3 circular order stat badges]
                ├── month_selector.dart                      [CREATE: Centered month pill with arrow buttons]
                ├── voucher_card.dart                        [CREATE: Ticket notched card with expiring variant]
                ├── reward_milestone_card.dart               [CREATE: 2-column achievement grid item]
                └── rewards_tabs.dart                        [CREATE: Active Rewards / Progress toggle tabs]
```

---

## Complexity Tracking

No constitution violations. All architecture adheres to Feature-First Clean Architecture, strict design token enforcement, and DRY component reuse.

---

## Permanent Project Rules Reference

All plans MUST strictly incorporate and reflect the Permanent Project Rules from `.specify/memory/constitution.md`:
1. **Verification Timing**: Do NOT run `flutter analyze` or `flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (.w, .h, .r, .sp). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PrimaryButton, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
11. **STRICT COLOR & TOKEN ENFORCEMENT**: All colors, spacing, and typography must reference tokens from `AppColors`, `AppSpacing`, and `AppTypography`. No hardcoded values are allowed. If a token is missing, add it to the tokens file first.
12. **FVM-ONLY CLI COMMANDS**: ALWAYS use `fvm flutter` (NOT bare `flutter`) for ALL Flutter CLI commands (`analyze`, `test`, `run`, `build`, `pub get`, etc.).
