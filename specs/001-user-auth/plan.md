# Implementation Plan: User Authentication (Auth) Flow

**Branch**: `001-user-auth` | **Date**: 2026-08-10 | **Spec**: [spec.md](file:///e:/e_store/e_store/specs/001-user-auth/spec.md)

**Input**: Feature specification from `/specs/001-user-auth/spec.md`

---

## Summary

Build the complete Phase 1 User Authentication (Auth) UI flow consisting of 12 screens and shared components using mock data (1-2s delay), full Figma design token integration, Cubit state management, Clean Architecture layering, and `go_router` routing.

---

## Technical Context

**Language/Version**: Dart 3.11+ / Flutter 3.11+  
**Primary Dependencies**: `flutter_bloc` (Cubit), `get_it`, `dartz`, `go_router`, `flutter_screenutil`, `equatable`, `shimmer`  
**Storage**: In-memory mock remote data source (`AuthRemoteDataSource`)  
**Testing**: `flutter_test` (Widget tests & Cubit unit tests)  
**Target Platform**: Mobile (iOS & Android)  
**Project Type**: Mobile App (Clean Architecture feature module)  
**Performance Goals**: 60 FPS UI rendering, sub-100ms response to touch, 1-2s simulated async delay for mock operations  
**Constraints**: Pixel-perfect match to Figma ShopX tokens, 0 business logic in widgets, `Either<Failure, T>` with `safeCall` in repository  
**Scale/Scope**: 12 Auth UI screens, 8 route endpoints, 8 reusable auth widgets  

---

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Existing Architecture Preservation**: ✅ PASS — Module placed under `lib/features/auth/` following the existing `home` feature pattern.
- **Clean Architecture & Data Safety**: ✅ PASS — `presentation → domain ← data` layering, `Either<Failure, T>` use cases, `safeCall` in repo impl, DI via `GetIt`.
- **Figma Pixel-Perfection & Design Tokens**: ✅ PASS — Design tokens configured in `lib/core/theme/` and all dimensions using `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`).
- **UI & State Separation**: ✅ PASS — Widgets purely declarative; Cubit manages states; `Equatable` for states/entities; `shimmer` for async loading.
- **Router & Shell Navigation**: ✅ PASS — 8 route definitions in `go_router` (`app_router.dart`).
- **Scaffolding & Quality Gates**: ✅ PASS — Feature created with Mason bricks; backed by widget tests.

---

## Project Structure

### Documentation (this feature)

```text
specs/001-user-auth/
├── plan.md              # Implementation plan
├── research.md          # Architectural research & decisions
├── data-model.md        # Entities, models, parameters
├── quickstart.md        # Manual & automated verification guide
├── contracts/           # Repository & component contracts
└── tasks.md             # Actionable task list
```

### Source Code (`lib/features/auth/` & Core Directories)

```text
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart         # Figma ShopX color tokens
│   │   ├── app_spacing.dart        # Spacing scale tokens
│   │   └── app_typography.dart     # Typography tokens
│   └── di/
│       └── injection_container.dart # Global DI container
├── shared/
│   └── widgets/                    # Shared app-wide widgets
└── features/
    └── auth/
        ├── auth_injection.dart     # Auth DI setup
        ├── data/
        │   ├── datasources/
        │   │   └── auth_remote_datasource.dart
        │   ├── models/
        │   │   └── user_model.dart
        │   └── repositories/
        │       └── auth_repository_impl.dart
        ├── domain/
        │   ├── entities/
        │   │   ├── user_entity.dart
        │   │   └── country_code_entity.dart
        │   ├── repositories/
        │   │   └── auth_repository.dart
        │   └── usecases/
        │       ├── login_usecase.dart
        │       ├── register_usecase.dart
        │       ├── verify_otp_usecase.dart
        │       ├── forgot_password_usecase.dart
        │       └── reset_password_usecase.dart
        └── presentation/
            ├── cubit/
            │   ├── auth_cubit.dart
            │   └── auth_state.dart
            ├── pages/
            │   ├── start_page.dart
            │   ├── login_page.dart
            │   ├── register_page.dart
            │   ├── verification_page.dart
            │   ├── forgot_password_page.dart
            │   ├── reset_password_page.dart
            │   ├── max_attempts_error_dialog.dart
            │   └── welcome_page.dart
            └── widgets/
                ├── primary_button.dart
                ├── auth_text_field.dart
                ├── phone_input_field.dart
                ├── auth_header.dart
                ├── text_link.dart
                ├── pin_input.dart
                ├── numeric_keyboard.dart
                ├── selection_card.dart
                └── onboarding_card.dart
```

---

## Detailed Task Breakdown

### Phase 1A: Foundation & Shared Components
- **Task 1**: Generate auth feature structure using Mason brick (`mason make feature --feature_name auth --entity_name User`).
- **Task 2**: Create design tokens (`app_colors.dart`, `app_spacing.dart`, `app_typography.dart`).
- **Task 3**: Create reusable Auth widgets (`PrimaryButton`, `AuthTextField`, `PhoneInputField`, `AuthHeader`, `TextLink`, `PinInput`, `NumericKeyboard`, `SelectionCard`, `OnboardingCard`).

### Phase 1B: Domain Layer
- **Task 4**: Create `UserEntity` and `CountryCodeEntity` (extending `Equatable`).
- **Task 5**: Define `AuthRepository` abstract contract.
- **Task 6**: Create UseCases (`LoginUseCase`, `RegisterUseCase`, `VerifyOtpUseCase`, `ForgotPasswordUseCase`, `ResetPasswordUseCase`).

### Phase 1C: Data Layer (Mock Implementation)
- **Task 7**: Create `UserModel` extending `UserEntity`.
- **Task 8**: Implement `AuthRemoteDataSource` with 1-2s mock delay.
- **Task 9**: Implement `AuthRepositoryImpl` wrapping calls with `safeCall`.

### Phase 1D: Presentation Layer
- **Task 10**: Create `AuthCubit` and `AuthState`.
- **Tasks 11-18**: Build 8 Page Views (`StartPage`, `LoginPage`, `RegisterPage`, `VerificationPage`, `ForgotPasswordPage`, `ResetPasswordPage`, `MaxAttemptsErrorDialog`, `WelcomePage`).

### Phase 1E: Routing & DI Wiring
- **Task 19**: Register 8 auth routes in `app_router.dart`.
- **Task 20**: Register DI in `auth_injection.dart` and wire into `injection_container.dart`.
- **Task 21**: Set initial route to `/start`.

### Phase 1F: Verification & Testing
- **Task 22**: Implement widget tests in `test/features/auth/presentation/pages/`.
- **Task 23**: Implement Cubit unit tests in `test/features/auth/presentation/cubit/`.
