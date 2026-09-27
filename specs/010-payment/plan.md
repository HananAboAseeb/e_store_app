# Implementation Plan: Payment Feature (Screens 51, 52, 53, 54, 55, 56)

**Branch**: `010-payment` | **Date**: 2026-09-25 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `specs/010-payment/spec.md` and Figma reference screenshots `51 CHOOSE PAYMENT METHOD 1 CARD.png`, `52 CHOOSE PAYMENT METHOD 2 CARDS.png`, `53 CHOOSE PAYMENT METHOD PAYPAL.png`, `54 PAYMENT IN PROGRESS.png`, `55 COULDNT PROCEED PAYMENT.png`, and `56 CARD HAS BEEN CHARGED.png`. Part 3 of the Cart & Checkout & Payment lifecycle.

---

## Summary

Implement the standalone **Payment** feature covering Screens 51 to 56:
1. **Screen 51 & 52 (Payment Method Bottom Sheet - Cards)**: Modal bottom sheet (`24.r`) displaying saved cards (Mastercard with `AppColors.primarySoft`, Visa with `AppColors.blushSoft`) in a horizontally scrolling list, card settings icon, and vertical rectangular Add Card button (`+`).
2. **Screen 53 (Payment Method Bottom Sheet - PayPal)**: Modal bottom sheet view displaying centered PayPal brand logo, instruction text, and blue pill "OK" button.
3. **Screen 54 (Payment In Progress Modal)**: Centered non-dismissible modal dialog (`24.r`) with circular progress spinner, title, and subtitle simulating gateway execution.
4. **Screen 55 (Couldn't Proceed Payment Failure Modal)**: Centered modal dialog with exclamation badge (`!`), error explanation, black pill "Try Again" button, and grey pill "Change" button.
5. **Screen 56 (Card Has Been Charged Success Modal)**: Centered modal dialog with blue checkmark badge (`✓`), confirmation text, and grey pill "Track your Order" button.

Strictly follows Feature-First Clean Architecture (`lib/features/payment/`), Cubit state management with Equatable, GetIt DI, `go_router` navigation, and strict design token enforcement (Rule #11).

---

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.44.6 (FVM)  
**Primary Dependencies**: `flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`  
**Storage**: Mock Data with in-memory mutable state and simulated gateway latency (Phase 1 UI-only)  
**Testing & Verification**: Static analysis and tests strictly deferred to final phase per Permanent Rule 1  
**Target Platform**: iOS & Android  
**Design Reference**: Figma screenshots 51, 52, 53, 54, 55, 56 in `assets/design_references/`  
**Performance Goals**: 60 FPS smooth animations, dialog transitions <100ms, zero layout overflows  
**Token Strictness**: Strict color & token enforcement (Rule #11). All colors, spacing, and typography reference `AppColors`, `AppSpacing`, `AppTypography`. Missing tokens (`blushSoft`, `visaBlue`, `mastercardRed`, `mastercardYellow`, `paypalBlue`) will be added to `lib/core/theme/app_colors.dart` first.

---

## Constitution Check

| Principle / Rule | Requirement | Compliance Status |
|---|---|---|
| **I. Architecture Preservation** | Follow `lib/features/`, `lib/core/`, `lib/config/` structure | ✅ PASS: Uses `lib/features/payment/` matching canonical architecture |
| **II. Clean Architecture & Safety** | Decoupled domain, `Either<Failure, T>` via `dartz`, `safeCall` in repo impl | ✅ PASS: Explicit domain/data/presentation boundaries with error handling |
| **III. Design Tokens & Pixel Perfection** | `AppColors`, `AppSpacing`, `AppTypography`, `flutter_screenutil` dimensions | ✅ PASS: 100% token usage and `.w, .h, .r, .sp` scaling |
| **IV. Strict UI & State Separation** | Cubit state management, Equatable states, shimmer loading | ✅ PASS: `PaymentCubit` with Equatable states; pure declarative widgets; shimmer loading |
| **V. Router & Shell Navigation** | Registered in `go_router`, clean push/pop | ✅ PASS: `/payment` route registered with clean modal presentation over checkout |
| **Permanent Rules 1–10** | Deferred verification, no new assets, mock data only, widget reuse | ✅ PASS: Reuses existing assets and widgets (`PrimaryButton`); mock gateway simulation |
| **Rule 11 (Strict Token Enforcement)** | All colors/spacing/typography must use tokens; add missing tokens first | ✅ PASS: Adds missing brand/surface colors to `app_colors.dart` before UI development |
| **Rule 12 (FVM CLI Commands)** | Use `fvm flutter` for all verification commands | ✅ PASS: FVM-only CLI execution enforced |

---

## Project Structure

### Documentation Artifacts
```text
specs/010-payment/
├── spec.md                  # Feature specification
├── plan.md                  # Implementation plan (this file)
├── research.md              # Technical decisions & trade-offs
├── data-model.md            # Domain entities, models, and UI states
├── quickstart.md            # Validation scenarios & step-by-step verification
├── contracts/
│   └── payment_contracts.md # Repository, UseCase, DataSource, and Cubit contracts
└── checklists/
    └── requirements.md      # Specification quality checklist
```

### Source Code Organization (`lib/features/payment/`)

```text
lib/features/payment/
├── payment_injection.dart                              # DI registration for Payment feature
├── data/
│   ├── datasources/
│   │   ├── payment_mock_data_source.dart               # Data source contract
│   │   └── payment_mock_data_source_impl.dart          # Mock cards & gateway simulation
│   ├── models/
│   │   ├── payment_method_model.dart                   # Model for payment method
│   │   └── payment_result_model.dart                   # Model for payment outcome
│   └── repositories/
│       └── payment_repository_impl.dart                # Repository impl wrapping safeCall
├── domain/
│   ├── entities/
│   │   ├── payment_method_entity.dart                  # Saved payment method entity
│   │   └── payment_result_entity.dart                  # Transaction result entity
│   ├── repositories/
│   │   └── payment_repository.dart                     # Repository interface contract
│   └── usecases/
│       ├── get_payment_methods_usecase.dart            # Load saved cards & options
│       ├── process_payment_usecase.dart                # Process transaction
│       └── add_payment_method_usecase.dart             # Add card placeholder
└── presentation/
    ├── manager/
    │   ├── payment_cubit.dart                          # Business logic & flow orchestration
    │   └── payment_state.dart                          # Immutable Equatable states
    ├── pages/
    │   └── payment_page.dart                           # Host page / overlay controller
    └── widgets/
        ├── payment_method_sheet.dart                   # Screens 51, 52, 53 bottom sheet
        ├── payment_card_item.dart                      # Mastercard & Visa card widget
        ├── add_card_button.dart                        # Vertical rectangular "+" button
        ├── paypal_redirect_content.dart                # Screen 53 PayPal redirect body
        ├── payment_processing_modal.dart               # Screen 54 non-dismissible dialog
        ├── payment_failure_modal.dart                  # Screen 55 failure dialog
        ├── payment_success_modal.dart                  # Screen 56 success dialog
        └── payment_shimmer_loading.dart                # Shimmer loading skeleton
```

---

## Technical Decisions Summary

1. **Standalone Feature Boundary**: `payment` is strictly isolated from `checkout` per SRP and PCI-DSS compliance. Checkout initiates `/payment`, while Payment handles selection, gateway simulation, and authorization results.
2. **Modal Overlay Architecture**: Screens 51–53 are modal bottom sheets (`PaymentMethodSheet`). Screens 54–56 are centered modal dialogs with backdrop blur. Screen 54 is non-dismissible (`barrierDismissible: false`).
3. **Single Cubit Flow Orchestration**: `PaymentCubit` controls method selection, processing initiation, retry, method switching, and success completion.
4. **Token Strictness (Rule #11)**: Prior to widget building, add `blushSoft`, `visaBlue`, `mastercardRed`, `mastercardYellow`, and `paypalBlue` tokens to `AppColors`.
5. **Phase 1 Mock Simulation**: 2-3 second latency with controllable success/failure simulation in `PaymentMockDataSourceImpl`.
