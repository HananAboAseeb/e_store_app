# Quickstart & Validation Guide: Categories Feature (Screen 27 & Screen 43)

## Prerequisites
- Flutter SDK installed and environment healthy.
- Dependencies resolved (`flutter pub get`).

## Execution & Navigation
1. Launch application:
   ```bash
   flutter run
   ```
2. Navigate to Categories (`/categories`).
3. Tap the "Just for you" row blue arrow (`→`) to open Screen 43 (`/categories/just-for-you`).

---

## Verification Scenarios

### 1. Screen 27 (All Categories) Verification
- **App Bar**: Bold "All Categories" title, circular close button (`✕`) pops screen.
- **Gender Tabs**: `All` active by default with blue border (`#004BFE`). Switching tabs filters categories.
- **Accordion Groups**: `Clothing` expanded by default with 10 pills in 2 columns. Tapping another group expands it and collapses `Clothing`.
- **"Just for you" Entry Point**:
  - Located below category list.
  - Blue star icon on the left, bold "Just for you" title.
  - Circular blue button (`#004BFE`) with white right arrow (`→`) on the right.
  - Tapping the card or arrow navigates to `/categories/just-for-you`.

---

### 2. Screen 43 (Categories Just for you) Verification
- **Top Header**:
  - Title "Categories" in large bold typography (`Raleway`, bold, `AppColors.textPrimary`).
  - Standard back navigation button (returns cleanly to Screen 27).
- **Section Header**:
  - Blue star icon (`AppColors.primary`) followed by bold "Just for you" (`18.sp`, bold, `AppColors.textPrimary`).
- **Loading State**:
  - Shimmer placeholder grid matching the 2-column card layout while data loads.
- **2-Column Product Grid**:
  - Reuses `ShopProductCard` from `feature/shop` without UI distortion.
  - Product images in rounded containers (`16.r`) with `#F5F5F5` background.
  - Titles displayed in secondary text color, max 2 lines with ellipsis truncation.
  - Price in bold typography formatted as `$XX,XX`.
  - Discounted products show strikethrough original price in `#FF5790` alongside bold sale price.
- **Interactions**:
  - Vertically scrollable through full recommendation list.
  - Tapping any product card navigates to `/product/:id`.
  - Pressing back pops to Screen 27 with previously selected gender and accordion expansion state intact.

---

### 3. Static Code Validation (Strictly Final Implementation Phase)
- Note: Run only in the final implementation phase per Permanent Project Rule 1:
  ```bash
  flutter analyze
  ```
  Must pass with 0 errors and 0 warnings.
