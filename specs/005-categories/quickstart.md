# Quickstart & Validation Guide: Categories Feature (Screen 27)

## Prerequisites
- Flutter SDK installed and environment healthy.
- Dependencies resolved (`flutter pub get`).

## Execution & Navigation
1. Launch application on simulator or physical device:
   ```bash
   flutter run
   ```
2. Navigate to the Categories screen (`/categories`) or trigger the All Categories entry point.
3. Verify routing displays `CategoriesPage`.

---

## Verification Scenarios

### 1. Visual Verification (Figma Pixel Perfection - Screen 27)
- **Top App Bar**:
  - Check large bold title "All Categories".
  - Check circular close button (`✕`) with light grey background circle (`#F5F5F5`).
- **Gender Tabs**:
  - Verify 3 tabs: `All`, `Female`, `Male`.
  - Verify `All` has blue border (`#004BFE`), white background, and blue text by default.
  - Inactive tabs have `#F5F5F5` background and neutral text.
  - Tap `Female` and `Male`; verify active tab updates styling cleanly.
- **Accordion Categories**:
  - `Clothing`: Expanded by default. Displays blue clothes hanger icon, bold title, upward chevron (`^`).
  - 10 Sub-category pills inside `Clothing` arranged in 2 columns:
    - Col 1: `Dresses`, `Skirts`, `Jackets`, `Shirts`, `T-Shirts`
    - Col 2: `Pants`, `Shorts`, `Hoodies`, `Polo`, `Tunics`
    - Rounded corners (`12.r`), light grey fill (`#F5F5F5`).
  - `Shoes`: Collapsed row with blue sneaker icon, title, down chevron (`⌄`).
  - `Bags`: Collapsed row with blue tote bag icon, title, down chevron (`⌄`).
  - `Accesories`: Collapsed row with blue 4-square grid icon, title, down chevron (`⌄`).
  - Tap `Shoes`: `Clothing` collapses smoothly and `Shoes` expands.
- **"Just for you" Card**:
  - Blue outline star icon on the left, bold "Just for you" title.
  - Circular blue button (`#004BFE`) with white right arrow (`→`) on the right.

### 2. Navigation Verification
- Tap any sub-category pill (e.g. `Dresses`): Navigates to `/catalog?subCategory=Dresses`.
- Tap `Just for you` row / arrow: Navigates to `/catalog?filter=just_for_you`.
- Tap `✕` close button: Pops back to the preceding screen via `context.pop()`.

### 3. Static Code Validation (Strictly Final Implementation Phase)
- Note: Run only in the final implementation phase per Permanent Project Rule 1:
  ```bash
  flutter analyze
  ```
  Must report 0 errors, 0 warnings.
