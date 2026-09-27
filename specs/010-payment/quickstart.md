# Quickstart Validation Guide: Payment Feature (Screens 51, 52, 53, 54, 55, 56)

**Feature**: `specs/010-payment` | **Date**: 2026-09-25

This guide provides step-by-step verification flows to validate end-to-end functionality and design fidelity for the **Payment** feature.

---

## Prerequisites
- Application running via `fvm flutter run` or target mobile emulator/device.
- Checkout flow active or direct navigation to `/payment`.

---

## Validation Scenarios

### Scenario 1: Choose Payment Method - Cards List (Screen 51 & 52)
1. **Action**: On Checkout Summary (Screen 47/49), tap the "Pay" button (or navigate to `/payment`).
2. **Expected Outcome**:
   - Modal bottom sheet `PaymentMethodSheet` slides up with top rounded corners (`24.r`).
   - Header displays "Payment Methods" in bold with circular `✕` close button.
   - Horizontal list displays saved cards:
     - Card 1: Mastercard on light blue `AppColors.primarySoft` (`0xFFE6EEFF`) with red/orange circles logo, white settings gear icon badge, masked number `* * * *   * * * *   * * * *   1579`, "AMANDA", and expiry "12/22".
     - Card 2: Visa on soft blush `AppColors.blushSoft` (`0xFFFFECEB`) with dark blue `VISA` logo (`AppColors.visaBlue`).
   - Vertical rectangular Add Card button in `AppColors.primary` (`0xFF004BFE`) with centered white `+` icon is visible on scroll.
3. **Action**: Tap the circular `✕` button.
4. **Expected Outcome**: Sheet dismisses cleanly, returning to checkout.

---

### Scenario 2: Choose Payment Method - PayPal Redirect (Screen 53)
1. **Action**: In `PaymentMethodSheet`, switch to or tap the PayPal option.
2. **Expected Outcome**:
   - Sheet content renders `PayPalRedirectContent`.
   - Circular blue PayPal logo with white "P" displays in the center.
   - Centered instruction text "You will be directed to PayPal" renders in secondary text style.
   - Blue pill button labeled "OK" (`AppColors.primary`) renders.
3. **Action**: Tap "OK".
4. **Expected Outcome**: Sheet closes and transitions directly to `PaymentProcessingModal` (Screen 54).

---

### Scenario 3: Payment In Progress Modal (Screen 54)
1. **Action**: Tap on any saved card item (Mastercard or Visa) or tap "OK" on PayPal.
2. **Expected Outcome**:
   - Centered modal dialog `PaymentProcessingModal` appears over the dimmed/blurred background.
   - Card container has white background and rounded corners (`24.r`).
   - Circular grey indicator background contains an active blue circular progress spinner.
   - Bold title "Payment in Progress" and subtitle "Please, wait a few moments" are centered.
3. **Action**: Tap outside the dialog or press the system back button.
4. **Expected Outcome**: Dialog remains visible (non-dismissible). After 2–3 seconds, dialog automatically transitions to Screen 55 or Screen 56.

---

### Scenario 4: Payment Failure Modal & Recovery (Screen 55)
1. **Action**: Trigger a payment failure outcome.
2. **Expected Outcome**:
   - Centered modal dialog `PaymentFailureModal` appears.
   - Circular grey badge contains an exclamation mark icon (`!`).
   - Title "We couldn't proceed your payment" and subtitle "Please, change your payment method or try again" are rendered.
   - Two side-by-side pill buttons render: "Try Again" (black pill button) and "Change" (grey pill button).
3. **Action**: Tap "Try Again".
4. **Expected Outcome**: Dialog returns immediately to Screen 54 (`PaymentProcessingModal`) to re-attempt payment.
5. **Action**: When failure modal reappears, tap "Change".
6. **Expected Outcome**: Failure dialog dismisses and re-opens `PaymentMethodSheet` (Screens 51–53) allowing the customer to select an alternative card.

---

### Scenario 5: Payment Success Modal & Order Tracking (Screen 56)
1. **Action**: Trigger a payment success outcome.
2. **Expected Outcome**:
   - Centered modal dialog `PaymentSuccessModal` appears.
   - Circular grey container contains an inner solid blue circle with a white checkmark icon (`✓`).
   - Bold title "Done!" and subtitle "Your card has been successfully charged" are rendered.
   - Grey pill button labeled "Track your Order" renders.
3. **Action**: Tap "Track your Order".
4. **Expected Outcome**:
   - Dialog dismisses.
   - Navigation routes toward `/orders/:id` (or presents informative feedback SnackBar if orders feature is in future phase).
   - Checkout and payment modal history are cleared from the navigation stack.

---

### Scenario 6: Strict Token Enforcement (Rule #11)
- Verify zero hardcoded `Color(0x...)` or `Colors.` in `lib/features/payment/`.
- Verify all brand colors (`visaBlue`, `mastercardRed`, `mastercardYellow`, `blushSoft`, `paypalBlue`) are imported directly from `AppColors`.
- Verify all spacing references `AppSpacing` and all typography references `AppTypography`.
