# Phase 0: Research & Technical Decisions — Wishlist & Recently Viewed

**Feature Directory**: `specs/011-wishlist`  
**Date**: 2026-09-29  
**Status**: Completed  

---

## 1. Technical Decisions

### Decision 1: Shared Product Row Extraction for Cart and Wishlist
- **Decision**: Extract the core layout from `lib/features/cart/presentation/widgets/cart_item_card.dart` into a reusable `ProductItemRow` widget in `lib/shared/widgets/product_item_row.dart`, and introduce `MetaPill` in `lib/shared/widgets/meta_pill.dart`.
- **Rationale**:
  - `CartItemCard` (Screen 44) and `WishlistItemRow` (Screen 38) share identical visual architecture:
    - 90.w × 90.w rounded image (12.r) with `color: AppColors.surfaceCardImage`
    - Circular white delete button at bottom-left (`Icons.delete_outline`, red color)
    - 2-line title in `AppTypography.bodyMedium` (`AppColors.textPrimary`)
    - Meta pills for color and size
    - Bold price text
  - By providing a customizable `trailingAction` builder, `CartItemCard` can render `QuantityControl`, while `WishlistItemCard` renders the blue `AddToCartIconButton`.
- **Alternatives Considered**:
  - *Duplicate widget inside wishlist*: Violates the strict DRY rule and Permanent Project Rule #6.
  - *Hardcode wishlist mode in CartItemCard with boolean flags*: Clutters Cart with Wishlist concerns. Clean extraction to `lib/shared/widgets/` preserves separation of concerns.

### Decision 2: Inline Expandable Calendar Implementation
- **Decision**: Build a custom inline `RecentlyViewedCalendar` widget in `lib/features/wishlist/presentation/widgets/recently_viewed_calendar.dart` rather than using `showDatePicker` dialog or third-party calendar packages.
- **Rationale**:
  - Screens 39, 40, and 41 show that the calendar is an inline expandable card that sits directly beneath the header and above the product grid, not a modal popup or full-page screen.
  - Figma shows custom visual styling:
    - Month selector `< April >` with circular navigation buttons
    - 7-column day grid (01 to 31) with 2-digit format
    - Unselected day pills with `AppColors.surfaceOption` and dark text
    - Selected day pill (e.g., `18`) with `AppColors.primarySoft` and `AppColors.primary` text
    - Floating bottom collapse button `^` inside a circular badge
  - Implementing this with pure Flutter primitives (`AnimatedCrossFade` or `AnimatedSize` with a custom day grid) provides pixel-perfect matching with zero external package bloat.
- **Alternatives Considered**:
  - *`showDatePicker()`*: Opens a material modal dialog which violates the Figma inline design.
  - *`table_calendar` package*: Adds an unvetted dependency, risking version conflicts and violating Rule #2.

### Decision 3: Date Tabs State Management & Dynamic Custom Dates
- **Decision**: Manage date tabs via `RecentlyViewedCubit` using a list of `DateTabEntity` objects:
  - Preset 0: `Today` (default active)
  - Preset 1: `Yesterday`
  - Dynamic tab: When a date (e.g., April 18) is selected from the calendar, a new `DateTabEntity(id: 'april-18', label: 'April, 18', date: ...)` is added or activated.
- **Rationale**:
  - Matches the exact UX flow shown across Screens 39, 40, and 41.
  - If the user re-opens the calendar and picks another date, the custom tab updates cleanly.
  - Tapping between "Today", "Yesterday", and "April, 18" instantly re-filters the displayed `ShopProductCard` grid without re-fetching from a server.

### Decision 4: Empty State & Most Popular Carousel Reuse
- **Decision**:
  - Reuse `EmptyCartState` pattern by creating a shared `AppEmptyStateWidget` in `lib/shared/widgets/app_empty_state_widget.dart` that accepts an icon or widget, title, and optional message.
  - Reuse `MostPopularSection` directly from `lib/features/home/presentation/widgets/most_popular_section.dart` and `PopularProductCard` from `lib/features/home/presentation/widgets/popular_product_card.dart`.
- **Rationale**:
  - In `38 WISHLIST - EMPTY.png`, the empty state circular badge with blue heart icon matches the cart's empty state geometry.
  - The "Most Popular" section with "See All →" and horizontal cards is identical to the one in `feature/home` and `feature/cart`.
  - Zero duplication: `WishlistEmptyView` composes these existing widgets.

### Decision 5: Shell Navigation & Dismissal Behavior
- **Decision**:
  - Wishlist is mounted at index 1 (`NavEnum.wishlist`) in `StatefulShellRoute`.
  - The `✕` button on Wishlist (Screen 38) and Recently Viewed (Screen 39) calls `context.pop()` if pushed, or navigates to Home (`context.go(RouteNames.kHomePage)`) if the user is at the root shell tab.
  - Route `/wishlist/recently-viewed` is registered as a sub-route or top-level route with `CustomBottomNavBar` persistent overlay or standalone page.

---

## 2. Token & Styling Audit (Rule #11)
- **Backgrounds**: `AppColors.background` (`0xFFF7F8FA`), `AppColors.surface` (`0xFFFFFFFF`), `AppColors.surfaceCardImage` (`0xFFF5F5F5`).
- **Chips & Pills**:
  - Inactive tab / day chip: `AppColors.surfaceOption` (`0xFFE6E6E6`) or `AppColors.surfaceAddress` (`0xFFF2F2F2`).
  - Active tab / selected day: `AppColors.primarySoft` (`0xFFE6EEFF`) with `AppColors.primary` (`0xFF004BFE`).
- **Icons & Badges**:
  - Trash can icon: `AppColors.error` (`0xFFFF3B30`).
  - Add to cart icon: `AppColors.primary` (`0xFF004BFE`).
  - Circular close `✕` button: `AppColors.surfaceOption` with `AppColors.textSecondary`.
- **Typography**:
  - Screen titles: `AppTypography.h1` / `AppTypography.h2` (Raleway / Bold).
  - Item titles: `AppTypography.bodyMedium` (w600).
  - Prices: `AppTypography.h3` (w700 / w800).
  - Pills: `AppTypography.caption` / `bodySmall` (w500).
- **Result**: All required colors, typography styles, and spacing units exist in `AppColors`, `AppTypography`, and `AppSpacing`. Zero new tokens required.
