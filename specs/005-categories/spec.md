# Feature Specification: Categories (Screen 27)

**Feature Branch**: `feature/categories`

**Created**: 2026-09-16

**Status**: Draft

**Input**: User specification and Figma design reference screenshot for Screen 27 (`assets/design_references/27_CATEGORIES_FILTER.png`). Provides a full-screen modal/panel displaying all product categories grouped by department (All / Female / Male), featuring single-expand accordion behavior, 10 sub-category pills under Clothing, collapsed categories (Shoes, Bags, Accesories), a dedicated "Just for you" entry point, and navigation to filtered catalog listings.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Browse & Expand Category Accordion (Priority: P1)

As a shopper, I want to view a categorized list of all products in an accordion layout with sub-categories for quick browsing, so that I can explore apparel and merchandise categories efficiently.

**Why this priority**: This is the core purpose of Screen 27. Shoppers rely on category hierarchies to locate desired departments and sub-categories.

**Independent Test**: Open the Categories screen (`/categories`). Verify the screen displays the "All Categories" header with a circular dismiss button (`✕`), three gender tabs (`All`, `Female`, `Male`), the `Clothing` accordion expanded by default displaying 10 sub-category pills in a 2-column grid, collapsed tiles for `Shoes`, `Bags`, and `Accesories`, and the `Just for you` card at the bottom. Tapping a collapsed category collapses `Clothing` and expands the tapped category.

**Acceptance Scenarios**:

1. **Given** the user navigates to the Categories screen, **When** the screen finishes loading, **Then** the header displays "All Categories" in bold primary typography, a circular grey dismiss button (`✕`) at the top right, and three gender tabs (`All`, `Female`, `Male`) below the title.
2. **Given** the category list on initial display, **When** rendered, **Then** the `Clothing` card is expanded by default showing a blue clothes hanger icon, "Clothing" title, an upward chevron in a circular pill, and a 2-column grid containing 10 sub-category pills: `Dresses`, `Pants`, `Skirts`, `Shorts`, `Jackets`, `Hoodies`, `Shirts`, `Polo`, `T-Shirts`, and `Tunics`.
3. **Given** the category list, **When** observing collapsed cards, **Then** `Shoes` (sneaker icon), `Bags` (shopping bag icon), and `Accesories` (4-square grid icon) are displayed as rounded white cards with blue category icons, bold titles, and downward chevrons (`⌄`).
4. **Given** the `Clothing` category is expanded, **When** the user taps the `Shoes` category row, **Then** the `Clothing` accordion smoothly collapses and the `Shoes` accordion smoothly expands (accordion single-expansion constraint).
5. **Given** an expanded category, **When** the user taps its header again, **Then** the category collapses to its compact tile state.
6. **Given** the Categories screen, **When** the user taps the circular `✕` button at the top right, **Then** the screen dismisses and returns to the previous view.

---

### User Story 2 - Gender Department Filtering (Priority: P2)

As a shopper, I want to toggle between "All", "Female", and "Male" department tabs, so that I can view categories curated for my chosen gender department.

**Why this priority**: Department segmentation enables shoppers to quickly narrow down catalog exploration to their demographic interest.

**Independent Test**: Tap the "Female" tab, then verify the "Female" tab gains a primary blue border (`#004BFE`) with blue text and white fill, while other tabs revert to light grey fill with neutral text. The category list updates to reflect the female catalog categories. Tap "Male" and verify identical active styling and male department category updates.

**Acceptance Scenarios**:

1. **Given** the Categories screen on initial load, **When** viewing the gender tabs, **Then** `All` is selected by default with an active outline in Primary 400 (`#004BFE`), white background, and blue text, while `Female` and `Male` are styled with light grey background (`#F5F5F5`) and dark text.
2. **Given** the gender tab bar, **When** the user taps `Female`, **Then** the `Female` tab becomes active (blue border, white fill, blue text), `All` reverts to inactive grey fill, and the category list updates with Female department data.
3. **Given** the gender tab bar, **When** the user taps `Male`, **Then** the `Male` tab becomes active and the category list updates with Male department data.
4. **Given** an expanded category, **When** the user switches gender tabs, **Then** the accordion state is preserved or cleanly updated to the active department's default expanded category.

---

### User Story 3 - Navigation to Filtered Catalog & "Just for You" (Priority: P3)

As a shopper, I want to tap any sub-category pill or the "Just for you" row to navigate directly to the product catalog filtered by that selection, so that I can immediately browse matching products.

**Why this priority**: Connects category discovery directly to product purchasing flows.

**Independent Test**: Tap the "Dresses" sub-category pill; verify navigation to `/catalog?subCategory=Dresses`. Return and tap the "Just for you" row circular arrow button; verify navigation to `/catalog?filter=just_for_you`.

**Acceptance Scenarios**:

1. **Given** the expanded `Clothing` category, **When** the user taps a sub-category pill (e.g., `Dresses`), **Then** the app navigates to `/catalog` with query parameter `subCategory=Dresses`.
2. **Given** any other sub-category pill (e.g., `T-Shirts`, `Jackets`), **When** tapped, **Then** the app navigates to `/catalog` with the corresponding `subCategory` query parameter.
3. **Given** the bottom of the category list, **When** viewing the "Just for you" card, **Then** it displays a blue star icon on the left, bold "Just for you" text in the center, and a vibrant blue circular button (`#004BFE`) with a white right-pointing arrow (`→`) on the right.
4. **Given** the "Just for you" card, **When** the user taps the circular arrow button or the card, **Then** the app navigates to `/catalog` with query parameter `filter=just_for_you`.

---

### Edge Cases

- **Rapid Expansion Tapping**: If a user rapidly taps multiple category headers consecutively, debounce or serialize expansion animations to prevent visual stutter or multiple concurrent expansions.
- **Dynamic Text Scaling**: Sub-category pill labels (e.g., `Accesories`, `T-Shirts`) must fit inside 2-column pill buttons without text clipping or ellipsis on standard screens down to `375.w`.
- **Keyboard / Accessibility Focus**: Close button and interactive tiles must meet minimum touch target sizes (`44x44` dp) with clear press feedback.
- **Empty / Error States**: If category data fails to load, display a clean error message with a "Try Again" retry button.
- **Loading State**: Display smooth shimmer placeholder cards matching the dimensions and border radii of the accordion tiles while data is being retrieved.
- **Spelling Consistency**: Preserve Figma text "Accesories" for exact visual fidelity while supporting canonical domain handling.

---

## Requirements *(mandatory)*

### Functional Requirements

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
- **FR-017**: System MUST render a dedicated "Just for you" card with a star icon on the left and a circular Primary 400 (`#004BFE`) button containing a white arrow icon (`→`) on the right.
- **FR-018**: Tapping the "Just for you" card or arrow button MUST navigate to `/catalog?filter=just_for_you`.
- **FR-019**: System MUST display shimmer loading placeholders during initial data retrieval.
- **FR-020**: System MUST provide realistic mock data for all category groups, sub-categories, and gender department associations.
- **FR-021**: All user interface elements MUST strictly use design tokens (`AppColors`, `AppSpacing`, `AppTypography`) and `flutter_screenutil` responsive sizing (`.w`, `.h`, `.r`, `.sp`).
- **FR-022**: State management MUST be implemented using `CategoriesCubit` with immutable `Equatable` states.

---

### Key Entities *(include if feature involves data)*

- **CategoryGroupEntity**: Represents a high-level product category grouping in the accordion list.
  - `id` (String): Unique identifier (e.g., `"clothing"`, `"shoes"`, `"bags"`, `"accesories"`).
  - `name` (String): Category display name (e.g., `"Clothing"`, `"Shoes"`, `"Bags"`, `"Accesories"`).
  - `icon` (dynamic / IconData / String): Vector icon or asset reference matching Figma reference.
  - `gender` (GenderFilter): Applicable department (`all`, `female`, `male`).
  - `subCategories` (List<SubCategoryEntity>): List of child sub-categories.
  - `isExpanded` (bool): Transient expansion state managed by Cubit.

- **SubCategoryEntity**: Represents an individual sub-category pill inside an expanded category.
  - `id` (String): Unique identifier (e.g., `"dresses"`, `"pants"`).
  - `name` (String): Sub-category display label (e.g., `"Dresses"`, `"Pants"`, `"T-Shirts"`).
  - `parentGroupId` (String): Reference to parent category group id.

- **GenderFilter** (Enum):
  - `all`: All departments.
  - `female`: Female department.
  - `male`: Male department.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% pixel-perfect visual match with Figma Screen 27 (`27_CATEGORIES_FILTER.png`) across colors, typography, border radii (`20.r`, `12.r`), and spacing.
- **SC-002**: Screen renders with zero UI layout overflow errors across standard mobile viewports (`375x812`, `390x844`, `412x915`).
- **SC-003**: Accordion expansion/collapse animation completes smoothly within 250ms at 60 FPS without frame drops.
- **SC-004**: Tapping a sub-category pill or "Just for you" navigates to the target catalog route within 100ms.
- **SC-005**: All interactive elements (gender tabs, accordion tiles, sub-category pills, close button) provide responsive touch targets (minimum 44x44 dp) with instant visual feedback.
- **SC-006**: Strict adherence to the 10 Permanent Project Rules and project Constitution.
- **SC-007**: Final code passes `flutter analyze` with zero errors and zero warnings.

---

## Assumptions

- **Phase 1 Implementation**: Feature is backed by local mock data sources with realistic simulated latency; no live external API required in Phase 1.
- **Navigation Flow**: Screen is registered in `go_router` under `/categories` and can be pushed as a modal page or full-screen route from the Home screen, Shop screen, or search bar category entry points.
- **Clean Architecture & Packaging**: Feature is organized under `lib/features/categories/` with explicit layer separation: `domain/`, `data/`, and `presentation/`.
- **Asset Usage**: Existing icons and assets in `assets/images/` and standard Flutter vector icons (`Icons` / `CupertinoIcons`) are reused; no new asset files or placeholder images are generated.

---

## Permanent Project Rules Reference

All implementations for this feature MUST strictly adhere to the Permanent Project Rules from `.specify/memory/constitution.md`:
1. **Verification Timing**: Do NOT run `flutter analyze` or `flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PrimaryButton, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
