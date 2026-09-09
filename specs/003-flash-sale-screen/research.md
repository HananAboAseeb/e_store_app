# Phase 0 Research: Flash Sale Screen Feature

## 1. Context & Objectives
The Flash Sale Screen is a dedicated shopping page displaying discounted items organized by discount tier (All, 10%, 20%, 30%, 40%, 50%), a live countdown timer in the header with soft blue gradient aura, a live stream showcase ("ARTICALE REIMAGINED" / "LIVE"), a 2-column product grid with custom discount badges, a dual-tone promotional banner ("Big Sale Up to 50%"), and a horizontal "Most Popular" trending carousel.

This document resolves architectural decisions, reuse choices, and patterns aligned with the project constitution.

---

## 2. Technical Decisions & Research

### Decision 1: Feature Modular Structure
- **Decision**: Create `lib/features/flash_sale/` using Clean Architecture (presentation → domain ← data) with dedicated injection file `flash_sale_injection.dart`.
- **Rationale**: Strict compliance with Principle II (Feature-First Clean Architecture) of the E-Store Constitution. Follows the identical pattern established by `lib/features/home/`.
- **Alternatives Considered**: Housing it directly inside `features/home/` was considered since it's reachable from home, but rejected because it is a distinct screen/route with its own data models, filters, and Cubit state.

### Decision 2: Widget Reuse & Refactoring vs New Components
- **HomeSectionHeader**:
  - **Status**: **REUSE** (`lib/features/home/presentation/widgets/home_section_header.dart`).
  - **Rationale**: `HomeSectionHeader` already supports `title`, `leading`, `trailing`, and `onSeeAllTap` with the exact blue circle arrow icon. We can reuse it for "Most Popular" with `showSeeAll: true` and for "20% Discount" with a custom `trailing: Icon(Icons.settings_outlined)`.
- **FlashSaleTimer**:
  - **Status**: **REUSE / EXTEND**:
  - `FlashSaleTimer` already implements the 3 white box countdown timer (`[00] [36] [58]`) with stopwatch icon. We can reuse it directly in the Flash Sale AppBar or wrap it cleanly.
- **PopularProductCard**:
  - **Status**: **REUSE** (`lib/features/home/presentation/widgets/popular_product_card.dart`).
  - **Rationale**: The card layout in the Figma screenshot for "Most Popular" matches `PopularProductCard` exactly (112.w, likes count, blue heart icon, tag badge like 'New'/'Sale'/'Hot').
- **ProductCardStandard**:
  - **Status**: **MODIFY** or **EXTEND**:
  - `ProductCardStandard` in `features/home` currently takes `HomeProductEntity` with `price`, `imageUrl`, `title`, and `showNewBadge`.
  - In Flash Sale, the card requires:
    1. Red/pink gradient discount pill in top right corner (`-20%`).
    2. Strikethrough original price alongside current discounted price (e.g. `$16,00` bold black and `$20,00` crossed-out red/pink).
    3. Gray background with darkened blend mode.
  - **Decision**: Update `ProductCardStandard` with optional `originalPrice`, `discountBadge`, and configurable width/aspect ratio, OR create a specialized `FlashSaleProductCard` that shares styling tokens without risking regressions in Home. Creating `FlashSaleProductCard` in `lib/features/flash_sale/presentation/widgets/` gives 100% pixel fidelity while `ProductCardStandard` can either be updated or reused cleanly.
- **Big Sale Banner**:
  - In the Figma screenshot, the banner is a static split banner ("Big Sale", "Up to 50%", "Happening Now" on blue curved splash with model graphic on yellow gold).
  - In `features/home/presentation/widgets/home_hero_banner.dart`, it is a PageView carousel.
  - **Decision**: Create `FlashSalePromoBanner` (NEW) specifically for this static split-color promotional banner.
- **Live Stream Showcase Banner**:
  - **Status**: **NEW** (`FlashSaleLiveBanner`).
  - Contains multi-model imagery, translucent circular play button, lower title "ARTICALE REIMAGINED", and bright green "LIVE" badge.
- **Discount Filter Bar**:
  - **Status**: **NEW** (`DiscountFilterBar`).
  - Renders horizontal chips: All, 10%, 20%, 30%, 40%, 50% with custom active indicator pill styling.

### Decision 3: State Management & Cubit Architecture
- **Decision**: `FlashSaleCubit` managing `FlashSaleState` (`FlashSaleInitial`, `FlashSaleLoading`, `FlashSaleLoaded`, `FlashSaleError`).
- `FlashSaleLoaded` state will hold:
  - `allProducts`: Full list of products fetched from mock data source.
  - `filteredProducts`: Filtered list based on selected discount.
  - `selectedDiscount`: Int percentage (e.g. `20`) or `null` for "All".
  - `liveStream`: Live stream entity details.
  - `popularProducts`: List of popular products.
- **Filtering Logic**: Instant synchronous in-memory filtering when a tab is tapped, updating `selectedDiscount` and `filteredProducts` immediately. `loadProducts()` simulates a realistic 1.2s delay on initial load with shimmer placeholders.

### Decision 4: Routing & Shell Placement
- **Decision**: Mount `/flash-sale` as a standard `GoRoute` in `app_router.dart` inside the `StatefulShellRoute` (or root navigator depending on whether bottom nav remains visible).
- In the Figma screenshot, the persistent bottom navigation bar is clearly visible at the bottom of the Flash Sale screen. Therefore, `/flash-sale` should maintain the bottom navigation bar or provide root navigation with smooth transition.
- Register `RouteNames.kFlashSalePage = '/flash-sale'`.

---

## 3. Findings Summary
All patterns, colors, and layouts are verified against existing code and Figma screenshots. No external dependencies need to be added to `pubspec.yaml` (everything required is already installed: `flutter_screenutil`, `flutter_bloc`, `get_it`, `equatable`, `dartz`, `go_router`, `shimmer`).
