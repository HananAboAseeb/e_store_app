# Phase 0 Research: Shop Feature (Screens 25, 26, 33)

## 1. Context & Objectives
The Shop Feature provides the primary catalog browsing experience within the clothing category and sub-categories, a 2-column product grid with regular and discount pricing, and a multi-faceted filter screen.

This document resolves architectural decisions, reuse choices, and patterns aligned with the project constitution.

---

## 2. Technical Decisions & Research

### Decision 1: Feature Modular Structure
- **Decision**: Create `lib/features/shop/` using Clean Architecture (`presentation/` → `domain/` ← `data/`) with a dedicated injection file `shop_injection.dart`.
- **Rationale**: Strict compliance with Principle II (Feature-First Clean Architecture) of the E-Store Constitution. Follows the pattern established by `lib/features/home/` and `lib/features/flash_sale/`.

### Decision 2: Sub-Category Layout vs Design Reference
- **Decision**: Implement a 2-row category grid (5 items on row 1, 4 items on row 2) as shown in Figma Screen 25 (`assets/design_references/25SHOP — CLOTHING.png`), rather than a single horizontal text tab bar.
- **Rationale**: The Figma screenshot is the authoritative design reference. Each item displays a rounded grey background container (`16.r`), high-fidelity apparel illustration, and category label.
- The top app bar features the active category pill `[Clothing ✕]`, camera icon, and gear filter icon (`⚙`).

### Decision 3: Product Card Pricing & Discount Presentation
- **Decision**: Build `ShopProductCard` supporting both single full-price display (`$16,00`) and sale price with coral red strike-through original price (`$16,00 $20,00`).
- **Rationale**: Matches Figma Screens 25 and 26. Screen 25 displays regular-price items, while Screen 26 reveals discounted items on scroll with strike-through pricing.

### Decision 4: Filter Modal Architecture (Screen 33)
- **Decision**: Present Screen 33 as a custom modal bottom sheet (`FilterModalSheet`) with its own state controller (`FilterCubit`).
- **Rationale**: Using a dedicated `FilterCubit` keeps temporary, uncommitted filter edits completely isolated from the main `ShopCubit` state until the user explicitly taps `Apply`. Tapping `✕` or closing the sheet safely cancels pending edits without affecting the Shop screen.

### Decision 5: Shell Routing & Navigation
- **Decision**: Wire `ShopPage` to `RouteNames.kCatalogPage` (`/catalog`) inside `StatefulShellRoute.indexedStack`.
- **Rationale**: Maintains the persistent 5-tab bottom navigation bar (`CustomBottomNavBar`) where the 3rd tab corresponds to the catalog/shop browsing experience.
