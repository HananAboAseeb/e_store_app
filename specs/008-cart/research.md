# Research & Technical Decisions: Cart Feature (Screens 44, 45, 46)

**Feature**: `specs/008-cart` | **Date**: 2026-09-23

This document establishes the technical decisions, patterns, and architectural trade-offs for the **Cart** feature.

---

## 1. Unified Cart Page vs. Multi-Page Architecture

- **Decision**: Implement a single, unified `CartPage` controlled by `CartCubit` that conditionally switches views based on `CartLoaded` state (`items.isNotEmpty` vs. `items.isEmpty`).
- **Rationale**:
  - Screen 44 (populated cart), Screen 45 (empty cart + wishlist), and Screen 46 (empty cart + popular) are three visual presentations of the same user destination (`/cart`).
  - Transitioning from empty cart to populated cart occurs seamlessly when a user taps "Add to Cart" on a wishlist or popular item. A single page ensures smooth reactive state transitions without route pushes or page resets.
  - When `items.isEmpty`: the page renders `EmptyCartState`. If `wishlistSuggestions.isNotEmpty`, it renders the vertical "From Your Wishlist" section (Screen 45). If wishlist is empty (or when testing popular recommendations), it renders the horizontal "Most Popular" carousel with "See All →" (Screen 46).
- **Alternatives Considered**:
  - *Separate GoRoute for each screen*: Rejected because empty vs. populated cart is an application state, not a different route destination.

---

## 2. In-Memory Mutable State vs. Local Persistence (Phase 1)

- **Decision**: Manage cart state in-memory inside `CartMockDataSourceImpl` with simulated asynchronous latency (`Future.delayed`).
- **Rationale**:
  - Adheres strictly to Constitution Principle VI and Permanent Rule 8 (Mock Data only for Phase 1).
  - An in-memory store allows users to increment/decrement quantities, remove items, add wishlist/popular items to cart, and observe reactive price calculations throughout the session without requiring SQLite/Hive dependencies in Phase 1.
  - The repository interface (`CartRepository`) returns `Future<Either<Failure, CartSummaryEntity>>` using `dartz` and `safeCall`, making it 100% plug-and-play for a real REST/GraphQL API or Hive cache in Phase 2.
- **Alternatives Considered**:
  - *Hardcoded static state*: Rejected because users wouldn't be able to test quantity adjustments, deletions, or empty cart transitions.
  - *Local SQLite/Hive persistence*: Rejected as premature over-engineering for Phase 1 UI-focused scope.

---

## 3. Cart Price & Quantity Calculation Strategy

- **Decision**: Centralize calculations in `CartSummaryEntity` / `CartSummaryModel`.
- **Rationale**:
  - Subtotal is computed as $\sum (\text{unitPrice} \times \text{quantity})$.
  - `itemCount` is the total count of distinct line items (or total units) shown in the header badge.
  - When an item's quantity reaches `1`, tapping `⊖` maintains quantity at `1` (minimum quantity boundary; does not remove). Removal requires tapping the trash icon or confirming deletion.
  - Keeps business calculations encapsulated in the domain/data model rather than scattered across UI widgets.

---

## 4. Component Reuse & Modularization

- **Decision**:
  - Reuse canonical `ShopProductCard` for the "Most Popular" carousel (Screen 46).
  - Reuse `DiscountBadge` for promotional chips (`New`, `Sale`, `Hot`).
  - Reuse `PrimaryButton` for the sticky checkout button.
  - Extract specialized cart widgets into `lib/features/cart/presentation/widgets/`:
    - `CartHeader`: App bar with title and circular item count badge.
    - `ShippingAddressCard`: Rounded delivery summary card (`16.r`) with edit arrow.
    - `CartItemCard`: Item row with image, title, variant pills, price in Raleway, `⊖ 1 ⊕` controls, and red trash icon.
    - `EmptyCartState`: Centered circular bag icon graphic + "Your Cart is Empty" text.
    - `FromYourWishlistHorizontal`: Screen 44 bottom horizontal recommendation list.
    - `FromYourWishlistVertical`: Screen 45 vertical list with delete and quick-add cart button.
    - `MostPopularCartCarousel`: Screen 46 horizontal popular product carousel.
    - `CartBottomBar`: Sticky bottom bar with dynamic total and enabled/disabled Checkout button.
    - `QuantityControl`: Reusable `⊖ count ⊕` widget.
    - `CartShimmerLoading`: Shimmer skeleton during data loading.
