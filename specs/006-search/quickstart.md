# Quickstart & Validation Guide: Search Feature (Screens 28, 29, 30, 31, 32)

## Prerequisites
- Flutter SDK installed and environment healthy.
- Dependencies resolved (`flutter pub get`).

## Execution & Navigation
1. Launch application on simulator or physical device:
   ```bash
   flutter run
   ```
2. Navigate to Search screen:
   - Tap Search entry point or navigate directly to `/search`.
   - Verify `SearchPage` renders inside the persistent bottom navigation shell with Home active.

---

## Verification Scenarios

### 1. Screen 28: Search Main Verification
- **Header**:
  - Verify bold title "Search".
  - Verify light grey rounded search field (`#F5F5F5`) with camera icon inside on the right.
  - Verify close cross button (`✕`) adjacent to search field.
- **Search History**:
  - Header: "Search History" + red trash icon (`#FF3B30`) on the right.
  - 5 History Chips: `Socks`, `Red Dress`, `Sunglasses`, `Mustard Pants`, `80's Skirt`.
  - Tap trash icon: verify chips are cleared from state.
- **Recommendations**:
  - Header: "Recommendations".
  - 5 Chips: `Skirt`, `Accessories`, `Black T-Shirt`, `Jeans`, `White Shoes`.
- **Discover**:
  - Header: "Discover".
  - Horizontal carousel with product cards showing image, title, and price (`$17,00`).
- **Interaction**:
  - Tap chip `Socks`: navigates to `/search/results?q=Socks`.
  - Tap camera icon: navigates to `/search/image`.

### 2. Screen 29: Search Results Verification
- **Header**:
  - Title: "Search".
  - Search field showing active query (e.g. "Socks") with inline `✕` clear icon.
  - Gear icon (`⚙`) on the right.
- **Results Grid**:
  - 2-column responsive layout using `ShopProductCard`.
  - Check regular prices (e.g. `$16,00`, `$17,00`).
  - Check discounted items: current price + coral red strikethrough original price (`$20,00` in `#FF5790`).
- **Filter Modal**:
  - Tap gear icon (`⚙`): verify `FilterModalSheet` from `feature/shop` opens without errors.
- **Clear Query**:
  - Tap inline `✕`: field query clears.

### 3. Screen 30: Image Search Capture Verification
- **View**:
  - Full-screen capture layout with mock image background and top back button.
- **Controls**:
  - 3 bottom circular buttons: Gallery (grey, left), Camera (Primary 400 `#004BFE`, center), More (grey, right).
- **Interaction**:
  - Tap Camera or Gallery button: transitions to Screen 31.

### 4. Screen 31: Image Recognized Verification
- **Selection Frame**:
  - Black rounded-rectangle bounding frame cleanly drawn around recognized product.
- **Retry Button**:
  - White pill button "Retry" centered at bottom.
  - Tap "Retry": returns to Screen 30.
- **Auto Transition / Trigger**:
  - Opens Screen 32 modal sheet.

### 5. Screen 32: Image Search Results Modal Verification
- **Modal Sheet**:
  - Dimmed background, top rounded corners (`24.r`).
  - Header: "Image Search" + circular `✕` button on right.
  - Category row: Blue pill `Shoes` (`#004BFE`) + blue text "Is this what you meant?".
  - 2-column grid of visually similar product cards with pricing.
  - Bottom indicator bar.
- **Dismissal**:
  - Tap `✕` or drag down: modal dismisses, returning to capture screen.

---

### 6. Static Analysis & Verification (Strictly Final Implementation Phase)
- In accordance with Permanent Project Rule 1, run static analysis ONLY after all tasks are complete:
  ```bash
  flutter analyze
  ```
  Must pass with 0 issues.
