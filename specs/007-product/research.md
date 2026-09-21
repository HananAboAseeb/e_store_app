# Research & Technical Decisions: Product Feature (Screens 34, 35, 36, 37)

**Feature**: `specs/007-product` | **Date**: 2026-09-17

This document establishes the technical decisions, patterns, and architectural trade-offs for the **Product** feature.

---

## 1. Reviews Sub-Module vs. Separate Feature

- **Decision**: Keep `reviews` inside `lib/features/product/` rather than creating a separate top-level feature module.
- **Rationale**:
  - Reviews are deeply coupled to the product entity (`productId`), loaded via the product route (`/product/:id/reviews`), and summarized directly on the product details page (rating score, total comment count, preview cards).
  - Creating a separate `feature/reviews` would introduce unnecessary cross-feature dependency cycles between product and reviews.
  - Reviews has its own dedicated Cubit (`ReviewsCubit`), repository methods, use case (`GetProductReviewsUseCase`), and presentation page (`ReviewsPage`), maintaining strict Single Responsibility while residing within `feature/product`.
- **Alternatives Considered**:
  - *Separate feature (`lib/features/reviews/`)*: Rejected due to circular domain dependencies and boilerplate overhead for Phase 1.
  - *Single monolithic Cubit (`ProductCubit`)*: Rejected because review pagination, voting (like/dislike), and review list scrolling should not trigger full product page rebuilds.

---

## 2. Flash Sale Countdown Timer & State Management

- **Decision**: Manage the countdown timer directly inside `ProductDetailsCubit` using a `StreamSubscription<int>` (`Stream.periodic(const Duration(seconds: 1))`).
- **Rationale**:
  - Screen 35 displays a live countdown timer (`HH:MM:SS`) in the red promotional banner between the image gallery and breadcrumb.
  - When the countdown expires (`remainingSeconds <= 0`), the promotion ends: the banner disappears, prices revert to non-discounted base prices, and the state updates smoothly.
  - Managing this timer within `ProductDetailsCubit` ensures atomic state synchronization between remaining time, banner visibility, and bottom bar price calculations without requiring complex inter-cubit communication (`BlocListener`).
  - Timer subscription is properly canceled in `ProductDetailsCubit.close()` to prevent memory leaks.
- **Alternatives Considered**:
  - *Separate `TimerCubit`*: Over-complicates state coordination when the timer expires, requiring `BlocListener` on the page to trigger `ProductDetailsCubit.onPromotionExpired()`.
  - *`StatefulWidget` `Ticker`*: Violates Constitution Principle IV (purely declarative widgets free of business logic).

---

## 3. Product Variant & Gallery Synchronization

- **Decision**: Model `ProductVariantEntity` with `id`, `name`, `colorHex`, and `imageUrls: List<String>`. When a user selects a colorway, `ProductDetailsCubit` updates `selectedVariantIndex` and syncs the active `galleryImages` list.
- **Rationale**:
  - Matches the Figma behavior (Screen 34) where selecting a color thumbnail (Red, Purple, Green) highlights the variant with a blue border and updates the main product photo gallery.
  - Keeps gallery state derived and immutable in `ProductDetailsLoaded`.

---

## 4. Screen 36 (Compact/Initial View) vs Screen 34 (Full View)

- **Decision**: Screen 36 and Screen 34 are identical views of the same screen (`ProductDetailsPage`) rendered via a single `CustomScrollView`. Screen 36 simply reflects scroll position `0.0`.
- **Rationale**:
  - In Figma, Screen 36 shows the top viewport (Gallery, Breadcrumb, Title, Rating, Color, Size, and sticky Bottom Bar). Screen 34 shows the fully scrolled contents (Specifications, Delivery, Ratings breakdown, Reviews preview, Most Popular, and You Might Like).
  - A single `ProductDetailsPage` using slivers naturally satisfies both views with zero code duplication.

---

## 5. Component Reuse & Layout Strategy

- **Decision**:
  - Reuse canonical `ShopProductCard` for the "You Might Like" 2-column grid.
  - Reuse `DiscountBadge` for `-20%` badges.
  - Reuse `PrimaryButton` where applicable.
  - Extract each section into a standalone widget file in `lib/features/product/presentation/widgets/`:
    - `ProductImageGallery`
    - `ProductBreadcrumb`
    - `ProductRatingRow`
    - `ProductColorSelector`
    - `ProductSizeSelector`
    - `FlashSaleBanner`
    - `ProductSpecificationsSection`
    - `ProductDeliverySection`
    - `ProductRatingsBreakdown`
    - `ProductReviewsPreview`
    - `ProductMostPopularCarousel`
    - `ProductYouMightLikeGrid`
    - `ProductBottomBar`
    - `ReviewCard`
    - `ProductShimmerLoading`
