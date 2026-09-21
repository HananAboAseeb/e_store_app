# Implementation Plan: Product Feature (Screens 34, 35, 36, 37)

**Branch**: `feature/product` | **Date**: 2026-09-17 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `specs/007-product/spec.md` and Figma reference screenshots `34_PRODUCT_DETAILS.png` (Product Details Full), `35_PRODUCT_DETAILS_SCROLLED.png` (Product Details Scrolled with Flash Sale Banner + Countdown), `36_PRODUCT_DETAILS_COMPACT.png` (Product Details Compact/Initial View), and `37_REVIEWS.png` (All Reviews).

---

## Summary

Implement the **Product** feature providing the complete product details and reviews experience:
1. **Screens 34 & 36 (Product Details)**: Image gallery with swipe pagination and dot indicators, breadcrumb trail with wishlist toggle and share, title, rating summary (`4.7` with comment pill), color variant selector (Red, Purple, Green thumbnails with blue active border), expandable size selector pill, specifications pills, delivery tiers (Standard & Express), 5-star ratings breakdown, reviews preview (2 cards with "View All 2986 Reviews" button), "Most Popular" horizontal carousel, "You Might Like" 2-column grid, and a sticky bottom purchase bar.
2. **Screen 35 (Product Details with Flash Sale)**: Promotional red banner (`#FF3B30`) inserted between gallery and breadcrumb displaying discounted price (`$17,00`), strikethrough original price (`$24,00`), `-20%` badge, and live countdown timer (`HH:MM:SS`) ticking down every second. When the timer expires, the banner collapses and prices revert.
3. **Screen 37 (All Reviews)**: Dedicated reviews view featuring circular dismiss button (`✕`), scrollable list of review cards with author avatars, star ratings, review narratives, interactive like/dislike reactions, and relative dates.

The implementation strictly follows Feature-First Clean Architecture (`lib/features/product/`), Cubit state management with Equatable, GetIt DI, and `go_router`.

---

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x  
**Primary Dependencies**: `flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`  
**Storage**: Mock Data with in-memory state and simulated latency (Phase 1 UI-only)  
**Testing & Verification**: Static analysis and tests strictly deferred to final phase per Permanent Rule 1  
**Target Platform**: iOS & Android  
**Design Reference**: Figma screenshots 34, 35, 36, 37 in `assets/design_references/`  
**Performance Goals**: 60 FPS smooth scrolling and gallery pagination, synchronous 1-second countdown ticks with zero frame drops, <200ms route transitions  

---

## Constitution Check

| Principle / Rule | Requirement | Compliance Status |
|---|---|---|
| **I. Architecture Preservation** | Follow `lib/features/`, `lib/core/`, `lib/config/` structure | ✅ PASS: Creates `lib/features/product/` matching canonical architecture |
| **II. Clean Architecture & Safety** | Decoupled domain, `Either<Failure, T>` via `dartz`, `safeCall` in repo impl | ✅ PASS: Complete layer separation and error wrapping |
| **III. Design Tokens & Pixel Perfection** | `AppColors`, `AppSpacing`, `AppTypography`, `flutter_screenutil` dimensions | ✅ PASS: 100% token usage and `.w, .h, .r, .sp` scaling |
| **IV. Strict UI & State Separation** | Cubit state management, Equatable states, shimmer loading | ✅ PASS: `ProductDetailsCubit` and `ReviewsCubit`, immutable states, shimmer loading |
| **V. Router & Shell Navigation** | Registered in `go_router`, clean push/pop | ✅ PASS: `/product/:id` and `/product/:id/reviews` registered in `app_router.dart` |
| **Permanent Rules 1–10** | Deferred verification, no new assets, mock data only, widget reuse (`ShopProductCard`, `DiscountBadge`, `PrimaryButton`) | ✅ PASS: Reuses existing assets and components without duplication |

---

## Project Structure

### Documentation Artifacts
```text
specs/007-product/
├── spec.md                  # Feature specification
├── plan.md                  # Implementation plan (this file)
├── research.md              # Technical decisions (timer, reviews separation, etc.)
├── data-model.md            # Domain entities, models, and UI states
├── quickstart.md            # Validation scenarios and testing guide
├── contracts/
│   └── product_contracts.md # Repository, UseCase, DataSource, and Cubit contracts
└── checklists/
    └── requirements.md      # Specification quality checklist
```

### Source Code (`lib/features/product/`)
```text
lib/features/product/
├── product_injection.dart
├── data/
│   ├── datasources/
│   │   ├── product_mock_datasource.dart
│   │   └── product_mock_datasource_impl.dart
│   ├── models/
│   │   ├── delivery_option_model.dart
│   │   ├── product_details_model.dart
│   │   ├── product_variant_model.dart
│   │   ├── rating_breakdown_model.dart
│   │   ├── review_model.dart
│   │   └── specification_model.dart
│   └── repositories/
│       └── product_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── delivery_option_entity.dart
│   │   ├── product_details_entity.dart
│   │   ├── product_variant_entity.dart
│   │   ├── rating_breakdown_entity.dart
│   │   ├── review_entity.dart
│   │   └── specification_entity.dart
│   ├── repositories/
│   │   └── product_repository.dart
│   └── usecases/
│       ├── get_product_details_usecase.dart
│       ├── get_product_reviews_usecase.dart
│       └── vote_review_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── product_details_cubit.dart
    │   ├── product_details_state.dart
    │   ├── reviews_cubit.dart
    │   └── reviews_state.dart
    ├── pages/
    │   ├── product_details_page.dart   # Screens 34, 35, 36
    │   └── reviews_page.dart           # Screen 37
    └── widgets/
        ├── flash_sale_banner.dart
        ├── product_bottom_bar.dart
        ├── product_breadcrumb.dart
        ├── product_color_selector.dart
        ├── product_delivery_section.dart
        ├── product_image_gallery.dart
        ├── product_most_popular_carousel.dart
        ├── product_rating_row.dart
        ├── product_ratings_breakdown.dart
        ├── product_reviews_preview.dart
        ├── product_shimmer_loading.dart
        ├── product_size_selector.dart
        ├── product_specifications_section.dart
        ├── product_you_might_like_grid.dart
        └── review_card.dart
```

---

## Core Technical Decisions

### 1. Countdown Timer Mechanism (Screen 35)
- Managed via `StreamSubscription<int>? _timerSubscription` inside `ProductDetailsCubit`.
- Emits every second: decrements `remainingSeconds`.
- When `remainingSeconds <= 0`, cancels subscription, sets `isFlashSaleActive = false`, and reverts prices atomically.
- Properly canceled in `ProductDetailsCubit.close()`.

### 2. Reviews Cubit Separation (Screen 37)
- `ReviewsCubit` handles reviews loading, pagination, and optimistic like/dislike voting independently of `ProductDetailsCubit`.
- Prevents unnecessary full-page rebuilds of the product details page when interacting with reviews.

### 3. Screen 36 & Screen 34 Unification
- Screen 36 is the initial un-scrolled viewport of Screen 34. Both are rendered seamlessly by `ProductDetailsPage` using a single `CustomScrollView`.

### 4. Component Reuse
- `ShopProductCard` from `feature/shop` reused for "You Might Like" 2-column grid.
- `DiscountBadge` reused for percentage badges.
- `PrimaryButton` reused for action triggers.

---

## Routing & DI Integration

- **Route Registration** (`lib/config/routing/`):
  - Add `kProductDetailsPage = '/product/:id'` and `kProductReviewsPage = '/product/:id/reviews'` in `route_names.dart`.
  - Add routes in `app_router.dart`.
- **DI Registration** (`lib/core/di/injection_container.dart`):
  - Register `initProductInjection()` in `injection_container.dart`.
