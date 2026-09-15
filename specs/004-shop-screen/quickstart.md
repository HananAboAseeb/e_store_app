# Quickstart & Validation Guide: Shop Feature

## Prerequisites
- Flutter SDK installed and environment healthy.
- Dependencies resolved (`flutter pub get`).

## Execution & Navigation
1. Launch app on simulator or physical device:
   ```bash
   flutter run
   ```
2. Navigate to the 3rd tab in the bottom navigation bar (Catalog / Shop).
3. Verify routing displays the Shop page (`/catalog`).

## Verification Scenarios

### 1. Visual Verification (Figma Pixel Perfection)
- **AppBar**: Check title "Shop", active category pill `[Clothing ✕]`, camera icon, and gear filter icon (`⚙`).
- **Category Grid**: Verify 2-row category grid showing 9 items:
  - Row 1: Dresses, Pants, Skirts, Tunics, Jackets.
  - Row 2: Hoodies, Shirts, Polo, T-shirts.
  - Each item displays rounded grey square background (`16.r`) with centered apparel illustration and text below.
- **Section Header**: Verify "All Items" row with filter gear icon on the right.
- **Product Grid**: Verify 2-column grid:
  - Screen 25 view: Full-price items with `$16,00` black bold price.
  - Screen 26 view (scrolled): Sale items with current price `$16,00` / `$17,00` and crossed-out `$20,00` in coral red.
- **Filter Modal (Screen 33)**: Tap gear icon (`⚙`):
  - Top bar: "Filter" title + circular close `✕` button.
  - Category multi-select: Tapping categories toggles blue circular checkmark badge on top right of the tile.
  - Size section: `[ Clothes | Shoes ]` pill switch. Size pills `XS, S, M, L, XL, 2XL`. Selected `M` has circular white badge with blue border and indicator notches.
  - Color section: Row of circles (White, Charcoal, Blue, Red, Teal, Yellow, Purple). Active white circle has blue outline and checkmark.
  - Price Range: Live label `$10 - $150` with dual-thumb RangeSlider.
  - Sort: Chips for `Popular` (with checkmark), `Newest`, `Price Hight to Low`.
  - Actions: `Clear` (resets all selections) and `Apply` (closes modal and updates Shop grid).

### 2. Static Code Validation
```bash
flutter analyze
```
Must produce 0 errors, 0 warnings.
