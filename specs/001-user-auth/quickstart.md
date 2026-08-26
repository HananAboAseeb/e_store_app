# Quickstart & Verification Guide: User Authentication (Auth)

**Feature Branch**: `001-user-auth`  
**Date**: 2026-08-10  
**Spec**: [spec.md](file:///e:/e_store/e_store/specs/001-user-auth/spec.md)

---

## Overview
This guide describes how to run and manually/automatically verify the 12 Auth UI screens built for Phase 1.

---

## 1. Environment Setup

```bash
# 1. Fetch dependencies
flutter pub get

# 2. Run code generation (for Envied / Hive / Mason if applicable)
dart run build_runner build --delete-conflicting-outputs
```

---

## 2. Launching the Auth Flow

Run the development app starting at the `/start` entry point:

```bash
flutter run --flavor dev -t lib/main_dev.dart
```

---

## 3. Manual Verification Steps

1. **Start Screen (`/start`)**:
   - Verify ShopX logo, title, subtitle, "Get Started" button, and "Login" link.
   - Tap "Get Started" -> verify transition to `/register`.
   - Tap "Login" -> verify transition to `/login`.

2. **Login Screen (`/login`)**:
   - Verify email/password fields with eye icon toggle.
   - Tap "Forgot Password?" -> verify transition to `/forgot-password`.
   - Fill email & password, tap "Next" -> observe 1-2s mock loading spinner, then navigate to `/home`.

3. **Register Screen (`/register`)**:
   - Fill email, password, phone number with country selector (`+1`).
   - Tap "Next" -> observe 1-2s mock loading spinner, then navigate to `/verification`.

4. **Verification Screen (`/verification`)**:
   - Verify 4 empty PIN boxes and custom 3x4 numeric keypad.
   - Type digits using the custom keypad -> verify box filling and active border color (`#004BFE`).
   - Test backspace key -> verify clearing digit.
   - Type 4th digit -> verify auto-submit loading state.
   - Test success (PIN != `0000`) -> verify green boxes (`#34C759`), checkmark icon, and navigation to `/home`.
   - Test error (PIN = `0000`) -> verify red boxes (`#FF3B30`), shake animation, and active keypad state.
   - Verify 47s countdown timer and "Resend Code" link activation.

5. **Password Recovery Screen (`/forgot-password`)**:
   - Verify SMS and Email selection cards.
   - Select SMS/Email card -> verify blue border highlight (`#004BFE`).
   - Tap "Next" -> verify navigation to `/verification`.

6. **Reset Password Screen (`/reset-password`)**:
   - Fill new password & repeat password.
   - Tap "Save" -> verify mock loading spinner and navigation to `/login`.

7. **Max Attempts Error Dialog (`/error/max-attempts`)**:
   - Verify dark transparent background overlay, warning icon, message, and "Okay" button.
   - Tap "Okay" -> verify dismissal and navigation back to `/login`.

8. **Welcome / Onboarding Screen (`/welcome`)**:
   - Verify white rounded card (`16.r`), illustration, text, and 3-dot indicators.
   - Page/swipe through slides -> verify active dot indicator movement.
   - Tap "Let's Start" on final slide -> verify navigation to `/home`.

---

## 4. Automated Testing Commands

```bash
# Run unit & Cubit tests
flutter test test/features/auth/presentation/cubit/auth_cubit_test.dart

# Run widget tests for all auth pages
flutter test test/features/auth/presentation/pages/
```
