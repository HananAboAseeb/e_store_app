# Feature Specification: Payment (Screens 51, 52, 53, 54, 55, 56)

**Feature Branch**: `feature/payment`

**Created**: 2026-09-25

**Status**: Draft

**Input**: User specification and Figma design reference screenshots for Screen 51 (Choose Payment Method - Single Card), Screen 52 (Choose Payment Method - Multi Cards with Visa), Screen 53 (Choose Payment Method - PayPal Redirect), Screen 54 (Payment In Progress Processing Modal), Screen 55 (Couldn't Proceed Payment Failure Modal), and Screen 56 (Card Has Been Charged Success Modal). Part 3 of the Cart & Checkout & Payment lifecycle. Provides payment method selection, payment processing with loading indicators, simulated gateway execution, comprehensive error handling with retry/change flows, and successful charge confirmation.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Payment Method Selection Sheet & Card Display (Screens 51 & 52) (Priority: P1)

As a customer ready to pay for my order, I want to review my saved payment cards in a bottom sheet and select one to proceed, so that I can conveniently complete my purchase using my preferred card.

**Why this priority**: Core foundation of the payment feature. Users must be able to view their available payment methods (cards) and choose one before any transaction can take place.

**Independent Test**: Trigger the payment method sheet (via `/payment` or tapping "Pay" from checkout). Verify that a modal bottom sheet slides up with rounded top corners (`24.r`), header "Payment Methods", and a circular `✕` close button. Verify that a horizontal scrolling list displays saved payment cards (Mastercard on light blue `AppColors.primarySoft`, Visa on soft blush background). Verify that each card displays its brand logo, cardholder name ("AMANDA"), masked card number (`* * * *   * * * *   * * * *   1579`), expiration date (`12/22`), and a white circular gear settings button. Verify the blue vertical rectangular "Add Card" button (`AppColors.primary`) with a white `+` icon is present. Tapping any card dismisses the sheet and initiates payment processing.

**Acceptance Scenarios**:

1. **Given** a customer initiates the payment flow, **When** the payment method sheet renders (Screen 51), **Then** the header displays "Payment Methods" in bold with a circular `✕` dismiss button on the right.
2. **Given** the saved card list, **When** displayed, **Then** it renders a horizontally scrollable list showing saved cards with brand logos (Mastercard red/orange interlocking circles, Visa logo), masked card number (`* * * *   * * * *   * * * *   1579`), cardholder name (`AMANDA`), and expiry (`12/22`).
3. **Given** a card item on Screen 51/52, **When** rendered, **Then** the Mastercard card features a soft light blue background (`AppColors.primarySoft`), while the Visa card features a soft blush background.
4. **Given** the right side of the card list, **When** rendered, **Then** it displays a vertical rectangular button (`AppColors.primary`) with a centered white `+` icon for adding a new card.
5. **Given** the payment method sheet, **When** the customer taps on any payment card, **Then** the sheet closes and immediately triggers the Payment In Progress modal (Screen 54).
6. **Given** the payment method sheet, **When** the customer taps the circular `✕` button, **Then** the bottom sheet dismisses cleanly, returning the customer to the checkout screen without initiating payment.

---

### User Story 2 - PayPal Redirect Option (Screen 53) (Priority: P2)

As a customer preferring an alternative to credit cards, I want to select PayPal as my payment option and be redirected to PayPal authentication, so that I can pay securely with my PayPal account.

**Why this priority**: Crucial alternative payment channel for shoppers without saved credit cards or those preferring third-party digital wallets.

**Independent Test**: Open the payment method modal with PayPal selected or active. Verify the modal displays header "Payment Methods" with a circular `✕` button. Verify centered content showing the circular blue PayPal logo (`P`), centered descriptive text ("You will be directed to PayPal"), and a full-width blue pill "OK" button (`AppColors.primary`). Tap "OK". Verify the sheet dismisses and triggers the Payment In Progress modal (Screen 54).

**Acceptance Scenarios**:

1. **Given** PayPal payment option is active (Screen 53), **When** rendered, **Then** the sheet displays the centered circular blue PayPal icon with white "P".
2. **Given** Screen 53, **When** displayed, **Then** centered secondary text states "You will be directed to PayPal".
3. **Given** Screen 53, **When** the customer taps the blue pill button labeled "OK", **Then** the sheet dismisses and transitions to the Payment In Progress modal (Screen 54) to simulate processing.
4. **Given** Screen 53, **When** the customer taps the circular `✕` button, **Then** the sheet dismisses and cancels the payment attempt.

---

### User Story 3 - Payment Processing Modal & State Transition (Screen 54) (Priority: P3)

As a customer who has confirmed their payment method, I want to see a clear processing indicator indicating that my payment is being processed, so that I am assured my transaction is underway and do not double-submit.

**Why this priority**: Essential transactional UX and security pattern. Prevents duplicate charges, manages user expectations during latency, and isolates gateway communication.

**Independent Test**: Select a payment method (Card or PayPal). Verify a centered modal dialog appears over the dimmed/blurred background. Verify the modal has a white rounded container (`24.r`), a grey circular badge with a blue circular progress spinner, bold title "Payment in Progress", and subtitle "Please, wait a few moments". Verify the dialog is non-dismissible by tapping outside or pressing the system back button. Verify that after a simulated gateway duration (2–3 seconds), the dialog automatically transitions to either the Payment Failure modal (Screen 55) or Payment Success modal (Screen 56).

**Acceptance Scenarios**:

1. **Given** a payment method is selected, **When** processing begins, **Then** a non-dismissible modal dialog (Screen 54) appears centered on the screen.
2. **Given** Screen 54, **When** rendered, **Then** it features a white rounded card (`24.r`), a light circular indicator background with an active blue circular progress spinner, title "Payment in Progress", and subtitle "Please, wait a few moments".
3. **Given** the processing modal, **When** the customer taps the modal background or outside the modal, **Then** the modal remains displayed (non-dismissible).
4. **Given** processing is underway, **When** the gateway completes after 2–3 seconds, **Then** the modal transitions cleanly to Screen 55 (Failure) or Screen 56 (Success) based on the gateway response.

---

### User Story 4 - Payment Failure Handling & Recovery Flow (Screen 55) (Priority: P4)

As a customer whose payment could not be processed, I want to receive clear notification of the failure and have the option to retry or switch my payment method, so that I can successfully complete my order without losing checkout progress.

**Why this priority**: High business impact on cart abandonment. Clear error recovery and convenient retry mechanisms preserve customer trust and drive conversion recovery.

**Independent Test**: Induce a payment failure outcome from Screen 54. Verify Screen 55 modal dialog appears centered with white rounded container (`24.r`), a grey circular badge with an exclamation icon (`!`), bold title "We couldn't proceed your payment", subtitle "Please, change your payment method or try again", and two side-by-side pill buttons: black "Try Again" and grey "Change". Tap "Try Again"; verify the dialog transitions back to Payment In Progress (Screen 54) to re-attempt payment. Alternatively, tap "Change"; verify the failure modal dismisses and re-opens the Payment Methods bottom sheet (Screens 51–53) to allow choosing a different method.

**Acceptance Scenarios**:

1. **Given** payment processing fails, **When** the failure result is emitted, **Then** Screen 55 modal dialog displays centered on screen.
2. **Given** Screen 55, **When** rendered, **Then** it presents a grey circular badge with an exclamation mark icon (`!`), title "We couldn't proceed your payment", and subtitle "Please, change your payment method or try again".
3. **Given** Screen 55, **When** rendered, **Then** it presents two side-by-side action buttons: a black pill button labeled "Try Again" and a grey pill button labeled "Change".
4. **Given** Screen 55, **When** the customer taps "Try Again", **Then** the modal dismisses and transitions directly back to the Payment In Progress modal (Screen 54) to re-process the transaction.
5. **Given** Screen 55, **When** the customer taps "Change", **Then** the failure modal dismisses and immediately re-opens the Payment Methods bottom sheet (Screens 51–53) allowing selection of another card or PayPal.

---

### User Story 5 - Payment Confirmation & Order Transition (Screen 56) (Priority: P5)

As a customer whose payment succeeded, I want to receive definitive confirmation that my card has been charged and have a direct action to track my order, so that I have peace of mind and can monitor fulfillment.

**Why this priority**: Culmination of the entire purchase funnel. Confirms monetary deduction and provides transition into post-purchase order tracking.

**Independent Test**: Complete a successful payment outcome from Screen 54. Verify Screen 56 modal dialog appears centered with a white rounded container (`24.r`), a grey circular container with an inner solid blue circle containing a white checkmark icon (`✓`), bold title "Done!", subtitle "Your card has been successfully charged", and a grey pill button labeled "Track your Order". Tap "Track your Order"; verify the application navigates toward the orders route (`/orders/:id` or displays an informational feedback message if the orders route is a future phase).

**Acceptance Scenarios**:

1. **Given** payment processing succeeds, **When** the success result is emitted, **Then** Screen 56 modal dialog displays centered on screen.
2. **Given** Screen 56, **When** rendered, **Then** it displays a grey circular badge containing a solid blue circular checkmark (`✓`), bold title "Done!", and subtitle "Your card has been successfully charged".
3. **Given** Screen 56, **When** rendered, **Then** it displays a full-width grey pill button labeled "Track your Order".
4. **Given** Screen 56, **When** the customer taps "Track your Order", **Then** the application triggers navigation to the order detail/tracking route (e.g. `/orders/:id`), completing the checkout & payment funnel.

---

### Edge Cases

- **Double-Tapping Prevention**: Once a card or "OK" is tapped, all user interactions on the payment sheet are disabled immediately to prevent duplicate transaction submissions.
- **Non-Dismissible Processing**: The Payment In Progress modal cannot be dismissed by Android back button, iOS swipe gesture, or tapping outside the modal boundary.
- **Network / Gateway Latency Simulation**: Mock gateway simulates a realistic 2–3 second latency with deterministic or controllable random success/failure distribution for thorough manual testing.
- **Empty Card List Fallback**: If no saved cards exist in the user profile, the sheet displays the "Add Card" action prominently alongside PayPal to ensure the user is not trapped.
- **Multiple Consecutive Failures**: Customers can tap "Try Again" multiple times or switch between cards repeatedly until a successful payment is achieved.
- **Background Dismissal on Success**: When transitioning to Order Tracking upon success, all prior checkout and payment modal overlays are cleared from the navigation stack so the back button does not return to a processed payment.
- **Figma Background Overlay**: The blurred background shown behind Screens 51–56 is the existing `CheckoutPage` mounted underneath; modals overlay on top of `CheckoutPage` or a dedicated lightweight `PaymentPage`.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide a dedicated `payment` feature module covering Screens 51, 52, 53, 54, 55, and 56, completely isolated from checkout logic.
- **FR-002**: System MUST render a modal bottom sheet (Screen 51/52) with header "Payment Methods" and a circular `✕` dismiss button.
- **FR-003**: System MUST display saved credit cards in a horizontally scrollable list with rounded corners (`16.r`), card brand logo, masked number (`* * * *   * * * *   * * * *   1579`), cardholder name, expiry date, and settings button.
- **FR-004**: System MUST render Mastercard items with `AppColors.primarySoft` background and Visa items with a soft blush background.
- **FR-005**: System MUST render an "Add Card" button styled as a vertical rectangle with `AppColors.primary` background and a white `+` icon.
- **FR-006**: System MUST dismiss the bottom sheet and trigger payment processing when any saved card item is tapped.
- **FR-007**: System MUST render a PayPal redirect view (Screen 53) featuring a circular blue PayPal logo, centered instruction text, and a blue pill "OK" button.
- **FR-008**: System MUST trigger payment processing when the "OK" button on Screen 53 is tapped.
- **FR-009**: System MUST display a non-dismissible modal dialog (Screen 54) showing a circular progress spinner, title "Payment in Progress", and subtitle "Please, wait a few moments".
- **FR-010**: System MUST simulate a 2–3 second payment processing delay before resolving the transaction state.
- **FR-011**: System MUST display a failure modal dialog (Screen 55) upon payment failure, featuring an exclamation badge (`!`), error explanation, a black pill "Try Again" button, and a grey pill "Change" button.
- **FR-012**: System MUST re-trigger payment processing upon tapping "Try Again" on Screen 55.
- **FR-013**: System MUST re-open the payment method selection sheet upon tapping "Change" on Screen 55.
- **FR-014**: System MUST display a success modal dialog (Screen 56) upon successful payment, featuring a blue checkmark badge (`✓`), confirmation text, and a grey pill "Track your Order" button.
- **FR-015**: System MUST navigate toward `/orders/:id` (or show a feedback message) when "Track your Order" is tapped on Screen 56.
- **FR-016**: System MUST render shimmer loading placeholders during asynchronous retrieval of saved payment methods.
- **FR-017**: System MUST manage all presentation state via `PaymentCubit` with immutable `Equatable` states.
- **FR-018**: System MUST encapsulate all data interactions using Clean Architecture: Domain UseCases, Repository interface, Data Models, and Mock DataSource using `safeCall`.
- **FR-019**: System MUST enforce Rule #11: all colors, spacing, and typography must reference tokens from `AppColors`, `AppSpacing`, and `AppTypography` exclusively.

---

### Key Entities *(include if feature involves data)*

- **PaymentMethodEntity**: Representation of a customer's payment method containing `id` (String), `type` (PaymentMethodType: card, paypal), `cardBrand` (CardBrand: mastercard, visa, none), `maskedCardNumber` (String, e.g., `···· ···· ···· 1579`), `cardholderName` (String, e.g., `AMANDA`), `expiryDate` (String, e.g., `12/22`), and `isDefault` (bool).
- **PaymentResultEntity**: Transaction execution result containing `id` (String), `orderId` (String), `status` (PaymentStatus: success, failure), `message` (String), `amount` (double), and `timestamp` (DateTime).

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Customers can select a saved card or PayPal and trigger payment in under 5 seconds.
- **SC-002**: 100% of payment attempts display the non-dismissible processing modal (Screen 54) within 100ms of selection.
- **SC-003**: 100% of failed payments allow instant retry ("Try Again") or immediate method switching ("Change") with zero unhandled exceptions.
- **SC-004**: 100% of successful payments display the confirmation modal (Screen 56) with order reference information.
- **SC-005**: Zero layout overflow errors across small, standard, and large mobile device screen viewports.
- **SC-006**: 100% pixel-perfect compliance with Figma design references `51 CHOOSE PAYMENT METHOD 1 CARD.png`, `52 CHOOSE PAYMENT METHOD 2 CARDS.png`, `53 CHOOSE PAYMENT METHOD PAYPAL.png`, `54 PAYMENT IN PROGRESS.png`, `55 COULDNT PROCEED PAYMENT.png`, and `56 CARD HAS BEEN CHARGED.png`.

---

## Assumptions

- **Mock Data Scope**: In Phase 1, saved payment methods (Mastercard, Visa, PayPal) and transaction processing are provided by `PaymentMockDataSource` with a simulated delay (2–3 seconds) and simulated success/failure response.
- **Standalone Feature Architecture**: `payment` is strictly isolated from `checkout`. The checkout screen navigates to `/payment` upon tapping "Pay", and the payment modals overlay cleanly over `CheckoutPage` or a lightweight `PaymentPage`.
- **Add Card & Settings Placeholders**: Tapping the "Add Card" button (`+`) or card settings gear icon triggers informational placeholders (e.g. SnackBar or dialog) in Phase 1, paving the way for a future card management feature.
- **Order Tracking Route**: Tapping "Track your Order" targets route `/orders/:id`. If the orders feature is not yet mounted, it provides a graceful fallback (SnackBar notification or navigation to home).
- **Design Token Strictness**: All colors, dimensions, and typography reference design tokens from `AppColors`, `AppSpacing`, and `AppTypography` exclusively.

---

## Permanent Project Rules Reference

All features MUST strictly comply with the Permanent Project Rules defined in the project Constitution (`.specify/memory/constitution.md`):
1. **Verification Timing**: Do NOT run `flutter analyze` or `flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PrimaryButton, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
11. **STRICT COLOR & TOKEN ENFORCEMENT**: All colors, spacing, and typography must reference tokens from `AppColors`, `AppSpacing`, and `AppTypography`. No hardcoded values are allowed. If a token is missing, add it to the tokens file first.
12. **FVM-ONLY CLI COMMANDS**: ALWAYS use `fvm flutter` (NOT bare `flutter`) for ALL Flutter CLI commands (`analyze`, `test`, `run`, `build`, `pub get`, etc.). The project uses FVM with Flutter 3.44.6. The global Flutter (3.24.5) has incompatible API differences (e.g., `CardTheme` vs `CardThemeData`). Using bare `flutter` causes type mismatch errors and reverts fixes.
