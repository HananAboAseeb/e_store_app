# Feature Specification: Categories (Screen 27 & Screen 43 Enhancement)

**Feature Branch**: `feature/categories`

**Created**: 2026-09-16 | **Updated**: 2026-09-28

**Status**: Ready for Planning

**Parent Feature**: `categories` (existing)

**Input**: User specification and design references for Screen 27 (`assets/design_references/27_CATEGORIES_FILTER.png`) and Screen 43 (`assets/design_references/43 CATEGORIES JUST FOR YOU.png`). Enhances the existing Categories feature by adding Screen 43 ("Categories Just for you") accessible from the "Just for you" row inside Screen 27.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Browse & Expand Category Accordion (Screen 27) (Priority: P1)

As a shopper, I want to view a categorized list of all products in an accordion layout with sub-categories for quick browsing, so that I can explore apparel and merchandise categories efficiently.

**Why this priority**: Core foundational capability of Screen 27. Shoppers rely on category hierarchies to locate desired departments and sub-categories.

**Independent Test**: Open the Categories screen (`/categories`). Verify the screen displays the "All Categories" header with a circular dismiss button (`✕`), three gender tabs (`All`, `Female`, `Male`), the `Clothing` accordion expanded by default displaying 10 sub-category pills in a 2-column grid, collapsed tiles for `Shoes`, `Bags`, and `Accesories`, and the `Just for you` card at the bottom. Tapping a collapsed category collapses `Clothing` and expands the tapped category.

**Acceptance Scenarios**:

1. **Given** the user navigates to the Categories screen, **When** the screen finishes loading, **Then** the header displays "All Categories" in bold primary typography, a circular grey dismiss button (`✕`) at the top right, and three gender tabs (`All`, `Female`, `Male`) below the title.
2. **Given** the category list on initial display, **When** rendered, **Then** the `Clothing` card is expanded by default showing a blue clothes hanger icon, "Clothing" title, an upward chevron in a circular pill, and a 2-column grid containing 10 sub-category pills: `Dresses`, `Pants`, `Skirts`, `Shorts`, `Jackets`, `Hoodies`, `Shirts`, `Polo`, `T-Shirts`, and `Tunics`.
3. **Given** the category list, **When** observing collapsed cards, **Then** `Shoes` (sneaker icon), `Bags` (shopping bag icon), and `Accesories` (4-square grid icon) are displayed as rounded white cards with blue category icons, bold titles, and downward chevrons (`⌄`).
4. **Given** the `Clothing` category is expanded, **When** the user taps the `Shoes` category row, **Then** the `Clothing` accordion smoothly collapses and the `Shoes` accordion smoothly expands (accordion single-expansion constraint).
5. **Given** an expanded category, **When** the user taps its header again, **Then** the category collapses to its compact tile state.
6. **Given** the Categories screen, **When** the user taps the circular `✕` button at the top right, **Then** the screen dismisses and returns to the previous view.

---

### User Story 2 - Gender Department Filtering (Screen 27) (Priority: P2)

As a shopper, I want to toggle between "All", "Female", and "Male" department tabs, so that I can view categories curated for my chosen gender department.

**Why this priority**: Department segmentation enables shoppers to quickly narrow down catalog exploration to their demographic interest.

**Independent Test**: Tap the "Female" tab, then verify the "Female" tab gains a primary blue border (`#004BFE`) with blue text and white fill, while other tabs revert to light grey fill with neutral text. The category list updates to reflect the female catalog categories. Tap "Male" and verify identical active styling and male department category updates.

**Acceptance Scenarios**:

1. **Given** the Categories screen on initial load, **When** viewing the gender tabs, **Then** `All` is selected by default with an active outline in Primary 400 (`#004BFE`), white background, and blue text, while `Female` and `Male` are styled with light grey background (`#F5F5F5`) and dark text.
2. **Given** the gender tab bar, **When** the user taps `Female`, **Then** the `Female` tab becomes active (blue border, white fill, blue text), `All` reverts to inactive grey fill, and the category list updates with Female department data.
3. **Given** the gender tab bar, **When** the user taps `Male`, **Then** the `Male` tab becomes active and the category list updates with Male department data.
4. **Given** an expanded category, **When** the user switches gender tabs, **Then** the accordion state is preserved or cleanly updated to the active department's default expanded category.

---

### User Story 3 - Sub-Category Catalog Navigation & "Just for You" Entry (Screen 27) (Priority: P2)

As a shopper, I want to tap any sub-category pill to navigate directly to the filtered catalog, or tap the "Just for you" row to navigate to personalized recommendations, so that I can discover relevant merchandise seamlessly.

**Why this priority**: Connects category browsing directly to product browsing and personal recommendations.

**Independent Test**: Tap the "Dresses" sub-category pill; verify navigation to `/catalog?subCategory=Dresses`. Return and tap the "Just for you" row circular blue arrow button (`→`); verify navigation opens Screen 43 (`/categories/just-for-you`).

**Acceptance Scenarios**:

1. **Given** the expanded `Clothing` category, **When** the user taps a sub-category pill (e.g., `Dresses`), **Then** the app navigates to `/catalog` with query parameter `subCategory=Dresses`.
2. **Given** any other sub-category pill (e.g., `T-Shirts`, `Jackets`), **When** tapped, **Then** the app navigates to `/catalog` with the corresponding `subCategory` query parameter.
3. **Given** the bottom of the category list in Screen 27, **When** viewing the "Just for you" card, **Then** it displays a blue star icon on the left, bold "Just for you" text in the center, and a vibrant blue circular button (`#004BFE`) with a white right-pointing arrow (`→`) on the right.
4. **Given** the "Just for you" card, **When** the user taps the circular arrow button or the card, **Then** the app navigates to Screen 43 (`/categories/just-for-you`).

---

### User Story 4 - Categories "Just for you" Personalized Recommendations Feed (Screen 43 Enhancement) (Priority: P1)

As a shopper, I want to browse a dedicated, personalized "Just for you" product recommendations screen with a 2-column grid of curated products, so that I can discover and purchase items tailored specifically to my interests.

**Why this priority**: Fulfills the missing Screen 43 enhancement, completing the category discovery journey and connecting shoppers directly to tailored product offerings.

**Independent Test**: Navigate to Screen 43 by tapping the blue arrow button (`→`) on the "Just for you" card in Screen 27. Verify the screen opens with a top title "Categories" in bold typography, followed by a section header containing a blue star icon and bold "Just for you" text. Verify a 2-column scrollable grid displays product cards matching the Shop feature card layout, complete with images, titles, and formatted prices. Tap a product card to verify navigation to its product details screen. Tap the back button or swipe back to verify return to Screen 27 without losing category list state.

**Acceptance Scenarios**:

1. **Given** the user is on Screen 27, **When** tapping the circular blue arrow button (`→`) in the "Just for you" card, **Then** the app pushes the dedicated route `/categories/just-for-you` and displays Screen 43.
2. **Given** Screen 43 is opening, **When** data is loading, **Then** shimmer loading placeholders matching the 2-column product card layout are displayed.
3. **Given** Screen 43 finishes loading, **When** rendered, **Then** the top of the screen displays the title "Categories" in large bold primary typography (`Raleway`, `AppColors.textPrimary`), with a system-standard back navigation mechanism.
4. **Given** Screen 43 content area, **When** observing below the main title, **Then** a section header is displayed containing a vibrant blue star icon (`AppColors.primary`) followed by "Just for you" in bold prominent typography.
5. **Given** Screen 43 recommendations grid, **When** viewing products, **Then** products are arranged in a responsive 2-column grid reusing the identical product card component and layout from `feature/shop` (`ShopProductCard`).
6. **Given** each product card in the grid, **When** rendered, **Then** it displays:
   - Rounded image container with `16.r` corner radius and `Color(0xFFF5F5F5)` background.
   - Product title limited to a maximum of 2 lines with ellipsis overflow in secondary text color (`AppColors.textSecondary`, `13.sp`).
   - Formatted bold price in primary text color (`AppColors.textPrimary`, `16.sp`, `Raleway` bold, formatted as `$XX,XX`).
7. **Given** a discounted product in the grid, **When** rendered, **Then** the card displays the active sale price alongside the strikethrough original price in discount accent color (`#FF5790`) identical to the Shop feature.
8. **Given** the product grid in Screen 43, **When** the user scrolls vertically, **Then** the grid scrolls smoothly revealing the full catalog of recommended items.
9. **Given** any product card in Screen 43, **When** the user taps the card, **Then** the app navigates to `/product/:id` for the corresponding product.
10. **Given** Screen 43, **When** the user triggers back navigation, **Then** the screen pops cleanly and returns to Screen 27, leaving Screen 27's accordion expansion and gender selection unchanged.

---

### Edge Cases

- **Empty Recommendations Feed**: If the "Just for you" product query returns an empty list, display a clean empty state illustration with an informative message ("No recommendations available right now") and a refresh action.
- **Product Image Loading Failure**: If a product image fails to load or the asset is missing, render a fallback placeholder container (`Color(0xFFF5F5F5)`) with an image placeholder icon (`Icons.image_outlined`) in `AppColors.gray400`, preventing layout distortion or crashes.
- **Rapid Navigation Tapping**: Tapping a product card multiple times in rapid succession must be debounced to prevent pushing multiple duplicate product detail routes onto the navigation stack.
- **Device Viewport Adaptation**: The 2-column grid aspect ratio and horizontal padding (`16.w` to `20.w`) must adjust smoothly on narrow screens (`375.w`) as well as larger screens (`412.w`+) without text clipping, card overflow, or unaligned price rows.
- **Long Product Titles**: Titles exceeding 2 lines must truncate cleanly with an ellipsis (`TextOverflow.ellipsis`) while preserving the fixed price row baseline across adjacent cards in the same row.
- **Back Navigation Independence**: Dismissing or popping Screen 43 must not trigger a reload of Screen 27 or reset its active gender tab or expanded accordion item.

---

## Requirements *(mandatory)*

### Functional Requirements

#### Screen 27 (All Categories)
- **FR-001**: System MUST provide the Categories screen mounted at route `/categories`, presented as a navigable full-screen modal/page.
- **FR-002**: System MUST render a top App Bar featuring the large bold title "All Categories" and a circular close button (`✕`) at the top right.
- **FR-003**: Circular close button MUST dismiss the Categories screen and return to the previous screen using `context.pop()`.
- **FR-004**: System MUST render a horizontal row of 3 gender tabs: `All`, `Female`, and `Male`.
- **FR-005**: Active gender tab MUST be styled with a Primary 400 (`#004BFE`) border, white background, and blue text. Inactive tabs MUST be styled with a light grey background (`#F5F5F5`) and secondary/primary dark text.
- **FR-006**: Single-select behavior MUST be enforced for gender tabs with `All` selected by default.
- **FR-007**: Tapping a gender tab MUST filter or update the category groups according to the selected gender (`GenderFilter.all`, `GenderFilter.female`, `GenderFilter.male`).
- **FR-008**: System MUST render category groups as rounded cards (`20.r` border radius) on white surface with subtle elevation/shadow matching Screen 27.
- **FR-009**: Each category card MUST display an outline icon in Primary 400 (`#004BFE`) on the left, bold category name in the center, and a chevron icon on the right indicating expansion state.
- **FR-010**: Category icons MUST match Figma Screen 27 visual specifications:
  - Clothes hanger for `Clothing`
  - Sneaker/shoe for `Shoes`
  - Shopping/tote bag for `Bags`
  - 4-square grid for `Accesories`
  - Star for `Just for you`
- **FR-011**: System MUST enforce accordion single-expansion behavior: at most one category group may be expanded at a time; expanding a category collapses any previously open group.
- **FR-012**: `Clothing` category MUST be expanded by default on initial screen load.
- **FR-013**: Expanded category content MUST render a 2-column grid of rounded sub-category pills (`12.r` radius) on light grey background (`#F5F5F5`).
- **FR-014**: Expanded `Clothing` sub-categories MUST include all 10 items in exact 2-column arrangement:
  - Column 1: `Dresses`, `Skirts`, `Jackets`, `Shirts`, `T-Shirts`
  - Column 2: `Pants`, `Shorts`, `Hoodies`, `Polo`, `Tunics`
- **FR-015**: Tapping any sub-category pill MUST navigate to the Shop/Catalog screen (`/catalog?subCategory=<name>`) using `go_router`.
- **FR-016**: Categories `Shoes`, `Bags`, and `Accesories` MUST display as collapsed rows with downward chevrons (`⌄`).
- **FR-017**: System MUST render a dedicated "Just for you" card with a blue star icon on the left, bold "Just for you" text in the center, and a circular Primary 400 (`#004BFE`) button containing a white arrow icon (`→`) on the right.
- **FR-018**: Tapping the "Just for you" card or blue arrow button (`→`) MUST navigate to Screen 43 (`/categories/just-for-you`) via `go_router`.
- **FR-019**: System MUST display shimmer loading placeholders during initial category data retrieval.
- **FR-020**: System MUST provide realistic mock data for all category groups, sub-categories, and gender department associations.
- **FR-021**: All user interface elements MUST strictly use design tokens (`AppColors`, `AppSpacing`, `AppTypography`) and `flutter_screenutil` responsive sizing (`.w`, `.h`, `.r`, `.sp`).
- **FR-022**: State management for Screen 27 MUST be implemented using `CategoriesCubit` with immutable `Equatable` states.

#### Screen 43 (Categories Just for you Enhancement)
- **FR-023**: System MUST provide Screen 43 ("Categories Just for you") mounted at dedicated route `/categories/just-for-you` (or named route `RouteNames.kCategoriesJustForYouPage`), accessible from Screen 27.
- **FR-024**: Screen 43 MUST support standard back navigation returning to Screen 27 without reloading or modifying Screen 27 category state.
- **FR-025**: Screen 43 MUST render a top title "Categories" in large bold primary typography (`Raleway`, bold, `AppColors.textPrimary`).
- **FR-026**: Screen 43 MUST render a section header positioned below the title, containing a vibrant blue star icon (`AppColors.primary`) followed by "Just for you" in bold prominent typography (`18.sp`, bold, `AppColors.textPrimary`).
- **FR-027**: Screen 43 MUST display a vertically scrollable 2-column grid of product recommendation cards.
- **FR-028**: Screen 43 MUST reuse the existing `ShopProductCard` widget from `feature/shop` without duplicating product card layout or styling code.
- **FR-029**: Each product card in the grid MUST display:
  - Product image inside a container with `16.r` rounded corners and light background (`Color(0xFFF5F5F5)`).
  - Product title constrained to a maximum of 2 lines with ellipsis truncation in secondary text color (`AppColors.textSecondary`, `13.sp`).
  - Formatted price in bold typography (`16.sp`, `Raleway` bold, `AppColors.textPrimary`, formatted as `$XX,XX`).
- **FR-030**: For discounted products, the card MUST display the sale price alongside the original price formatted with strikethrough in discount accent color (`#FF5790`), reusing the existing discount display behavior in `ShopProductCard`.
- **FR-031**: Tapping any product card in Screen 43 MUST navigate to `/product/:id` passing the product's unique identifier via `go_router`.
- **FR-032**: Screen 43 MUST display shimmer loading placeholders matching the 2-column product grid dimensions during data loading.
- **FR-033**: Screen 43 MUST load its product data independently from Screen 27 categories state via a dedicated use case / repository method (`GetJustForYouProductsUseCase`).
- **FR-034**: Screen 43 MUST supply realistic Phase 1 mock data for "Just for you" products utilizing existing project product image assets (`assets/images/` and catalog assets).
- **FR-035**: All UI elements in Screen 43 MUST strictly reference tokens from `AppColors`, `AppSpacing`, and `AppTypography` adhering to Rule #11. No hardcoded colors or spacing values are permitted.

---

### Key Entities *(include if feature involves data)*

- **CategoryGroupEntity**: Represents a high-level product category grouping in the accordion list (Screen 27).
  - `id` (String): Unique identifier (e.g., `"clothing"`, `"shoes"`, `"bags"`, `"accesories"`).
  - `name` (String): Category display name (e.g., `"Clothing"`, `"Shoes"`, `"Bags"`, `"Accesories"`).
  - `icon` (dynamic / IconData / String): Vector icon or asset reference matching Figma reference.
  - `gender` (GenderFilter): Applicable department (`all`, `female`, `male`).
  - `subCategories` (List<SubCategoryEntity>): List of child sub-categories.
  - `isExpanded` (bool): Transient expansion state.

- **SubCategoryEntity**: Represents an individual sub-category pill inside an expanded category (Screen 27).
  - `id` (String): Unique identifier (e.g., `"dresses"`, `"pants"`).
  - `name` (String): Sub-category display label (e.g., `"Dresses"`, `"Pants"`, `"T-Shirts"`).
  - `parentGroupId` (String): Reference to parent category group id.

- **GenderFilter** (Enum):
  - `all`: All departments.
  - `female`: Female department.
  - `male`: Male department.

- **JustForYouProductEntity / ShopProductEntity**: Represents a recommended product card item displayed on Screen 43 (reusing or extending existing product domain structure).
  - `id` (String): Unique product identifier.
  - `title` (String): Product display title (e.g., `"Lorem ipsum dolor sit amet consectetur"`).
  - `imageUrl` (String): Local asset path for product image.
  - `price` (double): Current selling price.
  - `originalPrice` (double?): Original price prior to discount (optional).
  - `isDiscounted` (bool): Flag indicating active promotional pricing.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% pixel-perfect visual match with Figma Screen 27 (`27_CATEGORIES_FILTER.png`) and Screen 43 (`43 CATEGORIES JUST FOR YOU.png`) across colors, typography, border radii (`20.r`, `16.r`, `12.r`), and spacing.
- **SC-002**: Screen 43 renders cleanly with zero UI layout overflow errors across standard mobile viewports (`375x812`, `390x844`, `412x915`).
- **SC-003**: 100% component reuse of `ShopProductCard` and 2-column grid layout pattern from `feature/shop` without duplicating card or discount presentation logic (DRY compliance).
- **SC-004**: Tapping the "Just for you" row blue arrow (`→`) in Screen 27 navigates to Screen 43 in under 100ms.
- **SC-005**: Tapping any product card in Screen 43 navigates to the target product details route (`/product/:id`) in under 100ms.
- **SC-006**: Back navigation from Screen 43 cleanly restores Screen 27 state without reload, animation glitch, or visual flicker.
- **SC-007**: Strict adherence to all 11 Permanent Project Rules and project Constitution v1.2.0.
- **SC-008**: Final codebase passes `flutter analyze` with zero errors and zero warnings.

---

## Assumptions

- **Phase 1 Mock Data**: The "Just for you" product feed is populated with local mock data containing realistic items, prices, and images from existing project image assets; no live network API is required.
- **Router Configuration**: Route name `kCategoriesJustForYouPage = '/categories/just-for-you'` is added to `RouteNames` and registered in `AppRouter` as a sub-route or sibling route with transition animations.
- **State Independence**: Screen 43 manages its own state (via a dedicated Cubit or state within the categories presentation layer) so that loading or navigating Screen 43 does not re-trigger category accordion state.
- **Component Reuse**: `ShopProductCard` from `lib/features/shop/presentation/widgets/shop_product_card.dart` is reused directly.
- **Design Tokens**: All styling leverages existing `AppColors`, `AppSpacing`, and `AppTypography` tokens; no new tokens are required.

---

## Permanent Project Rules Reference

All features MUST strictly comply with the Permanent Project Rules defined in the project Constitution (`.specify/memory/constitution.md`):
1. **Verification Timing**: Do NOT run `flutter analyze` or `flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (.w, .h, .r, .sp). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PrimaryButton, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
11. **STRICT COLOR & TOKEN ENFORCEMENT**: All colors, spacing, and typography must reference tokens from `AppColors`, `AppSpacing`, and `AppTypography`. No hardcoded values are allowed. If a token is missing, add it to the tokens file first.
