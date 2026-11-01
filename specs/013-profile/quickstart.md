# Quickstart & Verification Guide: User Profile, Activity Dashboard & Rewards Center

**Feature**: `013-profile`  
**Date**: 2026-11-01  
**Target Screens**: 62, 81, 85 (Profile Home), 64 (My Activity), 82, 83 (Active Vouchers), 84 (Rewards Progress)  

---

## Prerequisites

- Flutter environment configured with FVM (Flutter 3.44.6).
- Ensure existing assets in `assets/images/` and `assets/design_references/` are present.
- All dependencies registered in `pubspec.yaml` (`flutter_bloc`, `go_router`, `flutter_screenutil`, `get_it`, `dartz`, `equatable`, `shimmer`).

---

## Quick Verification Scenarios

### Scenario 1: Profile Home Screen Verification (Screens 62, 81, 85)
1. Launch app and navigate to `/profile` (Profile tab in `CustomBottomNavBar`).
2. Verify top bar: User avatar (~44x44), blue pill `My Activity` button, 3 circular icon buttons (Scan, Menu, Settings).
3. Verify greeting: `Hello, Romina!` in bold typography.
4. Verify announcement card variations:
   - Regular (Screen 62): Neutral container, "Announcement", copy text, circular blue arrow button.
   - Reward (Screen 81): Circular blue heart badge, "You just got a Reward".
   - Voucher expiring (Screen 85): Soft pink background, circular red shopping bag badge, "Your Voucher will expire in 3 days".
5. Verify "Recently viewed": Horizontal row of 5 compact square product cards reusing existing assets. Tapping an item routes to `/product/:id`.
6. Verify "My Orders": 3 tabs (`To Pay`, `To Recieve` with indicator dot, `To Review`). Tapping any tab routes to `/orders?tab=<tab>`.
7. Verify "Stories": Horizontal cards with creator images, central play button, and red "Live" badge on the first card.

---

### Scenario 2: My Activity Dashboard Verification (Screen 64)
1. On Profile Home, tap `My Activity` pill button.
2. Confirm navigation to `/profile/my-activity`.
3. Verify month selector pill: "April" with previous and next circular navigation arrows.
4. Verify Donut Chart:
   - 4 proportional colored segments (Blue 50.1%, Green 25.2%, Orange 12.9%, Red 11.8%).
   - Center displays "Total" and bold amount `$365,00`.
5. Verify Category Legend:
   - 4 pills matching segment colors (`Clothing $183,00`, `Lingerie $92,00`, `Shoes $47,00`, `Bags $43,00`).
6. Verify Order Stats:
   - 3 circular blue badges (`12 Ordered`, `7 Recieved`, `5 To Recieve`).
7. Verify `Order History` CTA:
   - Tapping the full-width blue button navigates to `/orders/history`.

---

### Scenario 3: Active Vouchers & Expiration Alert Verification (Screens 82, 83)
1. Navigate to `/profile/rewards`.
2. Confirm "Active Rewards" tab is selected.
3. Verify ticket-shaped cards with side notch cutouts and horizontal dashed divider.
4. Verify standard vouchers (Screen 82): Blue border, "Voucher" label, coral expiration date ("Valid Until 5.16.20").
5. Verify expiring voucher (Screen 83): First card highlighted with red border, soft pink fill, red dashed cut line, and bold red "3 days left" text.

---

### Scenario 4: Rewards Progress Verification (Screen 84)
1. On `/profile/rewards`, tap the `Progress` tab.
2. Verify tab toggles immediately to active light blue.
3. Verify 2x3 grid displaying 6 achievement milestones:
   - First Purchase (Earned checkmark)
   - Loyal Customer (Earned checkmark)
   - Review Maker
   - Big Soul
   - Cloth Expert
   - 10+ Orders
4. Verify milestone descriptions and badge icons.
5. Tap `Active Rewards` tab and confirm smooth switch back to vouchers without layout stutter.

---

## Final Verification Command (Phase 2 Only)

Per Rule #1 and Rule #12, run static analysis strictly after all tasks are completed:
```powershell
fvm flutter analyze
```
Expected result: **0 issues found**.

