# Implementation Plan: Checkout Feature (Screens 47, 48, 49, 50)

**Branch**: `009-checkout` | **Date**: 2026-09-24 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `specs/009-checkout/spec.md` and Figma reference screenshots `47 PAYMENT.png` (Checkout Summary), `48 ADD VOUCHER.png` (Active Vouchers bottom sheet), `49 VOUCCHER ADDED.png` (Checkout with voucher applied), and `50 EDIT SHIPPING ADDRESS.png` (Edit shipping address bottom sheet). Part 2 of the 3-part Cart & Checkout experience (Cart: Screens 44–46, Checkout: Screens 47–50, Payment: Screens 51–56).

---

## Summary

Implement the **Checkout** feature providing complete order preparation:
1. **Screen 47 (Checkout Summary)**: "Payment" app bar with close button, Shipping Address summary card with edit button, Contact Information card with edit button, Items section with item count badge (`2`), "Add Voucher" button, item cards with quantity/color/size pills, Shipping Options selector (Standard $3.00 vs. Express $12.00) with delivery estimate, Payment Method preview chips (`Card`, `Paypal`), and sticky bottom bar with dynamic total and black pill "Pay" button.
2. **Screen 48 (Add Voucher Bottom Sheet)**: Modal bottom sheet (`24.r`) displaying active vouchers ("From Customer Care" 15%, "First Purchase" 5%) with ticket shape, circular side cutouts, dashed blue divider, validity dates, and "Apply" buttons.
3. **Screen 49 (Voucher Added Summary)**: Unified with Screen 47 on `CheckoutPage`, replacing the "Add Voucher" button with a solid blue badge (`5% Discount ✕`), recalculating total price, and allowing 1-tap voucher removal.
4. **Screen 50 (Edit Shipping Address Bottom Sheet)**: Modal bottom sheet (`24.r`) with editable fields for Country, Address, Town / City, and Postcode with soft light blue fill, persisting edits to checkout state.

The implementation strictly follows Feature-First Clean Architecture (`lib/features/checkout/`), Cubit state management with Equatable, GetIt DI, `go_router` navigation, and strict design token enforcement (Rule #11).

---

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x  
**Primary Dependencies**: `flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`  
**Storage**: Mock Data with in-memory mutable state and simulated latency (Phase 1 UI-only)  
**Testing & Verification**: Static analysis and tests strictly deferred to final phase per Permanent Rule 1  
**Target Platform**: iOS & Android  
**Design Reference**: Figma screenshots 47, 48, 49, 50 in `assets/design_references/`  
**Performance Goals**: 60 FPS smooth animations, reactive totals (<100ms) upon voucher/shipping changes, zero layout overflows  
**Token Strictness**: Strict color & token enforcement (Rule #11). All colors, spacing, and typography reference `AppColors`, `AppSpacing`, `AppTypography`. Missing token `AppColors.primarySoft` (`0xFFEBF1FF`) will be added to `lib/core/theme/app_colors.dart` first.

---

## Constitution Check

| Principle / Rule | Requirement | Compliance Status |
|---|---|---|
| **I. Architecture Preservation** | Follow `lib/features/`, `lib/core/`, `lib/config/` structure | ✅ PASS: Uses `lib/features/checkout/` matching canonical architecture |
| **II. Clean Architecture & Safety** | Decoupled domain, `Either<Failure, T>` via `dartz`, `safeCall` in repo impl | ✅ PASS: Explicit domain/data/presentation boundaries with error handling |
| **III. Design Tokens & Pixel Perfection** | `AppColors`, `AppSpacing`, `AppTypography`, `flutter_screenutil` dimensions | ✅ PASS: 100% token usage and `.w, .h, .r, .sp` scaling |
| **IV. Strict UI & State Separation** | Cubit state management, Equatable states, shimmer loading | ✅ PASS: `CheckoutCubit` with Equatable states; pure declarative widgets; shimmer loading |
| **V. Router & Shell Navigation** | Registered in `go_router`, clean push/pop | ✅ PASS: `/checkout` route registered with back navigation to `/cart` and forward to `/payment` |
| **Permanent Rules 1–10** | Deferred verification, no new assets, mock data only, widget reuse | ✅ PASS: Reuses existing assets and widgets (`PrimaryButton`, `DiscountBadge`, `ShopProductCard`) |
| **Rule 11 (Strict Token Enforcement)** | All colors/spacing/typography must use tokens; add missing tokens first | ✅ PASS: Adds `AppColors.primarySoft = Color(0xFFEBF1FF)` before UI construction |

---

## Project Structure

### Documentation Artifacts
```text
specs/009-checkout/
├── spec.md                  # Feature specification
├── plan.md                  # Implementation plan (this file)
├── research.md              # Technical decisions & trade-offs
├── data-model.md            # Domain entities, models, and UI states
├── quickstart.md            # Validation scenarios & step-by-step verification
├── contracts/
│   └── checkout_contracts.md # Repository, UseCase, DataSource, and Cubit contracts
└── checklists/
    └── requirements.md      # Specification quality checklist
```

### Source Code Organization (`lib/features/checkout/`)

```text
lib/features/checkout/
├── checkout_injection.dart                              # DI registration for Checkout feature
├── data/
│   ├── datasources/
│   │   ├── checkout_mock_data_source.dart               # Data source contract
│   │   └── checkout_mock_data_source_impl.dart          # In-memory mock data implementation
│   ├── models/
│   │   ├── order_item_model.dart                        # Model for checkout item
│   │   ├── shipping_address_model.dart                  # Model for shipping address
│   │   ├── contact_info_model.dart                      # Model for contact info
│   │   ├── shipping_option_model.dart                   # Model for shipping option
│   │   ├── voucher_model.dart                           # Model for active voucher
│   │   └── checkout_summary_model.dart                  # Aggregate checkout model
│   └── repositories/
│       └── checkout_repository_impl.dart                # Repository implementation wrapping safeCall
├── domain/
│   ├── entities/
│   │   ├── order_item_entity.dart                       # Line item entity
│   │   ├── shipping_address_entity.dart                 # Shipping destination entity
│   │   ├── contact_info_entity.dart                     # Contact info entity
│   │   ├── shipping_option_entity.dart                  # Shipping option entity
│   │   ├── voucher_entity.dart                          # Promotional voucher entity
│   │   └── checkout_summary_entity.dart                 # Aggregate checkout entity
│   ├── repositories/
│   │   └── checkout_repository.dart                     # Repository interface contract
│   └── usecases/
│       ├── get_checkout_summary_usecase.dart            # Load checkout summary
│       ├── get_active_vouchers_usecase.dart             # Load active vouchers
│       ├── apply_voucher_usecase.dart                   # Apply voucher by id
│       ├── remove_voucher_usecase.dart                  # Remove applied voucher
│       ├── update_shipping_option_usecase.dart          # Toggle standard/express
│       └── update_shipping_address_usecase.dart         # Update destination address
└── presentation/
    ├── manager/
    │   ├── checkout_cubit.dart                          # Cubit business logic & state transitions
    │   └── checkout_state.dart                          # Immutable Equatable states
    ├── pages/
    │   └── checkout_page.dart                           # Unified page for Screens 47 and 49
    └── widgets/
        ├── checkout_app_bar.dart                        # "Payment" title + circular ✕ close button
        ├── checkout_shipping_address_card.dart          # Address summary + circular blue edit button
        ├── checkout_contact_info_card.dart              # Contact summary + circular blue edit button
        ├── checkout_items_section.dart                  # Header + badge 2 + "Add Voucher" / Discount badge + item cards
        ├── checkout_item_card.dart                      # Product image, title, quantity circle, variant pills, price
        ├── shipping_options_section.dart                # Standard vs Express options + delivery estimate subtitle
        ├── payment_method_preview.dart                  # Card vs Paypal preview selection chips
        ├── checkout_bottom_bar.dart                     # Sticky Total + black pill "Pay" button
        ├── voucher_bottom_sheet.dart                    # Screen 48 modal bottom sheet
        ├── voucher_ticket_card.dart                     # Ticket shape with cutouts, dashed line, Apply button
        ├── edit_shipping_address_sheet.dart             # Screen 50 modal bottom sheet with inputs
        └── checkout_shimmer_loading.dart                # Skeleton placeholder during loading
```

---

## Technical Decisions Summary

1. **Screen Unification Strategy**: `CheckoutPage` serves both Screen 47 and Screen 49, dynamically toggling between the outlined "Add Voucher" button and the solid blue `5% Discount ✕` badge based on `summary.appliedVoucher != null`.
2. **Modal Bottom Sheets**: Screens 48 and 50 are implemented as modal bottom sheets (`VoucherBottomSheet` and `EditShippingAddressSheet`) with `24.r` top rounded corners and circular `✕` dismiss buttons.
3. **Decoupled Payment Boundary**: Payment processing (Screens 51–56) is isolated to a future `payment` feature. The "Payment Method" section on Screen 47 is an interactive preview; tapping "Pay" routes to `/payment`.
4. **Token Enforcement**: Adds `static const Color primarySoft = Color(0xFFEBF1FF);` to `AppColors` for soft blue fills (input backgrounds, selected chips, variant pills).
5. **In-Memory Mock Store**: `CheckoutMockDataSourceImpl` holds mutable data in-memory with simulated async delays, supporting reactive voucher apply/remove, shipping option toggles, and address updates.
