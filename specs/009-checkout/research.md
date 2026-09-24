# Research & Technical Decisions: Checkout Feature (Screens 47, 48, 49, 50)

**Feature**: `specs/009-checkout` | **Date**: 2026-09-24

This document establishes the technical decisions, architectural patterns, and trade-offs for the **Checkout** feature.

---

## 1. Screen Unification Strategy: Screens 47 and 49

- **Decision**: Implement a single, unified `CheckoutPage` controlled by `CheckoutCubit` that represents both Screen 47 (undiscounted checkout summary) and Screen 49 (checkout summary with voucher applied).
- **Rationale**:
  - Screen 47 and Screen 49 are identical in layout, content, and component structure, with exactly one difference: in Screen 47, the voucher action is an outlined pill button labeled "Add Voucher", whereas in Screen 49, it is rendered as a solid blue badge labeled `5% Discount ✕` (or applicable voucher percentage).
  - Tapping `✕` on the voucher badge dispatches `CheckoutCubit.removeVoucher()`, seamlessly recalculating the total and transitioning the UI back to the Screen 47 presentation without page reload.
  - This avoids code duplication, simplifies route management in `go_router`, and maintains reactive UI state continuity.
- **Alternatives Considered**:
  - *Separate GoRoutes (`/checkout` and `/checkout/voucher-applied`)*: Rejected because voucher application is a local session state, not a different route destination.

---

## 2. Modal Bottom Sheets Architecture: Screens 48 and 50

- **Decision**: Implement Screen 48 (`VoucherBottomSheet`) and Screen 50 (`EditShippingAddressSheet`) as modal bottom sheets invoked via `showModalBottomSheet` with custom rounded top shapes (`24.r`).
- **Rationale**:
  - Both screens in Figma are modal sheets sliding up from the bottom with semi-transparent backdrop overlay and circular `✕` dismiss buttons.
  - In `VoucherBottomSheet`, tapping "Apply" dispatches `CheckoutCubit.applyVoucher(voucher)` and closes the sheet via `Navigator.of(context).pop()`.
  - In `EditShippingAddressSheet`, address fields are initialized with the current values. Upon editing and closing (or tapping `✕`), `CheckoutCubit.updateShippingAddress(...)` persists the changes to in-memory state and updates the summary card.
- **Alternatives Considered**:
  - *Full-page routes for voucher and address*: Rejected because Figma explicitly specifies modal bottom sheets over the checkout page.

---

## 3. Strict Design Token Enforcement & Token Addition (Rule #11)

- **Decision**: Strictly reference `AppColors`, `AppSpacing`, and `AppTypography`. Introduce `AppColors.primarySoft = Color(0xFFEBF1FF)` for light-blue surface containers and input fields.
- **Rationale**:
  - Rule #11 prohibits hardcoded colors, spacing, or typography.
  - The design references use a soft light-blue tint for:
    1. Selected shipping option container on Screen 47/49.
    2. Selected payment method chip container on Screen 47/49.
    3. Item variant pills on the items list.
    4. Address, Town / City, and Postcode text field backgrounds on Screen 50.
  - `AppColors.primary50` (`#BFD2FF`) is more saturated and darker than the subtle background tint required. Adding `primarySoft = Color(0xFFEBF1FF)` provides an exact token match while preserving centralized theming.

---

## 4. In-Memory Mutable State Store (Phase 1)

- **Decision**: Manage checkout state in-memory inside `CheckoutMockDataSourceImpl` with simulated latency (`Future.delayed`).
- **Rationale**:
  - Complies with Constitution Principle VI and Permanent Rule 8 (Mock Data only for Phase 1).
  - In-memory mutation supports interactive voucher application, voucher removal, shipping option toggling, and shipping address updates with real-time reactive total calculation.
  - `CheckoutRepository` interface returns `Future<Either<Failure, CheckoutSummaryEntity>>` using `dartz` and `safeCall`, making it ready for real API integration in Phase 2.

---

## 5. Architectural Boundary: Decoupling Checkout from Payment

- **Decision**: Strictly bound the `checkout` feature to Screens 47–50. Do not implement payment execution screens (Screens 51–56).
- **Rationale**:
  - Follows Single Responsibility Principle (SRP) and separation of concerns.
  - Order preparation (address, voucher, shipping options) is decoupled from payment gateway processing (Stripe, PayPal, card tokens, PCI-DSS compliance).
  - The "Payment Method" chips on Screen 47 serve as a visual selection preview; tapping "Pay" routes to `/payment`, handing off execution to the future payment feature.
