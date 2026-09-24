# Quickstart Validation Guide: Checkout Feature (Screens 47, 48, 49, 50)

**Feature**: `specs/009-checkout` | **Date**: 2026-09-24

This guide provides step-by-step verification flows to validate end-to-end functionality and design fidelity for the **Checkout** feature.

---

## Prerequisites
- Application running via `flutter run` or target test environment.
- Cart with items loaded or direct navigation to `/checkout`.

---

## Validation Scenarios

### Scenario 1: Checkout Summary & Design Token Fidelity (Screen 47)
1. **Action**: Navigate to `/checkout` (or tap "Checkout" on `/cart`).
2. **Expected Outcome**:
   - Header renders "Payment" with circular `✕` close button.
   - Shipping Address card renders with title, default address ("United States, New York, NY / 110 W 44th Street, New York, NY 10036"), and a blue circular button with a white pencil edit icon.
   - Contact Information card renders with phone "+1-866-922-8694", email "design.blackside@gmail.com", and a blue circular edit button.
   - Items section shows header "Items" with badge `2`, and an outlined blue pill button "Add Voucher".
   - 2 order item cards render with thumbnails, 2-line title, quantity circle `1` (`#004BFE`), variant pills (`Pink`, `M`), and price `$17,00`.
   - Shipping Options section displays "Standard" selected ($3.00) and "Express" unselected ($12.00) with delivery estimate text.
   - Payment Method section displays chips for `Card` (selected) and `Paypal` (unselected).
   - Sticky bottom bar shows `Total: $34.00` and black pill button "Pay".

---

### Scenario 2: Active Vouchers Bottom Sheet & Application (Screen 47 → 48 → 49)
1. **Action**: Tap the "Add Voucher" button on Screen 47.
2. **Expected Outcome**:
   - Modal bottom sheet Screen 48 opens with top rounded corners (`24.r`).
   - Title "Active Vouchers" and circular `✕` close button render.
   - 2 ticket-shaped voucher cards render:
     - "From Customer Care" (15% discount, Valid Until 5.16.20, Apply button)
     - "First Purchase" (5% discount, Valid Until 6.20.20, Apply button)
3. **Action**: Tap "Apply" on the "First Purchase" (5%) voucher.
4. **Expected Outcome**:
   - Bottom sheet dismisses immediately.
   - Checkout page displays Screen 49 view.
   - "Add Voucher" button is replaced by solid blue badge `5% Discount ✕`.
   - Order total recalculates to reflect 5% discount:
     - Subtotal: $34.00, Discount (5%): -$1.70, Shipping: $3.00 → Total: $35.30 (or formula based on items).

---

### Scenario 3: Voucher Removal (Screen 49 → 47)
1. **Action**: On Screen 49, tap the `✕` icon on the `5% Discount ✕` badge.
2. **Expected Outcome**:
   - Discount badge disappears.
   - "Add Voucher" outlined pill button reappears.
   - Total recalculates back to undiscounted total ($34.00 + shipping).

---

### Scenario 4: Edit Shipping Address Bottom Sheet (Screen 47/49 → Screen 50)
1. **Action**: Tap the blue edit button on the Shipping Address card.
2. **Expected Outcome**:
   - Modal bottom sheet Screen 50 slides up with title "Shipping Address" and circular `✕`.
   - Form fields render with soft light blue fill (`AppColors.primarySoft`):
     - Country: "Iran" (with `ⓘ` info icon)
     - Address: "110 W 44th Street, NY 10036"
     - Town / City: "New York"
     - Postcode: "10012"
3. **Action**: Change Town / City to "Los Angeles" and tap `✕` to dismiss.
4. **Expected Outcome**:
   - Sheet closes.
   - Shipping Address card on Screen 47/49 updates to display "Los Angeles".

---

### Scenario 5: Shipping Option Toggling
1. **Action**: Tap the "Express | 1 - 2 Days | $12.00" shipping option.
2. **Expected Outcome**:
   - Express container acquires active blue styling with checkmark.
   - Standard container reverts to grey unselected styling.
   - Total updates by +$9.00 ($12.00 vs $3.00 shipping difference).
3. **Action**: Tap "Standard" again.
4. **Expected Outcome**:
   - Standard becomes selected and total decreases by $9.00.

---

### Scenario 6: Payment Navigation
1. **Action**: Tap the "Pay" button on the sticky bottom bar.
2. **Expected Outcome**:
   - Initiates navigation to `/payment`.
