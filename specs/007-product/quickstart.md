# Quickstart Validation Guide: Product Feature (Screens 34, 35, 36, 37)

**Feature**: `specs/007-product` | **Date**: 2026-09-17

This guide defines the end-to-end verification procedures to validate that the **Product** feature operates correctly across all user journeys and Figma design specifications.

---

## 1. Prerequisites

- Flutter environment managed via FVM (`C:\Users\user\fvm\versions\3.44.6\bin\flutter.bat`).
- Project root: `e:\e_store\e_store`.
- No new image generation (reuse existing `assets/images/`).

---

## 2. Validation Scenarios

### Scenario 1: Product Details Overview (Screens 34 & 36)
1. **Action**: Open the app and navigate to `/product/caviar-jacket`.
2. **Expected Outcome**:
   - Initial viewport renders Screen 36 (Image gallery with dot indicators, breadcrumb `Shop > Jackets > Caviar`, heart and share icons, title "Caviar Leather Jacket", rating `4.7` with `2986 Comments >`, 3 color variant thumbnails with blue selection indicator on active choice, and expandable size pill `M`).
   - Sticky bottom bar shows `$17,00` price point and blue "Add to Basket" button.
3. **Scroll Test**:
   - Scroll down to reveal Screen 34 full contents: Specifications pills (`Cotton: 95%`, `Nylon: 5%`, `EUROPE`), Delivery options (Standard & Express), Ratings breakdown (`4.7`, `3654 Scores`, 5 star distribution bars), Reviews preview (2 cards with "View All 2986 Reviews" button), "Most Popular" horizontal carousel, and "You Might Like" 2-column grid.

### Scenario 2: Variant Selection & Image Synchronization
1. **Action**: Tap on the second color variant thumbnail (Purple).
2. **Expected Outcome**:
   - Blue selection border moves to the Purple variant thumbnail.
   - Main image gallery updates to show Purple variant photography.
3. **Action**: Tap the Size selector pill and choose `L`.
4. **Expected Outcome**:
   - Selected size updates to `L`.

### Scenario 3: Flash Sale Banner & Live Countdown (Screen 35)
1. **Action**: Navigate to `/product/caviar-jacket?sale=true`.
2. **Expected Outcome**:
   - Red flash sale banner (`#FF3B30`) is displayed between the gallery and breadcrumbs.
   - Banner displays sale price `$17,00`, strikethrough `$24,00`, `-20%` pill, and live countdown timer boxes (`HH : MM : SS`).
   - Countdown timer ticks down synchronously every second.
   - When timer reaches `00:00:00`, banner dismisses and price reverts to `$24,00`.

### Scenario 4: All Reviews Navigation & Interactions (Screen 37)
1. **Action**: On the Product Details page, tap "View All 2986 Reviews".
2. **Expected Outcome**:
   - Dedicated Reviews screen pushes smoothly with "Reviews" header and circular `✕` button.
   - Displays list of review cards with author avatar, author name "Veronica", 4/5 gold stars, review text, like counter (`24 ↑`), dislike counter (`24 ↓`), and relative date (`2 Days Ago`).
3. **Action**: Tap the thumbs up (`↑`) or thumbs down (`↓`) button on a review card.
4. **Expected Outcome**:
   - Like or dislike counter increments optimistically and icon toggles state.
5. **Action**: Tap the circular `✕` button at the top right.
6. **Expected Outcome**:
   - Route pops and returns cleanly to the Product Details page.

---

## 3. Automated Verification Commands (To run at final implementation phase)

```bash
# Analyze project for 0 errors/warnings
C:\Users\user\fvm\versions\3.44.6\bin\flutter.bat analyze

# Run all unit and widget tests
C:\Users\user\fvm\versions\3.44.6\bin\flutter.bat test
```
