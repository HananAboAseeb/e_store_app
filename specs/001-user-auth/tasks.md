---

description: "Task list for User Authentication (Auth) feature implementation"
---

# Tasks: User Authentication (Auth) Flow

**Input**: Design documents from `specs/001-user-auth/` (`spec.md`, `plan.md`, `data-model.md`, `contracts/auth-contracts.md`, `research.md`, `quickstart.md`)  
**Prerequisites**: `plan.md` (required), `spec.md` (required)

---

## Format: `- [ ] [ID] [P?] [Story?] Description with file path`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3...)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure & Design Tokens)

**Purpose**: Scaffold feature module and establish Figma design system tokens and shared UI components.

- [X] T001 Scaffold Auth feature structure using Mason brick (`mason make feature --feature_name auth --entity_name User`) in `lib/features/auth/`
- [X] T002 [P] Create Figma color tokens in `lib/core/theme/app_colors.dart`
- [X] T003 [P] Create responsive spacing tokens in `lib/core/theme/app_spacing.dart`
- [X] T004 [P] Create typography text styles in `lib/core/theme/app_typography.dart`
- [X] T005 [P] Create main theme exporter in `lib/core/theme/app_theme.dart`
- [X] T006 [P] Build PrimaryButton component in `lib/shared/widgets/primary_button.dart`
- [X] T007 [P] Build AuthTextField component in `lib/shared/widgets/auth_text_field.dart`
- [X] T008 [P] Build PhoneInputField component with country flag & dropdown in `lib/features/auth/presentation/widgets/phone_input_field.dart`
- [X] T009 [P] Build AuthHeader component in `lib/features/auth/presentation/widgets/auth_header.dart`
- [X] T010 [P] Build TextLink component in `lib/shared/widgets/text_link.dart`
- [X] T011 [P] Build SelectionCard component in `lib/features/auth/presentation/widgets/selection_card.dart`
- [X] T012 [P] Build OnboardingCard component in `lib/features/auth/presentation/widgets/onboarding_card.dart`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Domain entities, repository interfaces, use cases, mock data layer, and Cubit state management.

**⚠️ CRITICAL**: Must be completed before page-level UI wiring begins.

- [X] T013 Create UserEntity extending Equatable in `lib/features/auth/domain/entities/user_entity.dart`
- [X] T014 [P] Create CountryCodeEntity in `lib/features/auth/domain/entities/country_code_entity.dart`
- [X] T015 Define AuthRepository interface contract in `lib/features/auth/domain/repositories/auth_repository.dart`
- [X] T016 Create LoginUseCase in `lib/features/auth/domain/usecases/login_usecase.dart`
- [X] T017 [P] Create RegisterUseCase in `lib/features/auth/domain/usecases/register_usecase.dart`
- [X] T018 [P] Create VerifyOtpUseCase in `lib/features/auth/domain/usecases/verify_otp_usecase.dart`
- [X] T019 [P] Create ForgotPasswordUseCase in `lib/features/auth/domain/usecases/forgot_password_usecase.dart`
- [X] T020 [P] Create ResetPasswordUseCase in `lib/features/auth/domain/usecases/reset_password_usecase.dart`
- [X] T021 Create UserModel data model extending UserEntity with JSON methods in `lib/features/auth/data/models/user_model.dart`
- [X] T022 Create AuthRemoteDataSource mock implementation with 1-2s delay in `lib/features/auth/data/datasources/auth_remote_datasource.dart`
- [X] T023 Implement AuthRepositoryImpl wrapping remote calls with safeCall in `lib/features/auth/data/repositories/auth_repository_impl.dart`
- [X] T024 Create AuthState classes extending Equatable in `lib/features/auth/presentation/cubit/auth_state.dart`
- [X] T025 Implement AuthCubit in `lib/features/auth/presentation/cubit/auth_cubit.dart`

**Checkpoint**: Core foundation ready — page implementation can now begin.

---

## Phase 3: User Story 1 - App Onboarding & Start Entry (Priority: P1) 🎯 MVP

**Goal**: Welcoming start page introducing ShopX with action buttons to navigate to registration or login.

**Independent Test**: Navigate to `/start`, verify ShopX logo, title, subtitle, "Get Started" button, and "Login" link, and confirm tapping triggers correct route transitions.

- [X] T026 [US1] Create ShopXLogo branding widget in `lib/features/auth/presentation/widgets/shopx_logo.dart`
- [X] T027 [US1] Implement StartPage layout & navigation triggers in `lib/features/auth/presentation/pages/start_page.dart`

**Checkpoint**: User Story 1 fully functional and testable independently.

---

## Phase 4: User Story 2 - User Login (Priority: P1)

**Goal**: Allow returning users to log into their account with email and password.

**Independent Test**: Navigate to `/login`, enter credentials, toggle password visibility, tap "Next", observe mock loading, and verify navigation to `/home`.

- [X] T028 [US2] Implement LoginPage layout and form controls in `lib/features/auth/presentation/pages/login_page.dart`
- [X] T029 [US2] Connect LoginPage forms to AuthCubit.login() and handle state transitions in `lib/features/auth/presentation/pages/login_page.dart`

**Checkpoint**: User Stories 1 and 2 work independently.

---

## Phase 5: User Story 3 - User Registration & Account Creation (Priority: P1)

**Goal**: Allow new users to register an account with email, password, and phone number.

**Independent Test**: Navigate to `/register`, fill form, tap "Next", observe loading indicator, and verify navigation to `/verification`.

- [X] T030 [US3] Implement RegisterPage layout with phone country dropdown in `lib/features/auth/presentation/pages/register_page.dart`
- [X] T031 [US3] Connect RegisterPage form to AuthCubit.register() and navigate to `/verification` in `lib/features/auth/presentation/pages/register_page.dart`

---

## Phase 6: User Story 4 - OTP Code Verification (Priority: P1)

**Goal**: Enter 4-digit verification code using a custom numeric keypad with auto-submit, success/error visual feedback, and 47s resend countdown.

**Independent Test**: Navigate to `/verification`, type digits on custom keypad, verify 4th digit auto-submit, check green success / red error box states, and test 47s countdown timer.

- [ ] T032 [P] [US4] Build PinInput widget with 4 box fill/active/success/error states in `lib/features/auth/presentation/widgets/pin_input.dart`
- [ ] T033 [P] [US4] Build NumericKeyboard widget with 3x4 grid and timer in `lib/features/auth/presentation/widgets/numeric_keyboard.dart`
- [ ] T034 [US4] Implement VerificationPage layout combining PinInput, NumericKeyboard, and timer in `lib/features/auth/presentation/pages/verification_page.dart`
- [ ] T035 [US4] Connect VerificationPage to AuthCubit.verifyOtp() with 4th-digit auto-submit and error shake state in `lib/features/auth/presentation/pages/verification_page.dart`

---

## Phase 7: User Story 5 - Password Recovery Channel Selection (Priority: P2)

**Goal**: Allow users to select SMS or Email channel for password restoration.

**Independent Test**: Navigate to `/forgot-password`, select SMS/Email option card, tap "Next", and verify navigation to `/verification`.

- [ ] T036 [US5] Implement ForgotPasswordPage layout with SelectionCard choices in `lib/features/auth/presentation/pages/forgot_password_page.dart`
- [ ] T037 [US5] Connect ForgotPasswordPage to AuthCubit.forgotPassword() and trigger navigation in `lib/features/auth/presentation/pages/forgot_password_page.dart`

---

## Phase 8: User Story 6 - Reset Password (Priority: P2)

**Goal**: Allow verified users to set a new password.

**Independent Test**: Navigate to `/reset-password`, enter matching passwords, tap "Save", and verify navigation to `/login`.

- [ ] T038 [US6] Implement ResetPasswordPage layout with new password fields in `lib/features/auth/presentation/pages/reset_password_page.dart`
- [ ] T039 [US6] Connect ResetPasswordPage to AuthCubit.resetPassword() and handle redirect in `lib/features/auth/presentation/pages/reset_password_page.dart`

---

## Phase 9: User Story 7 - Security Limits & Maximum Attempts Dialog (Priority: P3)

**Goal**: Display rate limit error dialog when recovery attempts are exceeded.

**Independent Test**: Navigate to `/error/max-attempts`, verify dark overlay card, and dismiss with "Okay" button.

- [ ] T040 [US7] Implement MaxAttemptsErrorPage layout and dismissal callback in `lib/features/auth/presentation/pages/max_attempts_error_page.dart`

---

## Phase 10: User Story 8 - Welcome & Onboarding Carousel (Priority: P3)

**Goal**: Interactive onboarding slides introducing ShopX before main app entry.

**Independent Test**: Navigate to `/welcome`, page through slides, check 3-dot pagination, and tap "Let's Start" to navigate to `/home`.

- [ ] T041 [US8] Implement WelcomePage carousel combining OnboardingCards and dot indicators in `lib/features/auth/presentation/pages/welcome_page.dart`

---

## Phase 11: Routing & Dependency Injection Wiring

**Purpose**: Wire all 8 routes and DI container registrations.

- [ ] T042 Register 8 Auth routes (`/start`, `/login`, `/register`, `/verification`, `/forgot-password`, `/reset-password`, `/welcome`, `/error/max-attempts`) in `lib/config/routing/app_router.dart`
- [ ] T043 Configure GetIt DI registrations in `lib/features/auth/auth_injection.dart` and call `initAuth()` in `lib/core/di/injection_container.dart`
- [ ] T044 Update initial application route to `/start` for Phase 1 testing in `lib/config/routing/app_router.dart`

---

## Phase 12: Polish, Verification & Testing

**Purpose**: Automated test suite and UI verification against Figma tokens.

- [ ] T045 [P] Write widget tests for StartPage, LoginPage, and RegisterPage in `test/features/auth/presentation/pages/auth_pages_test.dart`
- [ ] T046 [P] Write widget tests for VerificationPage and OTP keypad interaction in `test/features/auth/presentation/pages/verification_page_test.dart`
- [ ] T047 [P] Write Cubit unit tests for AuthCubit state transitions in `test/features/auth/presentation/cubit/auth_cubit_test.dart`
- [ ] T048 Run quickstart validation scenarios and verify 60 FPS UI rendering

---

## Dependencies & Execution Order

### Phase Dependencies
- **Setup (Phase 1)**: No dependencies — start immediately.
- **Foundational (Phase 2)**: Depends on Setup completion — BLOCKS all user story pages.
- **User Stories (Phases 3-10)**: Depend on Foundational completion. Can proceed sequentially in priority order (P1 → P2 → P3).
- **Routing & DI (Phase 11)**: Depends on Pages (Phases 3-10) completion.
- **Testing (Phase 12)**: Depends on Routing & DI completion.

### Parallel Opportunities
- Setup tasks T002–T012 can run in parallel.
- Foundational tasks T014, T017–T020 can run in parallel.
- Component tasks T032–T033 can run in parallel within User Story 4.
- Test tasks T045–T047 can run in parallel.

---

## Implementation Strategy: MVP First

1. Complete Phase 1: Setup & Design Tokens
2. Complete Phase 2: Foundational (Entities, Data, Cubit)
3. Complete Phase 3: User Story 1 (Start Page)
4. **VALIDATE MVP**: Launch app, test `/start` navigation independently.
5. Sequentially deliver User Stories 2 through 8.
6. Wire Routing/DI and run test suite.
