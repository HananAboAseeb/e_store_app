# Feature Specification: User Authentication (Auth) Flow

**Feature Branch**: `001-user-auth`  
**Created**: 2026-08-10  
**Status**: Draft  
**Input**: User Authentication UI flow including Onboarding, Login, Registration, OTP Verification, Password Recovery, and Welcome screens (Phase 1: UI Only with Mock Data).

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - App Onboarding & Start Entry (Priority: P1)

As a new or returning user opening the app, I want a welcoming start screen that clearly introduces ShopX and lets me proceed to account creation or login.

**Why this priority**: Core entry point to the application authentication workflow.

**Independent Test**: Can be tested independently by navigating to `/start`, verifying layout, branding, and buttons, and confirming navigation triggers to `/register` or `/login`.

**Acceptance Scenarios**:

1. **Given** the user launches the app or navigates to `/start`, **When** the Start page renders, **Then** display a full-screen white background, centered ShopX logo (blue gradient shopping bag with "S"), title "ShopX", subtitle "Beautiful eCommerce UI Kit for your online store", full-width primary button "Get Started", and text link "Already have an Account? Login".
2. **Given** the user is on `/start`, **When** tapping "Get Started", **Then** navigate to `/register`.
3. **Given** the user is on `/start`, **When** tapping "Login", **Then** navigate to `/login`.

---

### User Story 2 - User Login (Priority: P1)

As a registered user, I want to enter my email and password to log into my account.

**Why this priority**: Essential functionality for returning users to access authenticated features.

**Independent Test**: Can be tested by navigating to `/login`, entering credentials, toggling password visibility, tapping "Next", and observing mock loading followed by navigation to `/home`.

**Acceptance Scenarios**:

1. **Given** the user is on `/login`, **When** viewing the screen, **Then** display top blue gradient decoration, H1 "Login", subtitle "Welcome back! Please enter your details", email field, password field with eye toggle, right-aligned "Forgot Password?" link, primary "Next" button, and centered "Cancel" link.
2. **Given** the user enters email and password, **When** tapping password eye icon, **Then** toggle password masking state between hidden and visible text.
3. **Given** invalid or empty fields on `/login`, **When** tapping "Next", **Then** display field-level validation error indicators (red text/border).
4. **Given** valid field inputs on `/login`, **When** tapping "Next", **Then** show loading spinner inside primary button for 1-2 seconds (mock data delay) and navigate to `/home` upon success.
5. **Given** the user is on `/login`, **When** tapping "Forgot Password?", **Then** navigate to `/forgot-password`.
6. **Given** the user is on `/login`, **When** tapping "Cancel", **Then** navigate back to `/start`.

---

### User Story 3 - User Registration & Account Creation (Priority: P1)

As a new user, I want to create an account by providing my email, password, and phone number so I can register for ShopX.

**Why this priority**: Crucial flow for acquiring new users.

**Independent Test**: Can be tested by navigating to `/register`, filling email, password, and phone number with country selector, tapping "Next", and verifying navigation to `/verification`.

**Acceptance Scenarios**:

1. **Given** the user is on `/register`, **When** viewing the screen, **Then** display top blue gradient decoration, H1 "Create Account", subtitle "Please enter your details", email field, password field with eye toggle, phone input with country code dropdown (flag + +1), primary "Next" button, and "Cancel" link.
2. **Given** invalid email/password/phone input, **When** tapping "Next", **Then** display field-level red error messages below offending fields.
3. **Given** valid inputs, **When** tapping "Next", **Then** display button loading state for 1-2s mock delay, emit successful verification code state, and navigate to `/verification`.

---

### User Story 4 - OTP Code Verification (Priority: P1)

As a registering or recovering user, I want to enter a 4-digit verification PIN using a custom numeric keyboard so I can verify my identity.

**Why this priority**: Required security step following registration or password recovery request.

**Independent Test**: Can be tested by navigating to `/verification`, typing digits via the custom 3x4 numeric keypad, verifying PIN box fill states, automatic submission on 4th digit, success/error visual feedback, countdown timer (47s), and resend logic.

**Acceptance Scenarios**:

1. **Given** the user is on `/verification`, **When** viewing the screen, **Then** display H1 "Verification", subtitle with target email info, 4 horizontal PIN boxes (56.w x 56.h, 8.r radius, #E5E5E5 border), countdown timer (47s), custom 3x4 numeric keyboard (1-9, 0, backspace key), and "Cancel" link.
2. **Given** empty PIN boxes, **When** user taps numeric keys on the custom keyboard, **Then** populate boxes left-to-right with centered digits and highlight active/filled box borders with Primary 400 (#004BFE).
3. **Given** filled PIN boxes, **When** tapping backspace key, **Then** clear the last entered digit and revert box border to default #E5E5E5.
4. **Given** the user enters the 4th digit, **When** PIN entry is complete, **Then** trigger automatic submission with loading indicator inside PIN boxes/screen.
5. **Given** correct OTP code, **When** verification succeeds, **Then** display green border/background (#34C759) with checkmark icon in PIN boxes, and automatically navigate to `/home` (or `/reset-password` if coming from recovery) after a short delay.
6. **Given** incorrect OTP code, **When** verification fails, **Then** display red border/background (#FF3B30) with shake animation and error text, keeping the custom numeric keyboard active for retry.
7. **Given** the 47s countdown timer reaches 0, **When** timer expires, **Then** enable clickable "Resend Code" link.

---

### User Story 5 - Password Recovery Channel Selection (Priority: P2)

As a user who forgot their password, I want to choose whether to receive a reset code via SMS or Email.

**Why this priority**: Enables account recovery for users locked out due to forgotten credentials.

**Independent Test**: Can be tested by navigating to `/forgot-password`, selecting SMS or Email radio card, tapping "Next", and navigating to `/verification`.

**Acceptance Scenarios**:

1. **Given** the user is on `/forgot-password`, **When** viewing the screen, **Then** display circular profile avatar (80.r), H1 "Password Recovery", subtitle "How would you like to Restore your Password?", two selection cards (SMS option, Email option with radio buttons), primary "Next" button, and "Cancel" link.
2. **Given** selection cards, **When** user taps an option, **Then** highlight selected card border with Primary 400 (#004BFE) and check its radio button.
3. **Given** a selected recovery channel, **When** user taps "Next", **Then** show loading state for 1-2s mock delay and navigate to `/verification`.

---

### User Story 6 - Reset Password (Priority: P2)

As a user who verified their recovery code, I want to set a new password for my account.

**Why this priority**: Completes the password recovery workflow.

**Independent Test**: Can be tested by navigating to `/reset-password`, entering new password and matching repeat password, tapping "Save", and verifying return to `/login`.

**Acceptance Scenarios**:

1. **Given** the user is on `/reset-password`, **When** viewing the screen, **Then** display profile avatar header, H1 "Setup New Password", subtitle, New Password field, Repeat Password field, and primary "Save" button.
2. **Given** passwords do not match or fail validation, **When** tapping "Save", **Then** show error text beneath input fields.
3. **Given** valid matching passwords, **When** tapping "Save", **Then** show loading indicator for 1-2s mock delay, emit password reset success state, and navigate to `/login`.

---

### User Story 7 - Security Limits & Maximum Attempts Dialog (Priority: P3)

As a system, I want to block recovery attempts when maximum retries are exceeded to protect user accounts.

**Why this priority**: Security safeguard for password recovery rate limiting.

**Independent Test**: Can be tested by navigating to `/error/max-attempts` or triggering max attempt error state, verifying dark overlay dialog, warning icon, error message, and dismissal button.

**Acceptance Scenarios**:

1. **Given** maximum verification or recovery attempts exceeded, **When** navigating to `/error/max-attempts`, **Then** render dark semi-transparent overlay background with centered dialog card containing warning icon, title "Password Recovery", message "You reached out maximum amount of attempts. Please, try later.", and "Okay" button.
2. **Given** the max attempts dialog is displayed, **When** tapping "Okay", **Then** dismiss dialog and navigate back to `/login` or `/start`.

---

### User Story 8 - Welcome & Onboarding Carousel (Priority: P3)

As a newly registered or first-time user, I want interactive onboarding cards explaining ShopX features before accessing the main app.

**Why this priority**: Introduces key app features and value proposition to new users.

**Independent Test**: Can be tested by navigating to `/welcome`, swiping/paging through cards 11 & 12, checking 3-dot page indicator states, and tapping "Let's Start" to enter `/home`.

**Acceptance Scenarios**:

1. **Given** the user is on `/welcome`, **When** viewing onboarding screen, **Then** render full-screen card/dialog over semi-transparent overlay/gradient background with white rounded card (16.r radius), top illustration image, title ("Hello" on screen 11, "Ready?" on screen 12), description text, 3-dot pagination indicators, and action button ("Next" or "Let's Start").
2. **Given** screen 12 ("Ready?"), **When** user taps "Let's Start", **Then** navigate to `/home`.

---

### Edge Cases

- **Rapid Multiple Button Taps**: Primary button MUST disable user interaction while mock loading is active to prevent double submissions.
- **Form Clearing on Navigation**: Navigating away from Auth screens MUST cleanly reset Cubit state or clear form fields as appropriate.
- **Timer Resets**: Leaving `/verification` before OTP entry completes MUST reset the 47s countdown timer.
- **Mock Failure Simulation**: Providing invalid test inputs (e.g., email `error@shopx.com` or PIN `0000`) MUST trigger mock error states (`AuthError`) for testing error UI.

---

## Requirements *(mandatory)*

### Functional Requirements

#### Design Tokens & Theming Requirements
- **FR-001**: System MUST strictly adhere to the extracted Figma design tokens without default Material styling:
  - **Colors**: Primary 900 (`#001850`), Primary 800 (`#002272`), Primary 700 (`#002E9C`), Primary 600 (`#003AC1`), Primary 500 (`#0040DB`), Primary 400 Main (`#004BFE`), Primary 300 (`#2968FF`), Primary 200 (`#5184FF`), Primary 100 (`#789FFE`), Primary 50 (`#BFD2FF`), Background (`#FFFFFF`), Surface (`#F5F5F5`), Text Primary (`#1A1A1A`), Text Secondary (`#8E8E93`), Text White (`#FFFFFF`), Success (`#34C759`), Error (`#FF3B30`), Border (`#E5E5E5`).
  - **Typography**: H1 (28sp, bold, Text Primary), H2 (22sp, w600, Text Primary), Body (16sp, normal, Text Primary), Body Small (14sp, normal, Text Secondary), Caption (12sp, w500, Text Secondary), Button Text (16sp, w600, Text White).
  - **Radii**: Button (12.r), Input Field (12.r), Card (16.r), Pin Box (8.r).
  - **Responsive Units**: ALL sizing, margins, padding, radii, and font sizes MUST use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`).

#### Component & Widget Requirements
- **FR-002**: System MUST provide reusable UI widgets in `lib/shared/widgets/` or feature presentation widgets:
  - `PrimaryButton`: Full-width (`double.infinity`), fixed height `56.h`, Primary 400 background, `12.r` radius, white `16sp` w600 text, integrated white CircularProgressIndicator for loading state, disabled opacity state.
  - `AuthTextField`: Fixed height `56.h`, Surface background (`#F5F5F5`), `12.r` radius, `16.w` horizontal padding, optional prefix icon, suffix password eye toggle.
  - `PhoneInputField`: Derived from input specs with country flag + code prefix (`+1`) and dropdown indicator.
  - `PinInput`: Row of 4 boxes (`56.w x 56.h`, `8.r` radius) supporting default (`#E5E5E5`), active (`#004BFE`), success (`#34C759`), and error (`#FF3B30`) states.
  - `NumericKeyboard`: Custom 3x4 on-screen keypad (`48.w x 48.h` keys, `24sp` w500 text, backspace icon, countdown timer display).
  - `SelectionCard`: Height `64.h`, `12.r` radius, `16.w` padding, radio button selection indicator.
  - `AuthHeader`: Blue gradient top decoration, `28sp` bold title, `16sp` subtitle, `60.h` safe-area top padding.
  - `TextLink`: `14sp` w500 text link in Primary 400 with tap gesture feedback.

#### State Management & Architecture Requirements
- **FR-003**: System MUST manage Auth states using `AuthCubit` (`flutter_bloc`) registered with `GetIt` DI.
- **FR-004**: All states emitted by `AuthCubit` (`AuthInitial`, `AuthLoading`, `AuthSuccess`, `AuthError`, `AuthOtpSent`, `AuthOtpVerified`, `AuthPasswordReset`) and domain entities MUST extend `Equatable`.
- **FR-005**: All mock data calls in repository implementation MUST return `Either<Failure, T>` using `dartz` wrapped in `safeCall`, simulating realistic network delays (1-2 seconds).
- **FR-006**: Widgets MUST NOT execute business or state mutation logic directly; widgets MUST exclusively emit Cubit intents and react to Cubit states.
- **FR-007**: Asynchronous loading states MUST utilize shimmer loading effects (`shimmer` package) where applicable.

#### Routing & Navigation Requirements
- **FR-008**: System MUST implement navigation routes using `go_router`:
  - `/start` -> Start Page
  - `/register` -> Create Account Page
  - `/login` -> Login Page
  - `/verification` -> OTP Verification Page
  - `/forgot-password` -> Password Recovery Page
  - `/reset-password` -> Reset Password Page
  - `/error/max-attempts` -> Maximum Attempts Dialog
  - `/welcome` -> Welcome / Onboarding Cards

---

### Key Entities

- **AuthUserEntity**: Represents authenticated user data (`id`, `email`, `fullName`, `phoneNumber`, `avatarUrl`).
- **CountryCodeEntity**: Represents country code options for phone input (`countryName`, `flagEmoji`, `dialCode`).
- **OtpVerificationEntity**: Encapsulates OTP verification request data (`targetContact`, `verificationType`, `code`, `expiresInSeconds`).

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of the 12 specified Auth screen views match Figma design token specifications (colors, spacing, typography, radii) with zero reliance on default Material styling.
- **SC-002**: All form interactions (login, register, OTP verification, password recovery) respond to user inputs with mock async delays between 1 and 2 seconds while displaying loading indicators.
- **SC-003**: OTP verification automatically triggers verification evaluation upon typing the 4th digit without requiring manual submit button press.
- **SC-004**: All Auth presentation widgets have 0 business logic lines inside widget classes, delegating all state transitions strictly to `AuthCubit`.
- **SC-005**: Widget test suite covers 100% of presentation flows and state transitions across `/start`, `/login`, `/register`, `/verification`, `/forgot-password`, `/reset-password`, `/error/max-attempts`, and `/welcome`.

---

## Assumptions

- **Phase 1 Mock Strategy**: No live backend authentication endpoints are available in Phase 1; mock repository will generate synthetic successful or failed `Either<Failure, AuthUserEntity>` responses after a 1-2 second delay.
- **Asset Availability**: App icons, logos, and onboarding illustrations will be loaded from local assets (`assets/images/` or SVG equivalents).
- **Default Country Code**: Phone number input field defaults to `+1` (United States) for Phase 1 demonstration.
- **Default OTP Code**: The mock verification code for successful verification testing is `1234` (or any 4 digits except `0000` which simulates an invalid OTP error).
