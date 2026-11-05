# Quickstart Validation Guide: Settings (Screens 86–100)

**Feature**: `specs/015-settings`  
**Date**: 2026-11-05  
**Status**: Completed  

---

## 1. Prerequisites

- Run all commands within the project root `E:\e_store\e_store`.
- Follow **Rule #1**: Save all static analysis strictly for the final phase (`fvm flutter analyze` at completion).
- Follow **Rule #12**: Use FVM exclusively for CLI operations.

---

## 2. Interactive Verification Scenarios

### Scenario 1: Main Settings Hub Navigation (Screens 86, 87)
1. Run application and navigate to `/settings` (Profile Tab in bottom navigation).
2. Verify header `Settings` and three section containers: `Personal`, `Shop`, `Account`.
3. Verify metadata labels: Country shows "Iran", Currency shows "$ USD", Sizes shows "UK", Language shows "English".
4. Verify `Delete My Account` button in soft pink container (`#FFEBEB`) with red text.
5. Verify bottom version footer: `ShopX` and `Version 1.0 June, 2026`.
6. Tap each row to verify clean push navigation to subordinate settings pages.

### Scenario 2: Profile Credentials Inspection (Screen 88)
1. Navigate to `/settings/profile`.
2. Verify circular avatar (80x80) displaying `profile_picture.png`.
3. Verify soft blue-tinted input containers displaying `Romina`, `gmail@example.com`, and masked password.
4. Verify `Edit Information` button rendered with grey pill styling.

### Scenario 3: Payment Cards Carousel & History Toggle (Screens 89, 90, 91, 92)
1. Navigate to `/settings/payment`.
2. Swipe card carousel: verify Mastercard (interlocking circles, gear icon) and Visa card (navy italic VISA).
3. Verify PayPal placeholder section with circular blue PayPal icon.
4. Tap circular History button (↺):
   - Button turns solid blue with white icon.
   - PayPal section is replaced with `Payment History` transaction cards.
   - Verify transaction 3 displays soft pink background (`#FFF0F2`), coral red bag, and coral red `-$37,00`.
5. Tap circular `+` button in card section:
   - `Add Card` bottom sheet opens (Screen 90) with "Required" placeholders.
   - Close with `ModalCloseButton` (`✕`).
6. Tap gear icon on Mastercard card:
   - `Edit Card` bottom sheet opens (Screen 91) with pre-filled fields.
   - Tap `Save Changes` to confirm update.

### Scenario 4: Shipping Address View and Edit (Screens 93, 94)
1. Navigate to `/settings/shipping`.
2. Verify read-only address fields: `110 W 44th Street, NY 10036`, `New York`, `10012`, `+98*******22`.
3. Tap `Edit Information`:
   - Screen toggles to edit mode (Screen 94).
   - Bottom button turns into blue `PrimaryButton` with text `Save Changes`.
4. Modify an address field and tap `Save Changes` to confirm persistence.

### Scenario 5: Preferences Selection (Screens 95, 96, 97, 98)
1. Navigate to `/settings/country`: search "Iran", verify active card at top with blue checkmark circle.
2. Navigate to `/settings/language`: select "Français" or "English", verify active selection updates immediately.
3. Navigate to `/settings/currency`: switch between "$ USD" and "€ EURO".
4. Navigate to `/settings/sizes`: switch between "US", "EU", "UK".

### Scenario 6: Delete Account Safety Warning (Screen 99)
1. From `/settings`, tap `Delete My Account`.
2. Verify `DeleteAccountDialog` displays centered white card with exclamation badge `!`.
3. Verify side-by-side action buttons: `Cancel` (black pill) and `Delete` (red pill).
4. Tap `Cancel` → dialog closes.
5. Tap `Delete` → confirms mock deletion and displays confirmation.

### Scenario 7: About ShopX Page (Screen 100)
1. Navigate to `/settings/about`.
2. Verify top radial glow background (`#E1EDFF`).
3. Verify centered ShopX shopping bag logo and brand description copy.
4. Verify contact email `contact.blacksidedesign@gmail.com`.

