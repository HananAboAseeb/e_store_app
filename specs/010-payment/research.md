# Research & Technical Decisions: Payment Feature (Screens 51, 52, 53, 54, 55, 56)

**Feature**: `specs/010-payment` | **Date**: 2026-09-25

This document establishes the technical decisions, architectural patterns, and trade-offs for the **Payment** feature.

---

## 1. Standalone Feature Isolation & Checkout Decoupling

- **Decision**: Isolate `payment` as an independent feature module under `lib/features/payment/`, separate from `checkout` (`lib/features/checkout/`).
- **Rationale**:
  - **Single Responsibility Principle (SRP)**: Checkout manages order preparation (items, vouchers, shipping address, delivery options). Payment handles transaction execution, gateway handshakes, sensitive credentials, and authorization results.
  - **Security & Compliance (PCI-DSS)**: Payment components and future payment SDKs (Stripe, PayPal, Apple Pay) must be isolated to prevent credential leakage into shopping cart and order data flows.
  - **API Isolation & Replaceability**: Mock Phase 1 implementation can be swapped for Stripe/PayPal SDK integrations in Phase 2 without altering checkout logic.
  - **Clear Navigation Boundary**: Tapping "Pay" on Screen 47/49 routes to `/payment`.
- **Alternatives Considered**:
  - *Embedding Payment inside `lib/features/checkout/`*: Rejected to avoid bloated controllers and tight coupling between cart state and financial transaction state.

---

## 2. Modal Presentation & Overlay Management Strategy

- **Decision**: Implement Screens 51–53 as a modal bottom sheet (`PaymentMethodSheet`) and Screens 54–56 as modal dialogs (`PaymentProcessingModal`, `PaymentFailureModal`, `PaymentSuccessModal`) presented over a lightweight `PaymentPage` (or transparent backdrop over `CheckoutPage`).
- **Rationale**:
  - **Screen 51 & 52 (Card List)**: Screen 52 is a horizontal scroll state of Screen 51. Both belong to a single `PaymentMethodSheet` widget with horizontal scrolling cards.
  - **Screen 53 (PayPal View)**: Tapping the PayPal option switches the sheet content to `PayPalRedirectContent`, keeping the header "Payment Methods" and circular `✕` intact.
  - **Screen 54 (Processing)**: Non-dismissible dialog (`barrierDismissible: false`, `PopScope(canPop: false)`) showing circular progress indicator. Prevents double-taps and user cancellation during active payment settlement.
  - **Screen 55 (Failure)**: Center dialog with two side-by-side pill buttons: "Try Again" (black pill button, restarts processing) and "Change" (grey pill button, dismisses dialog and re-opens `PaymentMethodSheet`).
  - **Screen 56 (Success)**: Center dialog with "Track your Order" button (grey pill button) that navigates to `/orders/:id` and clears modal history from the navigation stack.
- **Alternatives Considered**:
  - *Full-page routes for each modal*: Rejected because Figma references explicitly specify floating modal overlays over a blurred/dimmed background.

---

## 3. Cubit State Machine & Lifecycle Management

- **Decision**: Manage the entire payment flow using a single `PaymentCubit` with distinct immutable `Equatable` states.
- **State Progression**:
  1. `PaymentInitial`: Base state before initialization.
  2. `PaymentLoadingMethods`: Fetching saved payment methods with shimmer placeholders.
  3. `PaymentMethodSelection`: Saved cards and PayPal options available; user selects a card or PayPal.
  4. `PaymentProcessing`: Gateway simulation active (triggers Screen 54 dialog).
  5. `PaymentFailure`: Processing failed with error message (triggers Screen 55 dialog).
  6. `PaymentSuccess`: Payment charged successfully with order reference (triggers Screen 56 dialog).
- **Key Methods**:
  - `loadPaymentMethods()`: Fetches saved methods from repository.
  - `selectPaymentMethod(PaymentMethodEntity method)`: Updates selected method.
  - `processPayment(PaymentMethodEntity method, double amount)`: Invokes use case with simulated delay.
  - `retryPayment()`: Re-attempts processing with current method.
  - `changePaymentMethod()`: Resets to `PaymentMethodSelection` state.
  - `reset()`: Clears payment session.

---

## 4. Strict Design Token Enforcement (Rule #11)

- **Decision**: Add required brand and surface tokens to `lib/core/theme/app_colors.dart` before widget implementation:
  - `blushSoft = Color(0xFFFFECEB)`: Soft blush pink background for the Visa card (Screen 52).
  - `visaBlue = Color(0xFF1A1F71)`: Dark navy blue for Visa branding logo.
  - `mastercardRed = Color(0xFFEB001B)`: Mastercard red circle logo.
  - `mastercardYellow = Color(0xFFF79E1B)`: Mastercard yellow/orange circle logo.
  - `paypalBlue = Color(0xFF0079C1)`: PayPal brand blue icon background.
- **Rationale**:
  - Permanent Rule 11 mandates: "All colors MUST use `AppColors` tokens. If a token is missing: ADD it to the tokens file FIRST, then use it. NO `Color(0xFF...)` or `Colors.blue` inline anywhere."
  - Using semantic constants prevents design drift and enables centralized dark mode support.

---

## 5. Mock Gateway & Latency Simulation (Phase 1)

- **Decision**: `PaymentMockDataSourceImpl` manages in-memory mock cards and returns a simulated 2–3 second delayed response with togglable/alternating success and failure outcomes for comprehensive manual verification.
- **Rationale**:
  - Complies with Permanent Rule 8 (Mock Data only in Phase 1).
  - Simulating both success (Screen 56) and failure (Screen 55) allows QA and manual verification of all acceptance criteria, retry flows, and error handling.
  - Real Stripe and PayPal SDKs will be integrated in Phase 2 behind the same `PaymentRepository` contract without modifying UI widgets.
