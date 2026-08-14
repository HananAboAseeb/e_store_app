# Research Document: User Authentication (Auth) Flow

**Feature Branch**: `001-user-auth`  
**Date**: 2026-08-10  
**Spec**: [spec.md](file:///e:/e_store/e_store/specs/001-user-auth/spec.md)

---

## 1. Architectural Design & Folder Layout

### Decision
Extend the existing project structure under `lib/features/auth/` using the Mason brick `mason make feature --feature_name auth --entity_name User`.

### Rationale
Adheres strictly to Principle I and II of the Project Constitution. The feature structure establishes clean boundary separation:
- `lib/features/auth/domain/`: Pure Dart domain logic (`UserEntity`, `AuthRepository` contract, 5 use cases).
- `lib/features/auth/data/`: Data models (`UserModel`), mock remote data source (`AuthRemoteDataSource`), and repository implementation (`AuthRepositoryImpl` with `safeCall`).
- `lib/features/auth/presentation/`: `AuthCubit`, `AuthState`, 8 page views, and sub-components.
- `lib/features/auth/auth_injection.dart`: Modular Dependency Injection setup wired to `lib/core/di/injection_container.dart`.

### Alternatives Considered
- *Single-layer screen widgets*: Rejected because it violates Clean Architecture principles and mixes UI with state management.

---

## 2. Design System Tokens & Sizing Extensions

### Decision
Define explicit design tokens in `lib/core/theme/` (or `lib/config/theme/`) utilizing `flutter_screenutil` responsive sizing extensions (`.w`, `.h`, `.r`, `.sp`).

### Rationale
Adheres strictly to Principle III of the Project Constitution. Material Design default styles are replaced with exact Figma ShopX tokens:
- **Colors**: Primary 400 (`#004BFE`), Surface (`#F5F5F5`), Border (`#E5E5E5`), Success (`#34C759`), Error (`#FF3B30`).
- **Radii**: Buttons/Inputs (`12.r`), Cards (`16.r`), Pin Boxes (`8.r`).
- **Typography**: H1 (`28.sp`, bold), H2 (`22.sp`, w600), Body (`16.sp`, normal), Button (`16.sp`, w600).

---

## 3. Custom OTP Pin Input & Numeric Keyboard Mechanics

### Decision
Implement `PinInput` and `NumericKeyboard` as controlled presentation widgets.

### Rationale
Providing an on-screen 3x4 numeric keypad with a 4-box PIN display allows precise control over user entry:
- Each key tap appends a digit to the local or Cubit PIN state up to 4 digits.
- 4th digit auto-triggers `AuthCubit.verifyOtp(...)`.
- Success state displays green border (`#34C759`) and checkmark; Error state triggers red border (`#FF3B30`) with shake animation and retains numeric keypad.
- A 47-second countdown timer runs concurrently, unlocking the "Resend Code" link upon reaching zero.

---

## 4. State Management & Navigation Flow

### Decision
Use `AuthCubit` (`flutter_bloc`) registered with `GetIt` for all Auth states and `go_router` for route handling.

### Rationale
- `AuthCubit` manages states: `AuthInitial`, `AuthLoading`, `AuthSuccess`, `AuthError`, `AuthOtpSent`, `AuthOtpVerified`, `AuthPasswordReset`.
- `go_router` handles clean transitions across 8 routes: `/start`, `/login`, `/register`, `/verification`, `/forgot-password`, `/reset-password`, `/error/max-attempts`, `/welcome`.
