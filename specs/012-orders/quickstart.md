# Quickstart & Verification Guide: Orders Feature

**Feature Directory**: `specs/012-orders`  
**Date**: 2026-10-03  
**Status**: Ready  

---

## 1. Prerequisites & Environment

- Project requires **Flutter 3.44.6 via FVM** (Rule #12).
- NEVER use bare `flutter` CLI commands; ALWAYS use `fvm flutter`.
- No new image/icon assets should be added; reuse `assets/images/` and existing icon tokens.

---

## 2. Navigation Routes & Verification Entry Points

| Route | Page | Design Screen Ref | Description |
| :--- | :--- | :--- | :--- |
| `/orders` | `OrdersPage` | `57_TO_RECEIVE.png` | Orders list with tabs ("To Pay", "To Receive", "To Review") |
| `/orders/:id/tracking` | `OrderTrackingPage` | `59_TO_RECEIVE_PROGRESS.png`<br>`61_DELIVERY_ATTEMPT.png`<br>`63_DELIVERED.png` | 5-step milestone tracking timeline |
| `/orders/history` | `OrderHistoryPage` | `65_HISTORY.png` | Past orders list with Review buttons |

### Modals:
- **Screen 58 (`58_REVIEW_OPTION.png`)**: Opened by tapping `Review` on a multi-item delivered order -> `ReviewOptionSheet` (bottom sheet, 24.r radius).
- **Screen 60 (`60_DELIVERY_FAILED.png`)**: Opened by tapping `Learn more` on a failed delivery milestone -> `DeliveryFailedSheet` (bottom sheet, 24.r radius).
- **Screen 66 (`66_REVIEW.png`)**: Opened by selecting an item from Screen 58 -> `ReviewSheet` (bottom sheet, 24.r radius).
- **Screen 67 (`67_REVIEW_DONE.png`)**: Triggered upon tapping `Send Review` -> `ReviewDoneDialog` (centered dialog, auto-dismiss).

---

## 3. Test Scenarios (Manual & Automated)

### Scenario 1: Tab Filtering & Action Buttons (Screen 57)
1. Open `/orders`.
2. Confirm 3 tabs: "To Pay", "To Receive", "To Review".
3. Verify "To Receive" tab is active by default.
4. Verify each `OrderCard` displays thumbnails (+N overflow badge), order number, "Standard Delivery", "3 items" `MetaPill`, and status label.
5. In-progress orders (`Packed` / `Shipped`) show a solid blue pill button `Track`.
6. Delivered orders show an outlined blue pill button `Review`.

### Scenario 2: Tracking Progress Timeline (Screens 59, 61, 63)
1. Tap `Track` on an in-progress order (`order-1`):
   - Opens `/orders/order-1/tracking`.
   - Milestones 1 and 2 are primary blue with timestamps; 3, 4, 5 are neutral gray (Screen 59).
2. Tap `Track` on a delivered order (`order-4`):
   - All 5 milestones are primary blue with timestamps (Screen 63).
3. Tap `Track` on an order with failed attempt (`order-3`):
   - Milestone list displays red failed milestone: "Attempt to deliver your parcel was not successful" with `Learn more` button (Screen 61).
   - Tapping `Learn more` opens Screen 60 modal with support contact `+00 000 000 000` and `Chat Now` button.

### Scenario 3: Order History & Review Authoring Flow (Screens 65, 58, 66, 67)
1. Navigate to `/orders/history`.
2. Verify list of completed past orders with date pills and `Review` buttons.
3. Tap `Review` on an order with multiple items:
   - Screen 58 bottom sheet appears with list of purchased items.
4. Tap `Review` on an item:
   - Screen 66 review authoring sheet appears with avatar, product info, 5 tappable stars, and comment field.
5. Tap 4th star (stars 1–4 turn gold, 5th remains outline). Type a comment.
6. Tap `Send Review`:
   - Screen 67 centered dialog appears: "Done!", "Your review has been successfully sent", 5 golden stars.
   - Dialog auto-dismisses after 2.5s and returns to orders list.

---

## 4. Final Quality Gate Commands (Final Phase Only)

```bash
# Code format check
dart format --output=none --set-exit-if-changed lib test

# Static analysis (must pass with 0 errors)
fvm flutter analyze

# Unit & Widget tests
fvm flutter test test/features/orders/
```
