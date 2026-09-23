# Implementation Plan: Cart Feature (Screens 44, 45, 46)

**Branch**: `feature/cart` | **Date**: 2026-09-23 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `specs/008-cart/spec.md` and Figma reference screenshots `44 CART.png` (Cart with items), `45 CART SHOWN FROM WISHLIST.png` (Empty cart + From Your Wishlist section), and `46 CART SHOWN FROM POPULAR.png` (Empty cart + Most Popular carousel).

---

## Summary

Implement the **Cart** feature providing a unified, reactive shopping basket experience:
1. **Screen 44 (Populated Cart)**: Header with item count badge, Shipping Address summary card with edit navigation arrow, cart items list with quantity controls (`⊖ 1 ⊕`) and red trash icon, horizontal "From Your Wishlist" cross-sell section, and sticky bottom bar displaying dynamic total price and active "Checkout" button.
2. **Screen 45 (Empty Cart with Wishlist)**: Empty cart state with bag illustration and "Your Cart is Empty" text, muted `Total: $0,00`, disabled Checkout button, and vertical "From Your Wishlist" section with 1-tap cart addition and wishlist item deletion.
3. **Screen 46 (Empty Cart with Popular)**: Empty cart state with "Most Popular" horizontal carousel featuring status badges (`New`, `Sale`, `Hot`), price `$17,80`, direct add-to-cart, card navigation to `/product/:id`, and "See All →" linking to `/catalog`.

The implementation strictly adheres to Feature-First Clean Architecture (`lib/features/cart/`), Cubit state management with Equatable, GetIt DI, and `go_router` shell integration.

---

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x  
**Primary Dependencies**: `flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`  
**Storage**: Mock Data with in-memory mutable state and simulated latency (Phase 1 UI-only)  
**Testing & Verification**: Static analysis and tests strictly deferred to final phase per Permanent Rule 1  
**Target Platform**: iOS & Android  
**Design Reference**: Figma screenshots 44, 45, 46 in `assets/design_references/`  
**Performance Goals**: 60 FPS smooth scrolling, immediate (<100ms) reactive total and badge recalculations upon quantity changes, zero layout overflows  

---

## Constitution Check

| Principle / Rule | Requirement | Compliance Status |
|---|---|---|
| **I. Architecture Preservation** | Follow `lib/features/`, `lib/core/`, `lib/config/` structure | ✅ PASS: Uses `lib/features/cart/` matching canonical architecture |
| **II. Clean Architecture & Safety** | Decoupled domain, `Either<Failure, T>` via `dartz`, `safeCall` in repo impl | ✅ PASS: Explicit domain/data/presentation boundaries with error handling |
| **III. Design Tokens & Pixel Perfection** | `AppColors`, `AppSpacing`, `AppTypography`, `flutter_screenutil` dimensions | ✅ PASS: 100% token usage and `.w, .h, .r, .sp` scaling |
| **IV. Strict UI & State Separation** | Cubit state management, Equatable states, shimmer loading | ✅ PASS: `CartCubit` with Equatable states; pure declarative widgets; shimmer loading |
| **V. Router & Shell Navigation** | Registered in `go_router`, clean push/pop | ✅ PASS: Mounted as 4th tab in `StatefulShellRoute` in `app_router.dart` |
| **Permanent Rules 1–10** | Deferred verification, no new assets, mock data only, widget reuse (`ShopProductCard`, `DiscountBadge`, `PrimaryButton`) | ✅ PASS: Reuses existing assets and widgets without duplication |

---

## Project Structure

### Documentation Artifacts
```text
specs/008-cart/
├── spec.md                  # Feature specification
├── plan.md                  # Implementation plan (this file)
├── research.md              # Technical decisions & trade-offs
├── data-model.md            # Domain entities, models, and UI states
├── quickstart.md            # Validation scenarios & step-by-step verification
├── contracts/
│   └── cart_contracts.md    # Repository, UseCase, DataSource, and Cubit contracts
└── checklists/
    └── requirements.md      # Specification quality checklist
```

### Source Code Organization (`lib/features/cart/`)

```text
lib/features/cart/
├── cart_injection.dart                              # DI registration for Cart feature
├── data/
│   ├── datasources/
│   │   ├── cart_mock_data_source.dart               # Data source contract
│   │   └── cart_mock_data_source_impl.dart          # In-memory mock data implementation
│   ├── models/
│   │   ├── cart_item_model.dart                     # Model for line item
│   │   ├── shipping_address_model.dart              # Model for shipping address
│   │   └── cart_summary_model.dart                  # Model for aggregate cart state
│   └── repositories/
│       └── cart_repository_impl.dart                # Repository implementation wrapping safeCall
├── domain/
│   ├── entities/
│   │   ├── cart_item_entity.dart                    # Cart line item entity
│   │   ├── shipping_address_entity.dart             # Destination address entity
│   │   └── cart_summary_entity.dart                 # Aggregate cart entity
│   ├── repositories/
│   │   └── cart_repository.dart                     # Repository interface contract
│   └── usecases/
│       ├── get_cart_usecase.dart                    # Fetch cart summary
│       ├── add_to_cart_usecase.dart                 # Add product/item to cart
│       ├── remove_from_cart_usecase.dart            # Remove item from cart
│       ├── update_cart_quantity_usecase.dart        # Increment/decrement quantity
│       ├── remove_wishlist_suggestion_usecase.dart  # Remove from wishlist suggestions
│       └── clear_cart_usecase.dart                  # Empty the cart
└── presentation/
    ├── manager/
    │   ├── cart_cubit.dart                          # Cart business logic & state transitions
    │   └── cart_state.dart                          # Immutable Equatable states
    ├── pages/
    │   └── cart_page.dart                           # Unified Cart page (Screens 44, 45, 46)
    └── widgets/
        ├── cart_header.dart                         # Title + dynamic item count badge
        ├── shipping_address_card.dart               # Address summary + edit arrow button
        ├── cart_item_card.dart                      # Item card with image, pills, price, quantity, trash
        ├── empty_cart_state.dart                    # Graphic + "Your Cart is Empty" centered block
        ├── from_your_wishlist_horizontal.dart       # Screen 44 bottom cross-sell carousel/list
        ├── from_your_wishlist_vertical.dart         # Screen 45 vertical list with delete & cart buttons
        ├── most_popular_cart_carousel.dart          # Screen 46 horizontal carousel with See All
        ├── cart_bottom_bar.dart                     # Sticky Total + enabled/disabled Checkout button
        ├── quantity_control.dart                    # Reusable ⊖ count ⊕ widget
        └── cart_shimmer_loading.dart                # Skeleton placeholder during loading
```

---

## Technical Decisions Summary

1. **Unified View Architecture**: A single `CartPage` managed by `CartCubit` dynamically renders populated cart components (Screen 44) when items exist, or empty cart components (Screens 45 and 46) when the basket is empty.
2. **In-Memory Mutable State Store**: `CartMockDataSourceImpl` holds mutable lists in-memory for Phase 1, allowing real-time additions, quantity changes, and removals during testing while remaining 100% compliant with Clean Architecture contracts.
3. **Reactive Bottom Bar & Badge Synchronization**: Quantity updates compute item totals and cart subtotals atomically, updating the header badge count and bottom bar price immediately without UI lag.
4. **Widget Reuse**: Reuses `ShopProductCard`, `DiscountBadge`, and `PrimaryButton` from core/shared widgets without code duplication.
