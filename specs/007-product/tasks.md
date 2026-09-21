# Tasks: Product Feature (Screens 34, 35, 36, 37)

**Input**: Design documents and specifications from `/specs/007-product/`  
**Prerequisites**: [plan.md](./plan.md), [spec.md](./spec.md), [research.md](./research.md), [data-model.md](./data-model.md), [contracts/product_contracts.md](./contracts/product_contracts.md)  
**Branch**: `feature/product`  
**Organization**: Tasks are grouped into Setup, Foundational, User Stories (US1 → US2 → US3 → US4 → US5), and Polish phases to enable independent implementation and testing.

## Format: `- [x] [TaskID] [P?] [Story?] Description with file path`

- **[P]**: Parallelizable (independent files, no blocking dependencies on incomplete tasks)
- **[Story]**: Belongs to a specific user story ([US1], [US2], [US3], [US4], [US5])
- Every task includes Prerequisites, Estimated Effort, and Quality Gate.

---

## Phase 1: Setup (Directory Structure, DI Skeleton & Route Placeholders)

**Purpose**: Scaffolding directories, injection skeleton, and route placeholders for `lib/features/product/`.

- [x] T001 Create complete folder structure in lib/features/product/
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Directories created: `domain/entities/`, `domain/repositories/`, `domain/usecases/`, `data/models/`, `data/datasources/`, `data/repositories/`, `presentation/cubit/`, `presentation/pages/`, `presentation/widgets/`.

- [x] T002 [P] Create initial dependency injection skeleton in lib/features/product/product_injection.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Defines `initProductInjection()` function registered via `GetIt sl`.

- [x] T003 [P] Add product route constants in lib/config/routing/route_names.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: `kProductDetailsPage = '/product/:id'` and `kProductReviewsPage = '/product/:id/reviews'` added to `RouteNames`.

- [x] T004 Register route placeholders in lib/config/routing/app_router.dart and wire initProductInjection in lib/core/di/injection_container.dart
  - **Prerequisites**: T002, T003
  - **Estimated Effort**: 5m
  - **Quality Gate**: Product routes registered in `app_router.dart`; `initProductInjection()` invoked inside `injection_container.dart`.

---

## Phase 2: Foundational (Domain Entities, Repository Contract, Use Cases & Data Layer)

**Purpose**: Core domain entities, repository contract, use cases, data models, mock data source, and repository implementation with `safeCall`. MUST be completed before UI work.

- [x] T005 [P] Implement ProductVariantEntity in lib/features/product/domain/entities/product_variant_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `id`, `name`, `colorHex`, `thumbnailUrl`, `images`.

- [x] T006 [P] Implement SpecificationEntity in lib/features/product/domain/entities/specification_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `label`, `values`.

- [x] T007 [P] Implement DeliveryOptionEntity in lib/features/product/domain/entities/delivery_option_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `id`, `name`, `estimatedDays`, `price`.

- [x] T008 [P] Implement RatingBreakdownEntity in lib/features/product/domain/entities/rating_breakdown_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `stars`, `percentage`.

- [x] T009 [P] Implement ReviewEntity in lib/features/product/domain/entities/review_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `id`, `authorName`, `authorAvatar`, `rating`, `text`, `likes`, `dislikes`, `userVote`, `timeAgo`, and `copyWith`.

- [x] T010 Implement ProductDetailsEntity in lib/features/product/domain/entities/product_details_entity.dart
  - **Prerequisites**: T005, T006, T007, T008, T009
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, reuses `ShopProductEntity` for recommendations, defines complete product details contract.

- [x] T011 Define ProductRepository contract in lib/features/product/domain/repositories/product_repository.dart
  - **Prerequisites**: T010
  - **Estimated Effort**: 5m
  - **Quality Gate**: Abstract class defining `getProductDetails()`, `getProductReviews()`, and `voteReview()` returning `Either<Failure, T>`.

- [x] T012 [P] Implement GetProductDetailsUseCase in lib/features/product/domain/usecases/get_product_details_usecase.dart
  - **Prerequisites**: T011
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<ProductDetailsEntity, String>` delegating to `ProductRepository.getProductDetails()`.

- [x] T013 [P] Implement GetProductReviewsUseCase in lib/features/product/domain/usecases/get_product_reviews_usecase.dart
  - **Prerequisites**: T011
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<List<ReviewEntity>, GetProductReviewsParams>` delegating to `ProductRepository.getProductReviews()`.

- [x] T014 [P] Implement VoteReviewUseCase in lib/features/product/domain/usecases/vote_review_usecase.dart
  - **Prerequisites**: T011
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<ReviewEntity, VoteReviewParams>` delegating to `ProductRepository.voteReview()`.

- [x] T015 [P] Implement ProductVariantModel in lib/features/product/data/models/product_variant_model.dart
  - **Prerequisites**: T005
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `ProductVariantEntity`, implements `fromJson`, `toJson`, and factory constructor.

- [x] T016 [P] Implement SpecificationModel in lib/features/product/data/models/specification_model.dart
  - **Prerequisites**: T006
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `SpecificationEntity`, implements `fromJson`, `toJson`, and factory constructor.

- [x] T017 [P] Implement DeliveryOptionModel in lib/features/product/data/models/delivery_option_model.dart
  - **Prerequisites**: T007
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `DeliveryOptionEntity`, implements `fromJson`, `toJson`, and factory constructor.

- [x] T018 [P] Implement RatingBreakdownModel in lib/features/product/data/models/rating_breakdown_model.dart
  - **Prerequisites**: T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `RatingBreakdownEntity`, implements `fromJson`, `toJson`, and factory constructor.

- [x] T019 [P] Implement ReviewModel in lib/features/product/data/models/review_model.dart
  - **Prerequisites**: T009
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `ReviewEntity`, implements `fromJson`, `toJson`, and factory constructor.

- [x] T020 Implement ProductDetailsModel in lib/features/product/data/models/product_details_model.dart
  - **Prerequisites**: T010, T015, T016, T017, T018, T019
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `ProductDetailsEntity`, implements `fromJson`, `toJson`, and factory constructor.

- [x] T021 Define ProductMockDataSource contract in lib/features/product/data/datasources/product_mock_datasource.dart
  - **Prerequisites**: T020
  - **Estimated Effort**: 5m
  - **Quality Gate**: Abstract class with `getProductDetails(id)`, `getProductReviews(id, page, limit)`, `voteReview(id, isLike)`.

- [x] T022 Implement ProductMockDataSourceImpl in lib/features/product/data/datasources/product_mock_datasource_impl.dart
  - **Prerequisites**: T021
  - **Estimated Effort**: 10m
  - **Quality Gate**: Implements mock data for Caviar Leather Jacket, color variants, size choices, 10+ customer reviews, reusing assets from `assets/images/`.

- [x] T023 Implement ProductRepositoryImpl in lib/features/product/data/repositories/product_repository_impl.dart
  - **Prerequisites**: T011, T022
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `ProductRepository` wrapping calls with `safeCall` and returning `Either<Failure, T>`.

---

## Phase 3: User Story 1 - Product Details Core (Screens 34 & 36) (Priority: P1) 🎯 MVP

**Goal**: Complete product details experience including interactive image gallery, breadcrumbs with wishlist/share, title, rating summary, color variants, size selector, specifications, delivery tiers, ratings breakdown, and sticky bottom bar.

**Independent Test**: Navigate to `/product/caviar-jacket`. Verify image gallery swipes with active blue dot indicator, selecting color variant updates gallery images, size pill opens size selector, specifications and delivery cards render properly, and sticky bottom bar displays price point and "Add to Basket" button.

- [x] T024 [US1] Implement ProductDetailsState in lib/features/product/presentation/cubit/product_details_state.dart
  - **Prerequisites**: T010
  - **Estimated Effort**: 5m
  - **Quality Gate**: Defines `ProductDetailsInitial`, `ProductDetailsLoading`, `ProductDetailsLoaded`, and `ProductDetailsError` with Equatable.

- [x] T025 [US1] Implement ProductDetailsCubit in lib/features/product/presentation/cubit/product_details_cubit.dart
  - **Prerequisites**: T024, T012
  - **Estimated Effort**: 10m
  - **Quality Gate**: Handles `loadProduct()`, `selectColorVariant()`, `selectSize()`, `toggleWishlist()`, and `addToBasket()`.

- [x] T026 [P] [US1] Implement ProductImageGallery widget in lib/features/product/presentation/widgets/product_image_gallery.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Rounded corners (`20.r`), horizontal `PageView`, active blue dot indicator (`#004BFE`).

- [x] T027 [P] [US1] Implement ProductBreadcrumb widget in lib/features/product/presentation/widgets/product_breadcrumb.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Displays `Shop > Jackets > Caviar`, wishlist heart icon toggle, and share action.

- [x] T028 [P] [US1] Implement ProductRatingRow widget in lib/features/product/presentation/widgets/product_rating_row.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Gold star icon (`#FFB800`), score `4.7`, and comments pill button `2986 Comments >`.

- [x] T029 [P] [US1] Implement ProductColorSelector widget in lib/features/product/presentation/widgets/product_color_selector.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Horizontal row of 3 variant thumbnails (rounded `12.r`) with colored circular indicators and blue active border.

- [x] T030 [P] [US1] Implement ProductSizeSelector widget in lib/features/product/presentation/widgets/product_size_selector.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Header "Size", expandable pill defaulting to `M`, expands to `XS, S, M, L, XL, 2XL`.

- [x] T031 [P] [US1] Implement ProductSpecificationsSection widget in lib/features/product/presentation/widgets/product_specifications_section.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Material pills (`Cotton: 95%`, `Nylon: 5%`), origin pill (`EUROPE`), circular blue arrow button (`→`).

- [x] T032 [P] [US1] Implement ProductDeliverySection widget in lib/features/product/presentation/widgets/product_delivery_section.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Standard (`5 - 7 Days`, `$3,00`) and Express (`1 - 2 Days`, `$12,00`) rounded shipping cards.

- [x] T033 [P] [US1] Implement ProductRatingsBreakdown widget in lib/features/product/presentation/widgets/product_ratings_breakdown.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Displays numeric rating `4.7`, `3654 Scores`, and 5 horizontal distribution bars.

- [x] T034 [P] [US1] Implement ProductBottomBar widget in lib/features/product/presentation/widgets/product_bottom_bar.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Sticky bottom container with price column and Primary 400 blue "Add to Basket" button.

- [x] T035 [P] [US1] Implement ProductShimmerLoading placeholder in lib/features/product/presentation/widgets/product_shimmer_loading.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Shimmer effects matching gallery, title, color/size, and bottom bar layout.

- [x] T036 [US1] Assemble ProductDetailsPage in lib/features/product/presentation/pages/product_details_page.dart and wire DI in lib/features/product/product_injection.dart
  - **Prerequisites**: T025, T026, T027, T028, T029, T030, T031, T032, T033, T034, T035
  - **Estimated Effort**: 10m
  - **Quality Gate**: Assembles full `ProductDetailsPage` using `CustomScrollView` (satisfying Screens 34 & 36), injects `ProductDetailsCubit`, and connects routes.

---

## Phase 4: User Story 2 - Flash Sale Banner & Live Countdown (Screen 35) (Priority: P2)

**Goal**: Flash sale banner inserted between gallery and breadcrumb with real-time countdown timer (`HH:MM:SS`) and price reversion.

**Independent Test**: Navigate to `/product/caviar-jacket?sale=true`. Verify red banner (`#FF3B30`) renders with `$17,00`, strikethrough `$24,00`, `-20%` pill, and ticking countdown timer. When timer reaches zero, verify banner dismisses and prices revert to `$24,00`.

- [x] T037 [US2] Enhance ProductDetailsCubit with countdown timer and state flip in lib/features/product/presentation/cubit/product_details_cubit.dart
  - **Prerequisites**: T025
  - **Estimated Effort**: 5m
  - **Quality Gate**: `StreamSubscription<int>? _timerSubscription` ticks every second, decrements `remainingSeconds`, and flips `isFlashSaleActive = false` at 0.

- [x] T038 [US2] Implement FlashSaleBanner widget in lib/features/product/presentation/widgets/flash_sale_banner.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Red background (`#FF3B30`), sale price `$17,00`, strikethrough `$24,00`, `-20%` badge, clock icon, and countdown boxes (`HH : MM : SS`).

- [x] T039 [US2] Integrate FlashSaleBanner into ProductDetailsPage in lib/features/product/presentation/pages/product_details_page.dart
  - **Prerequisites**: T037, T038, T036
  - **Estimated Effort**: 5m
  - **Quality Gate**: Flash sale banner appears between gallery and breadcrumbs when `state.isFlashSaleActive` is true.

---

## Phase 5: User Story 3 - Reviews Preview Section (Priority: P3)

**Goal**: Reviews preview section on Product Details page showing 2 customer reviews and action button leading to full reviews view.

**Independent Test**: On `/product/caviar-jacket`, verify 2 review preview cards are displayed with avatars, star ratings, and narrative text. Tapping "View All 2986 Reviews" or comments pill triggers navigation to `/product/caviar-jacket/reviews`.

- [x] T040 [US3] Implement ProductReviewsPreview widget in lib/features/product/presentation/widgets/product_reviews_preview.dart
  - **Prerequisites**: T009
  - **Estimated Effort**: 5m
  - **Quality Gate**: Renders 2 review preview cards with star ratings and a Primary 400 blue "View All 2986 Reviews" button.

- [x] T041 [US3] Integrate ProductReviewsPreview into ProductDetailsPage in lib/features/product/presentation/pages/product_details_page.dart
  - **Prerequisites**: T040, T036
  - **Estimated Effort**: 5m
  - **Quality Gate**: Reviews preview section placed between ratings breakdown and recommendations; button navigates to `/product/:id/reviews`.

---

## Phase 6: User Story 4 - Dedicated All Reviews Screen (Screen 37) (Priority: P4)

**Goal**: Full-screen Reviews view featuring circular `✕` button, scrollable review cards with like/dislike reactions, and relative dates.

**Independent Test**: Navigate to `/product/caviar-jacket/reviews`. Verify "Reviews" title with circular `✕` button, scrollable list of review cards with avatars, gold stars, review texts, like/dislike counts (`24 ↑`, `24 ↓`), and relative dates (`2 Days Ago`). Tapping like or dislike updates counts optimistically. Tapping `✕` pops route.

- [x] T042 [US4] Implement ReviewsState in lib/features/product/presentation/cubit/reviews_state.dart
  - **Prerequisites**: T009
  - **Estimated Effort**: 5m
  - **Quality Gate**: Defines `ReviewsInitial`, `ReviewsLoading`, `ReviewsLoaded` (with `reviews`, `hasMore`, `page`), and `ReviewsError`.

- [x] T043 [US4] Implement ReviewsCubit in lib/features/product/presentation/cubit/reviews_cubit.dart
  - **Prerequisites**: T042, T013, T014
  - **Estimated Effort**: 10m
  - **Quality Gate**: Handles `loadReviews()`, `loadMoreReviews()`, `toggleLike()`, and `toggleDislike()` with optimistic state updates.

- [x] T044 [P] [US4] Implement ReviewCard widget in lib/features/product/presentation/widgets/review_card.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Circular avatar, bold author name, 4/5 gold stars, descriptive text, like/dislike vote counters, and relative timestamp.

- [x] T045 [US4] Implement ReviewsPage in lib/features/product/presentation/pages/reviews_page.dart
  - **Prerequisites**: T043, T044
  - **Estimated Effort**: 10m
  - **Quality Gate**: Header "Reviews" with circular dismiss button (`✕`), scrollable review list, pull-to-refresh, and optimistic voting.

- [x] T046 [US4] Register ReviewsCubit and ReviewsPage route in lib/features/product/product_injection.dart and lib/config/routing/app_router.dart
  - **Prerequisites**: T045
  - **Estimated Effort**: 5m
  - **Quality Gate**: `ReviewsCubit` registered in DI; `/product/:id/reviews` route properly wired in `app_router.dart`.

---

## Phase 7: User Story 5 - Product Recommendations ("Most Popular" & "You Might Like") (Priority: P5)

**Goal**: Curated "Most Popular" horizontal carousel and "You Might Like" 2-column recommendations grid.

**Independent Test**: Scroll to bottom of `/product/caviar-jacket`. Verify "Most Popular" horizontal carousel with promotional tags (`New`, `Sale`, `Hot`) and "You Might Like" 2-column grid. Tapping any card pushes navigation to that product.

- [x] T047 [P] [US5] Implement ProductMostPopularCarousel in lib/features/product/presentation/widgets/product_most_popular_carousel.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Horizontal carousel displaying product cards with promotional tags (`New`, `Sale`, `Hot`), price `$17,80`, and "See All →" header link.

- [x] T048 [P] [US5] Implement ProductYouMightLikeGrid in lib/features/product/presentation/widgets/product_you_might_like_grid.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Explicitly reuses `ShopProductCard` from `lib/features/shop/presentation/widgets/shop_product_card.dart` in a 2-column grid.

- [x] T049 [US5] Integrate recommendations sections into ProductDetailsPage in lib/features/product/presentation/pages/product_details_page.dart
  - **Prerequisites**: T047, T048, T036
  - **Estimated Effort**: 5m
  - **Quality Gate**: Sections placed below reviews preview; tapping a product navigates to `/product/:id`.

---

## Phase 8: Polish, Verification & Widget Tests (Run strictly ONCE at end)

**Purpose**: Automated widget tests and final end-to-end static analysis suite verification.

- [x] T050 Implement ProductDetailsPage widget tests in test/features/product/presentation/product_details_page_test.dart
  - **Prerequisites**: T036, T039, T041, T045, T049
  - **Estimated Effort**: 10m
  - **Quality Gate**: Tests render product title, image gallery, variant selectors, flash sale banner, and bottom bar without errors.

- [x] T051 Run final static analysis and test validation suite
  - **Prerequisites**: T050
  - **Estimated Effort**: 5m
  - **Quality Gate**: Run `flutter analyze` (0 errors, 0 warnings) and `flutter test` (all tests pass) strictly once as the final step.
