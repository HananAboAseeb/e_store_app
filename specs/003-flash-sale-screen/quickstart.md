# Quickstart & Validation Guide: Flash Sale Screen

## Prerequisites
- Flutter SDK installed and environment healthy.
- Dependencies resolved (`flutter pub get`).

## Execution & Navigation
1. Launch app on simulator or physical device:
   ```bash
   flutter run
   ```
2. Navigate to Home Screen (`/home`).
3. Tap on the Flash Sale section header "Flash Sale" or "See All" button.
4. Verify routing navigates smoothly to `/flash-sale`.

## Verification Scenarios

### 1. Visual Verification (Figma Pixel Perfection)
- **AppBar**: Check blue aura gradient behind "Flash Sale" title and stopwatch + 3 countdown boxes `[00] [36] [58]`. Subtitle "Choose Your Discount" displays cleanly below.
- **Filter Chips**: Verify chips `All`, `10%`, `20%`, `30%`, `40%`, `50%`. "20%" is selected by default with active notch pill styling.
- **Live Stream Banner**: Confirm presence of promotional banner with play icon, title "ARTICALE REIMAGINED", and vibrant green "LIVE" badge.
- **Discount Section**: Verify section title reads "20% Discount" with gear icon.
- **Product Grid**: Verify 2-column grid. Each card displays:
  - Grey background with darkened blend image container.
  - `-20%` gradient badge at top right.
  - 2-line title.
  - `$16,00` black bold price.
  - `$20,00` strikethrough red/pink price.
- **Promo Banner**: Verify "Big Sale Up to 50% - Happening Now" split banner.
- **Most Popular**: Verify horizontal carousel showing cards with like count `1780 ❤️` and status labels (`New`, `Sale`, `Hot`).

### 2. Interaction Verification
- **Filter Switching**: Tap on "30%" tab. Section title updates to "30% Discount" and product grid re-filters instantly.
- **Countdown Ticking**: Observe seconds decrementing every second without UI glitches.
- **Pull to Refresh**: Pull down to trigger `refresh()`, verify shimmer loading appears for 1.2s and restores content.

### 3. Static Code Validation
```bash
flutter analyze
```
Must produce 0 errors, 0 warnings.
