# Implementation Plan: Wishlist & Recently Viewed (Screens 38–41)

**Branch**: `feat/wishlist-recently-viewed` | **Date**: 2026-09-29 | **Spec**: [specs/011-wishlist/spec.md](spec.md)

**Input**: Feature specification from `specs/011-wishlist/spec.md`

---

## Summary

The Wishlist feature provides:
1. **Wishlist (Screen 38 & 38-Empty)**: Vertical list of saved products with delete and add-to-cart actions, dynamic transition to an empty state with a "Most Popular" horizontal recommendations carousel upon clearing all items.
2. **Recently Viewed (Screens 39, 40, 41)**: 2-column grid of viewed products (`ShopProductCard`) with interactive date filtering (Today, Yesterday) and an expandable inline calendar date picker allowing users to select past dates (e.g., April 18) to filter their viewing history.

The implementation strictly follows Feature-First Clean Architecture, the project Constitution, Rule #11 (Strict Design Tokens), Rule #12 (FVM-Only commands), and an aggressive DRY reuse strategy that extracts and shares widgets between Cart, Wishlist, and Shop.

---

## Technical Context

**Language/Version**: Dart 3.5.4 (Flutter 3.44.6 via FVM)  
**Primary Dependencies**: `flutter_bloc`, `go_router`, `flutter_screenutil`, `get_it`, `dartz`, `equatable`, `shimmer`  
**Storage**: In-memory mock data source (`WishlistMockDataSourceImpl`)  
**Testing**: `flutter_test` (unit & widget tests)  
**Target Platform**: Android, iOS  
**Project Type**: Mobile Application  
**Performance Goals**: Instant tab switching (< 200ms), 60 fps smooth inline calendar expansion/collapse  
**Constraints**: Zero hardcoded colors/dimensions (Rule #11), FVM CLI only (Rule #12), no analysis/testing until final phase  
**Scale/Scope**: 4 visual screens, 2 Cubits, 5 UseCases, 1 standalone feature module  

---

## Constitution & Rule Compliance Check

| Rule | Requirement | Compliance Plan |
|---|---|---|
| Rule 1 | Verification Timing | No `analyze` or `test` runs until final task of implementation |
| Rule 2 | Asset Policy | Reuses existing images in `assets/images/`; no placeholder asset generation |
| Rule 3 | Architectural Adherence | Feature-First Clean Architecture (`domain/`, `data/`, `presentation/`, `di/`) |
| Rule 4 | Code Quality & Design Patterns | UseCases with `Either<Failure, T>`, `safeCall` in repository, Cubits with `Equatable` states |
| Rule 5 | Dimensions & Frameworks | ScreenUtil (`.w`, `.h`, `.r`, `.sp`), `go_router` for navigation, `flutter_bloc` |
| Rule 6 | Component Reuse (DRY) | Extract `ProductItemRow` & `MetaPill` to `lib/shared/widgets/`; reuse `ShopProductCard`, `MostPopularSection`, `PopularProductCard` |
| Rule 7 | Clean Architecture Layers | Complete Domain, Data, Presentation layers with DI registration |
| Rule 8 | Phase 1 Data Scope | Mock data source with 5 wishlist items and 8 recently viewed items |
| Rule 9 | Loading Experience | Shimmer placeholders for wishlist and recently viewed grids |
| Rule 10 | Visual Perfection | 1:1 match with Figma references (`38`, `38_EMPTY`, `39`, `40`, `41`) |
| Rule 11 | Strict Token Enforcement | 100% tokens from `AppColors`, `AppSpacing`, `AppTypography` |
| Rule 12 | FVM-Only CLI Commands | Always use `fvm flutter` for all verification and build commands |

---

## Component Reuse & Shared Widget Extraction Plan

### 1. Extract `ProductItemRow` (`lib/shared/widgets/product_item_row.dart`)
- **Origin**: `lib/features/cart/presentation/widgets/cart_item_card.dart`
- **Target**: `lib/shared/widgets/product_item_row.dart`
- **Features Served**:
  - `feature/cart` (CartItemCard provides `QuantityControl` as trailing action)
  - `feature/wishlist` (WishlistItemRow provides `AddToCartIconButton` as trailing action)
- **Visual Spec**:
  - 90.w × 90.w rounded image (12.r) with `color: AppColors.surfaceCardImage`
  - Bottom-left circular delete button (`Icons.delete_outline`, `AppColors.error`)
  - 2-line title in `AppTypography.bodyMedium`
  - Meta pills row (`MetaPill`)
  - Bold price
  - Customizable `trailingAction` widget

### 2. Extract `MetaPill` (`lib/shared/widgets/meta_pill.dart`)
- **Origin**: Cart and Product details meta information
- **Target**: `lib/shared/widgets/meta_pill.dart`
- **Visual Spec**:
  - Background: `AppColors.primarySoft` (`0xFFE6EEFF`)
  - Padding: `horizontal: 10.w, vertical: 4.h`
  - Border radius: `8.r`
  - Text: `AppColors.primary`, font size `12.sp`, font weight `FontWeight.w500`

### 3. Reuse `ShopProductCard`
- **Location**: `lib/features/shop/presentation/widgets/shop_product_card.dart`
- **Usage**: Directly reused in the 2-column grid on Screens 39, 40, and 41 without modification.

### 4. Reuse `MostPopularSection` & `PopularProductCard`
- **Location**: `lib/features/home/presentation/widgets/most_popular_section.dart` & `popular_product_card.dart`
- **Usage**: Directly reused in `WishlistEmptyView` on Screen 38 Empty.

---

## Project Structure & Planned Files

```text
lib/
├── shared/
│   └── widgets/
│       ├── product_item_row.dart               [CREATE: Shared product row layout]
│       └── meta_pill.dart                      [CREATE: Reusable pill chip]
│
├── features/
│   ├── cart/
│   │   └── presentation/widgets/
│   │       └── cart_item_card.dart             [MODIFY: Refactor to wrap ProductItemRow]
│   │
│   └── wishlist/
│       ├── wishlist_injection.dart             [CREATE: Feature DI container]
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── wishlist_item_entity.dart   [CREATE: Wishlist item entity]
│       │   │   ├── recently_viewed_item_entity.dart [CREATE: Recently viewed entity]
│       │   │   └── date_tab_entity.dart        [CREATE: Date tab filter entity]
│       │   ├── repositories/
│       │   │   └── wishlist_repository.dart    [CREATE: Repository contract]
│       │   └── usecases/
│       │       ├── get_wishlist_usecase.dart   [CREATE: Fetch wishlist]
│       │       ├── remove_from_wishlist_usecase.dart [CREATE: Delete from wishlist]
│       │       ├── add_to_cart_from_wishlist_usecase.dart [CREATE: Add to cart]
│       │       ├── get_recently_viewed_usecase.dart [CREATE: Fetch recently viewed]
│       │       └── get_wishlist_popular_products_usecase.dart [CREATE: Fetch recommendations]
│       │
│       ├── data/
│       │   ├── models/
│       │   │   ├── wishlist_item_model.dart    [CREATE: Wishlist item data model]
│       │   │   ├── recently_viewed_item_model.dart [CREATE: Recently viewed model]
│       │   │   └── date_tab_model.dart         [CREATE: Date tab model]
│       │   ├── datasources/
│       │   │   ├── wishlist_mock_datasource.dart [CREATE: Data source contract]
│       │   │   └── wishlist_mock_datasource_impl.dart [CREATE: Mock implementation]
│       │   └── repositories/
│       │       └── wishlist_repository_impl.dart [CREATE: Repository implementation with safeCall]
│       │
│       └── presentation/
│           ├── cubit/
│           │   ├── wishlist_cubit.dart         [CREATE: Wishlist state management]
│           │   ├── wishlist_state.dart         [CREATE: Wishlist states]
│           │   ├── recently_viewed_cubit.dart  [CREATE: Recently viewed state management]
│           │   └── recently_viewed_state.dart  [CREATE: Recently viewed states]
│           ├── pages/
│           │   ├── wishlist_page.dart          [MODIFY: Replace placeholder with full Screen 38]
│           │   └── recently_viewed_page.dart   [CREATE: Screens 39, 40, 41 unified page]
│           └── widgets/
│               ├── wishlist_header.dart        [CREATE: "Wishlist" title + close '✕']
│               ├── wishlist_item_row.dart      [CREATE: Wishlist item card using ProductItemRow]
│               ├── wishlist_empty_view.dart    [CREATE: Empty state + Most Popular carousel]
│               ├── wishlist_shimmer_loading.dart [CREATE: Wishlist loading skeleton]
│               ├── recently_viewed_header.dart [CREATE: "Recently viewed" title + close '✕']
│               ├── recently_viewed_date_tabs.dart [CREATE: Today / Yesterday / Custom tabs]
│               ├── recently_viewed_calendar.dart [CREATE: Inline expandable calendar widget]
│               └── recently_viewed_shimmer_loading.dart [CREATE: Grid loading skeleton]
```

---

## Detailed Implementation Breakdown

### Phase 1: Shared Widget Extractions (DRY Foundation)
1. **`MetaPill`**: Extract into `lib/shared/widgets/meta_pill.dart` (`AppColors.primarySoft`, `AppColors.primary`, `8.r`).
2. **`ProductItemRow`**: Extract common layout into `lib/shared/widgets/product_item_row.dart` with image, trash icon, title, meta pills, price, and `trailingAction`.
3. **Refactor `CartItemCard`**: Verify `CartItemCard` delegates to `ProductItemRow` without breaking existing cart tests.

### Phase 2: Domain Layer
1. Create `WishlistItemEntity`, `RecentlyViewedItemEntity`, and `DateTabEntity`.
2. Define `WishlistRepository` contract.
3. Implement 5 UseCases:
   - `GetWishlistUseCase`
   - `RemoveFromWishlistUseCase`
   - `AddToCartFromWishlistUseCase`
   - `GetRecentlyViewedUseCase`
   - `GetWishlistPopularProductsUseCase`

### Phase 3: Data Layer
1. Create models (`WishlistItemModel`, `RecentlyViewedItemModel`, `DateTabModel`).
2. Implement `WishlistMockDataSource` and `WishlistMockDataSourceImpl` with:
   - 5 wishlist items with real product images (`prod_20_1.png`, etc.)
   - 8 recently viewed items across Today, Yesterday, and April 18
   - Popular products for empty wishlist
3. Implement `WishlistRepositoryImpl` wrapping data calls with `safeCall`.

### Phase 4: Dependency Injection & Routing
1. Create `lib/features/wishlist/wishlist_injection.dart` registering DataSources, Repository, UseCases, and Cubits.
2. Hook `initWishlistInjection()` into `lib/core/di/injection_container.dart`.
3. Register routes in `lib/config/routing/route_names.dart` and `app_router.dart`:
   - `/wishlist` -> `WishlistPage` (Tab index 1 in `StatefulShellBranch`)
   - `/wishlist/recently-viewed` -> `RecentlyViewedPage`

### Phase 5: Presentation Layer — Wishlist (Screen 38 & Empty State)
1. Implement `WishlistCubit` and `WishlistState`.
2. Build `WishlistHeader` with title and circular `✕` button.
3. Build `WishlistItemRow` using `ProductItemRow` with blue cart icon.
4. Build `WishlistEmptyView` using circular heart icon badge and `MostPopularSection`.
5. Build `WishlistShimmerLoading`.
6. Update `WishlistPage` with `BlocBuilder` switching between Loaded list, Empty view, and Shimmer.

### Phase 6: Presentation Layer — Recently Viewed & Calendar (Screens 39, 40, 41)
1. Implement `RecentlyViewedCubit` and `RecentlyViewedState`.
2. Build `RecentlyViewedHeader` with title and circular `✕` button.
3. Build `RecentlyViewedDateTabs` displaying active tab with soft blue fill & checkmark, and blue `∨` chevron button.
4. Build `RecentlyViewedCalendar` inline card with month navigation, 7-column day pills, selected day highlight, and `^` collapse button.
5. Build `RecentlyViewedShimmerLoading` for 2-column grid.
6. Assemble `RecentlyViewedPage` connecting `RecentlyViewedCubit` to the header, date tabs, inline calendar, and 2-column `ShopProductCard` grid.

### Phase 7: Verification & Testing (Final Phase Only)
1. Write widget tests in `test/features/wishlist/presentation/wishlist_page_test.dart` and `recently_viewed_page_test.dart`.
2. Run `dart format lib test`.
3. Run `fvm flutter analyze` (must be 0 issues).
4. Run `fvm flutter test` (all tests must pass with 100% green).
