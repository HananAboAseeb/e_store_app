# Phase 1: Quickstart Validation Guide — Wishlist & Recently Viewed

**Feature Directory**: `specs/011-wishlist`  
**Date**: 2026-09-29  
**Status**: Completed  

---

## 1. Prerequisites & Setup

Ensure dependencies are available and FVM Flutter SDK 3.44.6 is configured:
```powershell
fvm flutter pub get
```

---

## 2. Validation Scenarios

### Scenario 1: Populated Wishlist (Screen 38)
1. Launch the app:
   ```powershell
   fvm flutter run --flavor dev -t lib/main_dev.dart
   ```
2. Tap the 2nd bottom navigation tab (`Wishlist` heart icon).
3. **Verify**:
   - Top app bar displays "Wishlist" with a circular `✕` button on the right.
   - 5 wishlist items are rendered in a vertical list.
   - Each item displays:
     - 90.w rounded image with circular delete icon at bottom-left.
     - 2-line title, bold price, `Pink` and `M` meta pills.
     - Blue add-to-cart button on the right.

### Scenario 2: Deleting Items & Empty State (Screen 38 Empty)
1. On the Wishlist screen, tap the delete (trash) icon on each item until all items are removed.
2. **Verify**:
   - Deleting an item immediately removes it from the list.
   - When the 5th (last) item is deleted, the view seamlessly displays the Empty Wishlist screen:
     - Circular grey badge with blue heart icon.
     - "Your Wishlist is Empty" heading.
     - "Most Popular" section with "See All →" and horizontal carousel of `PopularProductCard` items.
3. Tap "See All →" and verify navigation to `/catalog`.

### Scenario 3: Recently Viewed Products (Screen 39)
1. Navigate to `/wishlist/recently-viewed`.
2. **Verify**:
   - Header shows "Recently viewed" with circular `✕` button.
   - Tabs row displays "Today" (selected with soft blue background and blue checkmark) and "Yesterday" (unselected).
   - Circular blue chevron-down button `∨` is displayed on the right.
   - 2-column grid of `ShopProductCard` items viewed Today is rendered.
3. Tap "Yesterday" and verify the product grid filters to items viewed yesterday.

### Scenario 4: Calendar Date Picker & Selected Date (Screens 40 & 41)
1. On the Recently Viewed screen, tap the circular blue chevron-down button `∨`.
2. **Verify**:
   - Inline calendar card expands directly beneath the header (Screen 40).
   - Month pill shows "April" with `<` and `>` navigation arrows.
   - 7-column day grid (01 to 31) is rendered.
   - An upward chevron button `^` is visible at the bottom of the calendar card.
3. Tap day `18`.
4. **Verify**:
   - Day 18 highlights, the calendar collapses, and a new tab "April, 18" (active with blue checkmark) appears in the tabs row (Screen 41).
   - The 2-column grid re-filters to display items viewed on April 18.

---

## 3. Automated Verification Commands (Strictly for Final Implementation Phase)

```powershell
# Format check
dart format --output=none --set-exit-if-changed lib test

# Static analysis (0 errors expected)
fvm flutter analyze

# Unit & Widget tests
fvm flutter test test/features/wishlist/
```
