# Tasks: Cart Feature (Screens 44, 45, 46)

**Input**: Design documents and specifications from `/specs/008-cart/`  
**Prerequisites**: [plan.md](./plan.md), [spec.md](./spec.md), [research.md](./research.md), [data-model.md](./data-model.md), [contracts/cart_contracts.md](./contracts/cart_contracts.md)  
**Branch**: `feature/cart`  
**Organization**: Tasks are grouped into Setup, Foundational, User Stories (US1 → US2 → US3 → US4 → US5), and Polish phases to enable independent implementation and testing.

## Format: `- [x] [TaskID] [P?] [Story?] Description with file path`

- **[P]**: Parallelizable (independent files, no blocking dependencies on incomplete tasks)
- **[Story]**: Belongs to a specific user story ([US1], [US2], [US3], [US4], [US5])
- Every task includes Prerequisites, Estimated Effort, and Quality Gate.

---

## Phase 1: Setup (Directory Structure, DI Skeleton & Route Placeholders)

**Purpose**: Scaffolding directories, injection skeleton, and route placeholders for `lib/features/cart/`.

- [x] T001 Create complete folder structure in lib/features/cart/
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Directories verified: `domain/entities/`, `domain/repositories/`, `domain/usecases/`, `data/models/`, `data/datasources/`, `data/repositories/`, `presentation/manager/`, `presentation/pages/`, `presentation/widgets/`.

- [x] T002 [P] Add checkout route constants in lib/config/routing/route_names.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: `kCheckoutPage = '/checkout'` and `kCheckoutShippingPage = '/checkout/shipping'` constants added to `RouteNames`.

- [x] T003 [P] Add checkout placeholder route handlers in lib/config/routing/app_router.dart
  - **Prerequisites**: T002
  - **Estimated Effort**: 5m
  - **Quality Gate**: Placeholder routes for `/checkout` and `/checkout/shipping` registered in `app_router.dart` to prevent navigation crashes.

- [x] T004 Wire initCart dependency injection in lib/core/di/injection_container.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: `initCart()` invoked inside `init()` in `injection_container.dart`.

---

## Phase 2: Foundational (Domain Entities, Repository Contract, Use Cases & Data Layer)

**Purpose**: Core domain entities, repository contract, use cases, data models, mock data source, and repository implementation with `safeCall`. MUST be completed before UI work.

- [x] T005 [P] Implement CartItemEntity in lib/features/cart/domain/entities/cart_item_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `id`, `productId`, `title`, `imageUrl`, `size`, `color`, `quantity`, `unitPrice`, and computed `totalPrice`.

- [x] T006 [P] Implement ShippingAddressEntity in lib/features/cart/domain/entities/shipping_address_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `id`, `country`, `city`, `state`, `street`, `zipCode`, and `formattedAddress`.

- [x] T007 Implement CartSummaryEntity in lib/features/cart/domain/entities/cart_summary_entity.dart
  - **Prerequisites**: T005, T006
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, aggregates `items`, `wishlistSuggestions`, `popularSuggestions` (reuses canonical `ShopProductEntity`), `shippingAddress`, computed `subtotal`, and `itemCount`.

- [x] T008 Define CartRepository contract in lib/features/cart/domain/repositories/cart_repository.dart
  - **Prerequisites**: T007
  - **Estimated Effort**: 5m
  - **Quality Gate**: Abstract class defining `getCart()`, `addItem()`, `removeItem()`, `updateQuantity()`, `removeWishlistSuggestion()`, and `clearCart()`, each returning `Either<Failure, CartSummaryEntity>`.

- [x] T009 [P] Implement GetCartUseCase in lib/features/cart/domain/usecases/get_cart_usecase.dart
  - **Prerequisites**: T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<CartSummaryEntity, NoParams>` delegating to `CartRepository.getCart()`.

- [x] T010 [P] Implement AddToCartUseCase in lib/features/cart/domain/usecases/add_to_cart_usecase.dart
  - **Prerequisites**: T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<CartSummaryEntity, CartItemEntity>` delegating to `CartRepository.addItem()`.

- [x] T011 [P] Implement RemoveFromCartUseCase in lib/features/cart/domain/usecases/remove_from_cart_usecase.dart
  - **Prerequisites**: T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<CartSummaryEntity, String>` delegating to `CartRepository.removeItem()`.

- [x] T012 [P] Implement UpdateCartQuantityUseCase in lib/features/cart/domain/usecases/update_cart_quantity_usecase.dart
  - **Prerequisites**: T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<CartSummaryEntity, UpdateCartQuantityParams>` delegating to `CartRepository.updateQuantity()`.

- [x] T013 [P] Implement RemoveWishlistSuggestionUseCase in lib/features/cart/domain/usecases/remove_wishlist_suggestion_usecase.dart
  - **Prerequisites**: T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<CartSummaryEntity, String>` delegating to `CartRepository.removeWishlistSuggestion()`.

- [x] T014 [P] Implement ClearCartUseCase in lib/features/cart/domain/usecases/clear_cart_usecase.dart
  - **Prerequisites**: T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<CartSummaryEntity, NoParams>` delegating to `CartRepository.clearCart()`.

- [x] T015 [P] Implement CartItemModel in lib/features/cart/data/models/cart_item_model.dart
  - **Prerequisites**: T005
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `CartItemEntity`, implements `fromJson`, `toJson`, `fromEntity`, `toEntity`.

- [x] T016 [P] Implement ShippingAddressModel in lib/features/cart/data/models/shipping_address_model.dart
  - **Prerequisites**: T006
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `ShippingAddressEntity`, implements `fromJson`, `toJson`, `fromEntity`, `toEntity`.

- [x] T017 Implement CartSummaryModel in lib/features/cart/data/models/cart_summary_model.dart
  - **Prerequisites**: T007, T015, T016
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `CartSummaryEntity`, implements `fromJson`, `toJson`, `fromEntity`, `toEntity`.

- [x] T018 Define CartMockDataSource contract in lib/features/cart/data/datasources/cart_mock_data_source.dart
  - **Prerequisites**: T017
  - **Estimated Effort**: 5m
  - **Quality Gate**: Abstract class with methods for cart CRUD operations returning `CartSummaryModel`.

- [x] T019 Implement CartMockDataSourceImpl in lib/features/cart/data/datasources/cart_mock_data_source_impl.dart
  - **Prerequisites**: T018
  - **Estimated Effort**: 10m
  - **Quality Gate**: In-memory mutable state containing 2 initial cart items, 3 wishlist suggestions, 4 popular suggestions, default shipping address; simulates network latency with `Future.delayed`.

- [x] T020 Implement CartRepositoryImpl in lib/features/cart/data/repositories/cart_repository_impl.dart
  - **Prerequisites**: T008, T019
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `CartRepository`, calls `CartMockDataSource`, wraps all calls in `safeCall` returning `Either<Failure, CartSummaryEntity>`.

- [x] T021 Define CartState in lib/features/cart/presentation/manager/cart_state.dart
  - **Prerequisites**: T007
  - **Estimated Effort**: 5m
  - **Quality Gate**: Sealed/abstract `CartState` extending `Equatable`: `CartInitial`, `CartLoading`, `CartLoaded`, `CartError`.

- [x] T022 Implement CartCubit in lib/features/cart/presentation/manager/cart_cubit.dart
  - **Prerequisites**: T009, T010, T011, T012, T013, T014, T021
  - **Estimated Effort**: 10m
  - **Quality Gate**: Extends `Cubit<CartState>`, exposes `loadCart()`, `incrementQuantity()`, `decrementQuantity()`, `removeItem()`, `addProductToCart()`, `addCartItem()`, `removeFromWishlist()`, and `clearCart()`.

- [x] T023 Implement CartShimmerLoading in lib/features/cart/presentation/widgets/cart_shimmer_loading.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Declarative shimmer skeleton using `shimmer` package matching Screen 44 layout proportions.

- [x] T024 Register Cart dependencies in lib/features/cart/cart_injection.dart
  - **Prerequisites**: T020, T022
  - **Estimated Effort**: 5m
  - **Quality Gate**: Registers `CartCubit`, use cases, `CartRepository`, and `CartMockDataSource` with `GetIt sl`.

---

## Phase 3: User Story 1 (P1) — Cart with Items (Screen 44) 🎯 MVP

**Goal**: Deliver the primary shopping cart experience with item listing, quantity controls, deletion, shipping address summary, dynamic totals, and enabled checkout trigger.

**Independent Test**: Navigate to `/cart`. Verify 2 items display with image, title, variant pills (`M`, `Pink`), price `$17,00`, `⊖ 1 ⊕`, and trash icon. Tap `⊕` to increase quantity to 2; verify subtotal updates to `$51,00`. Tap `⊖` to return to 1; tap `⊖` again and verify minimum 1 boundary. Tap trash icon to remove an item. Verify sticky bottom bar displays dynamic `Total:` in Raleway and enabled blue "Checkout" button.

- [x] T025 [P] [US1] Implement CartHeader widget in lib/features/cart/presentation/widgets/cart_header.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Displays bold "Cart" title with a light blue badge circle showing dynamic item count.

- [x] T026 [P] [US1] Implement ShippingAddressCard in lib/features/cart/presentation/widgets/shipping_address_card.dart
  - **Prerequisites**: T006
  - **Estimated Effort**: 5m
  - **Quality Gate**: Rounded `16.r` card with `#F5F5F5` surface, title "Shipping Address", address text, and circular blue arrow button (`→`).

- [x] T027 [P] [US1] Implement QuantityControl in lib/features/cart/presentation/widgets/quantity_control.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Circular `⊖` and `⊕` buttons with quantity number, enforcing minimum quantity boundary of 1.

- [x] T028 [US1] Implement CartItemCard in lib/features/cart/presentation/widgets/cart_item_card.dart
  - **Prerequisites**: T005, T027
  - **Estimated Effort**: 10m
  - **Quality Gate**: Rounded `16.r` card, product image with `12.r` radius, 2-line title with ellipsis, variant pill `M` + color `Pink`, Raleway price, `QuantityControl`, red trash icon (`#FF3B30`).

- [x] T029 [US1] Implement CartBottomBar in lib/features/cart/presentation/widgets/cart_bottom_bar.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Sticky bottom bar with `Total:` and bold Raleway price, Primary 400 blue "Checkout" button (reuses `PrimaryButton` or styled container), enabled when `itemCount > 0` and disabled when `0`.

- [x] T030 [US1] Implement CartPage populated cart view in lib/features/cart/presentation/pages/cart_page.dart
  - **Prerequisites**: T022, T023, T025, T026, T028, T029
  - **Estimated Effort**: 10m
  - **Quality Gate**: Unified `CartPage` consumes `CartCubit`; renders `CartShimmerLoading` on loading, and renders `CartHeader`, `ShippingAddressCard`, `CartItemCard` list, and `CartBottomBar` when `state.items.isNotEmpty`.

---

## Phase 4: User Story 2 (P2) — Empty Cart + From Your Wishlist (Screen 45)

**Goal**: Provide an engaging empty cart experience displaying "Your Cart is Empty" alongside a vertical list of saved wishlist items with a 1-tap "Add to Cart" button.

**Independent Test**: Navigate to `/cart` with an empty cart and wishlist items present. Verify centered empty bag graphic and "Your Cart is Empty" headline. Verify vertical list of wishlist items with `$17,00`, `Pink`/`M` pills, trash icon, and blue cart icon button. Tap the cart icon button on an item; verify it is immediately added to the cart, the view transitions to Screen 44, badge updates to `1`, total updates to `$17,00`, and Checkout button activates.

- [x] T031 [P] [US2] Implement EmptyCartState in lib/features/cart/presentation/widgets/empty_cart_state.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Centered circular grey icon with blue shopping bag and `$` symbol, followed by bold "Your Cart is Empty" typography.

- [x] T032 [US2] Implement FromYourWishlistVertical in lib/features/cart/presentation/widgets/from_your_wishlist_vertical.dart
  - **Prerequisites**: T005
  - **Estimated Effort**: 10m
  - **Quality Gate**: Section header "From Your Wishlist", vertical list of wishlist item cards with image, title, price `$17,00`, `Pink` & `M` pills, trash icon (calls `removeFromWishlist`), and circular blue cart button (calls `addCartItem`).

- [x] T033 [US2] Integrate Screen 45 empty state into CartPage in lib/features/cart/presentation/pages/cart_page.dart
  - **Prerequisites**: T030, T031, T032
  - **Estimated Effort**: 5m
  - **Quality Gate**: When `state.items.isEmpty` and `state.wishlistSuggestions.isNotEmpty`, `CartPage` renders `EmptyCartState`, `FromYourWishlistVertical`, and `CartBottomBar` with disabled Checkout and `Total: $0,00`.

---

## Phase 5: User Story 3 (P3) — Empty Cart + Most Popular (Screen 46)

**Goal**: Deliver popular product discovery when the cart is empty without wishlist items, featuring a horizontal carousel with promotional badges and direct navigation/cart addition.

**Independent Test**: In empty cart popular mode, verify "Most Popular" header with "See All →" circular blue arrow button. Verify horizontal carousel displaying popular products tagged with badges (`New`, `Sale`, `Hot`) and price `$17,80`. Tap "See All →" and verify navigation to `/catalog`. Tap a product card and verify navigation to `/product/:id`. Tap the cart icon on a card and verify it adds to cart and transitions to Screen 44.

- [x] T034 [US3] Implement MostPopularCartCarousel in lib/features/cart/presentation/widgets/most_popular_cart_carousel.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 10m
  - **Quality Gate**: Reuses canonical `ShopProductCard` and `DiscountBadge`; renders header with "Most Popular" and circular blue arrow "See All →"; supports card tap navigation to `/product/:id` and cart icon tap calling `addProductToCart`.

- [x] T035 [US3] Integrate Screen 46 empty state into CartPage in lib/features/cart/presentation/pages/cart_page.dart
  - **Prerequisites**: T030, T031, T034
  - **Estimated Effort**: 5m
  - **Quality Gate**: When `state.items.isEmpty` and `state.wishlistSuggestions.isEmpty` (or in popular fallback context), `CartPage` renders `EmptyCartState` and `MostPopularCartCarousel` with disabled `CartBottomBar`.

---

## Phase 6: User Story 4 (P4) — Cross-Selling: From Your Wishlist Horizontal Section (Screen 44)

**Goal**: Display horizontal "From Your Wishlist" cross-sell recommendations inside the populated cart below the active cart items.

**Independent Test**: On Screen 44 with cart items present, scroll below the item cards. Verify the horizontal "From Your Wishlist" carousel renders with suggested items. Tap the quick-add cart icon on a suggested card; verify the item is immediately added to the cart items list above and total recalculates.

- [x] T036 [US4] Implement FromYourWishlistHorizontal in lib/features/cart/presentation/widgets/from_your_wishlist_horizontal.dart
  - **Prerequisites**: T005
  - **Estimated Effort**: 10m
  - **Quality Gate**: Section header "From Your Wishlist", horizontal ListView of wishlist cards with image, title, price, variant pills, and quick-add cart button calling `addCartItem()`.

- [x] T037 [US4] Embed FromYourWishlistHorizontal into populated view in lib/features/cart/presentation/pages/cart_page.dart
  - **Prerequisites**: T030, T036
  - **Estimated Effort**: 5m
  - **Quality Gate**: Embedded below the cart items list in `CartPage` when `state.items.isNotEmpty` and `state.wishlistSuggestions.isNotEmpty`.

---

## Phase 7: User Story 5 (P5) — Navigation Triggers & Shell Integration

**Goal**: Connect the cart screen to downstream checkout and address flows and maintain persistent shell tab highlighting.

**Independent Test**: On Screen 44, tap "Checkout"; verify navigation to `/checkout`. Tap the circular blue arrow (`→`) in the Shipping Address card; verify navigation to `/checkout/shipping`. On Screens 45 and 46, tap "Checkout"; verify no navigation occurs. Verify the Cart tab in the bottom navigation shell remains active and blue.

- [x] T038 [US5] Wire Checkout navigation trigger in lib/features/cart/presentation/widgets/cart_bottom_bar.dart
  - **Prerequisites**: T002, T029
  - **Estimated Effort**: 5m
  - **Quality Gate**: Tapping enabled Checkout button calls `context.push(RouteNames.kCheckoutPage)`; disabled button does nothing.

- [x] T039 [US5] Wire Shipping Address navigation trigger in lib/features/cart/presentation/widgets/shipping_address_card.dart
  - **Prerequisites**: T002, T026
  - **Estimated Effort**: 5m
  - **Quality Gate**: Tapping circular blue arrow button calls `context.push(RouteNames.kCheckoutShippingPage)`.

- [x] T040 [US5] Verify shell routing integration in lib/config/routing/app_router.dart
  - **Prerequisites**: T030
  - **Estimated Effort**: 5m
  - **Quality Gate**: `RouteNames.kCartPage` properly renders `CartPage` inside `StatefulShellBranch` with the Cart tab highlighted in active blue (`#004BFE`).

---

## Phase 8: Polish & Final Quality Gates (Strictly Run ONCE at the End)

**Purpose**: Automated testing, formatting, and static analysis verification across the entire feature.

- [x] T041 [P] Implement CartCubit unit tests in test/features/cart/presentation/manager/cart_cubit_test.dart
  - **Prerequisites**: T022
  - **Estimated Effort**: 10m
  - **Quality Gate**: Tests initial load, quantity increment/decrement with min boundary 1, item deletion, and empty cart transitions using `bloc_test`.

- [x] T042 [P] Implement CartPage widget tests in test/features/cart/presentation/pages/cart_page_test.dart
  - **Prerequisites**: T030, T033, T035
  - **Estimated Effort**: 10m
  - **Quality Gate**: Tests rendering of populated cart (Screen 44), empty cart with wishlist (Screen 45), and empty cart with popular (Screen 46).

- [x] T043 Run final static analysis and test validation
  - **Prerequisites**: T001-T042
  - **Estimated Effort**: 5m
  - **Quality Gate**: `flutter analyze` passes with 0 issues; all cart unit and widget tests pass.

---

## Dependencies & Execution Order

```mermaid
graph TD
    P1[Phase 1: Setup] --> P2[Phase 2: Foundational]
    P2 --> P3[US1 - Cart with Items (Screen 44)]
    P3 --> P4[US2 - Empty Cart + Wishlist (Screen 45)]
    P3 --> P5[US3 - Empty Cart + Popular (Screen 46)]
    P3 --> P6[US4 - Cross-selling Horizontal]
    P3 --> P7[US5 - Navigation Triggers]
    P4 --> P8[Polish & Quality Gates]
    P5 --> P8
    P6 --> P8
    P7 --> P8
```

- **MVP Scope**: Phase 1 + Phase 2 + Phase 3 (US1: Screen 44 with items, quantity adjustment, deletion, and reactive totals).
- **Parallel Opportunities**:
  - Phase 1: T002, T003 in parallel.
  - Phase 2: T005, T006, T009–T016, T023 in parallel.
  - Phase 3: T025, T026, T027 in parallel.
  - Phase 4: T031 in parallel.
  - Phase 8: T041, T042 in parallel.
