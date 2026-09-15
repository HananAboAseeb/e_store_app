# Feature Specification: Shop Screen (Screens 25, 26, 33)

**Feature Branch**: `feature/shop`

**Created**: 2026-09-10

**Status**: Draft

**Input**: User description and Figma design screenshots for Screens 25 (Shop Main - Clothing), 26 (Shop Scrolled - Clothing with discounts), and 33 (Filter Modal). Browsing catalog by sub-categories, 2-column product grid with regular and discounted pricing, and multi-faceted filter screen.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Browse Products & Sub-Categories in Shop (Priority: P1)

As a shopper, I want to browse products under the "Shop" tab and view items organized by sub-categories (Dresses, Pants, Skirts, Tunics, Jackets, Hoodies, Shirts, Polo, T-shirts), so that I can quickly explore the apparel collection.

**Why this priority**: Core value of the Shop screen is product catalog discovery and category navigation.

**Independent Test**: Navigate to the Shop tab (Catalog branch in bottom navigation bar). Verify that the header displays "Shop", an active category chip `[Clothing ✕]`, a camera icon, a 2-row category grid with 9 clothing items, an "All Items" section header with a filter gear button (`⚙`), and a 2-column grid of products with images, titles, and regular prices (`$16,00`).

**Acceptance Scenarios**:

1. **Given** the user navigates to the Shop/Catalog tab, **When** the screen loads, **Then** the App Bar displays the title "Shop", an active category pill `[Clothing ✕]` in primary blue styling with a dismiss cross, and a camera icon button on the right.
2. **Given** the Shop screen top section, **When** observing the sub-categories, **Then** a 2-row grid displays 9 items (Row 1: Dresses, Pants, Skirts, Tunics, Jackets; Row 2: Hoodies, Shirts, Polo, T-shirts), each with a rounded light grey image container (`16.r`), product illustration, and centered category label underneath.
3. **Given** the category grid, **When** the user taps any sub-category tile (e.g., "T-shirts"), **Then** the product list updates to show items matching that sub-category, and the active filter pill or indicator reflects the selection.
4. **Given** the section below categories, **When** viewed, **Then** a section header "All Items" is shown on the left, with a settings/filter gear icon (`⚙`) on the right.
5. **Given** the product grid, **When** viewing the cards, **Then** items are presented in a responsive 2-column grid. Each card displays a rounded model photo (`16.r` or `20.r`), a single or two-line title ("Lorem ipsum dolor sit amet consectetur"), and price (`$16,00`) formatted in bold Raleway font.

---

### User Story 2 - Infinite Browsing with Discounted Pricing on Scroll (Priority: P2)

As a shopper, I want to scroll through the product grid continuously and see discounted sale items highlighted with strike-through pricing, so that I can easily spot deals while browsing.

**Why this priority**: Users expect seamless scrolling and clear visual differentiation between full-price items and discounted sale items.

**Independent Test**: Scroll down the product grid on the Shop screen; verify that the category section scrolls away, the top bar remains pinned with "Shop", `[Clothing ✕]`, camera icon, and gear filter icon (`⚙`), and discounted products appear showing bold current price (`$16,00` / `$17,00`) alongside strike-through original price (`$20,00`) in coral red.

**Acceptance Scenarios**:

1. **Given** the user scrolls down the product grid, **When** scrolling past the sub-category grid, **Then** the top bar pins or retains a compact header showing "Shop", `[Clothing ✕]`, camera icon, and the filter gear icon (`⚙`) at the top right.
2. **Given** scrolled product cards, **When** a product has a discount, **Then** its price row displays the current sale price (e.g., `$16,00` or `$17,00`) in bold black text and the original price (e.g., `$20,00`) struck through in coral pink / red (`#FF5790` / `AppColors.error`).
3. **Given** full-price products, **When** rendered, **Then** they display only the single regular price (`$16,00`).
4. **Given** the scrolling experience, **When** scrolling fast through products, **Then** images render smoothly without frame drops (60 FPS) and maintain aspect ratio.

---

### User Story 3 - Multi-Faceted Product Filtering (Priority: P3)

As a shopper, I want to open a comprehensive Filter modal and refine products by sub-category, clothing vs shoe sizes, color swatches, price range, and sort order, so that I can find exactly the items that match my preferences.

**Why this priority**: Enables high-intent buyers to narrow down large catalogs quickly and effectively.

**Independent Test**: Tap the gear filter icon (`⚙`) on the Shop screen to open Screen 33 (Filter). Verify all filter sections: Categories (with multi-select checkmarks), Size (Clothes/Shoes toggle with size pills and custom active indicator), Color swatches, Price Range slider ($10 - $150), and Sort chips (Popular, Newest, Price High to Low). Verify that tapping "Clear" resets choices and tapping "Apply" returns to the Shop screen with filtered products.

**Acceptance Scenarios**:

1. **Given** the user is on the Shop screen, **When** the user taps the gear filter icon (`⚙`), **Then** Screen 33 (Filter) opens smoothly as a modal sheet or full-screen modal with an App Bar displaying "Filter" and a circular close button (`✕`) on the top right.
2. **Given** the Category section in Filter, **When** viewing the 9 category tiles, **Then** multiple categories can be selected simultaneously. Selected categories (e.g., Dresses, Pants, T-shirts) display a vibrant blue circular badge with a white checkmark at their top-right corner.
3. **Given** the Size section, **When** viewing the header, **Then** a segmented pill toggle displays `[ Clothes | Shoes ]`. Selecting "Clothes" displays apparel sizes (`XS`, `S`, `M`, `L`, `XL`, `2XL`) in a light blue pill strip.
4. **Given** the size pill strip, **When** a size is selected (e.g., `M`), **Then** it is highlighted with a circular white badge with vibrant blue border and indicator notches/triangles, wrapping the size letter in bold.
5. **Given** the Color section, **When** viewing color swatches, **Then** a horizontal list of circular swatches is displayed (White, Charcoal/Black, Royal Blue, Bright Red, Teal, Mustard Yellow, Purple). The active swatch (White) displays a blue outline ring and a blue circular checkmark badge.
6. **Given** the Price Range section, **When** dragging the dual thumbs on the RangeSlider, **Then** the header price label dynamically updates between `$10` and `$150` (or the selected bounds).
7. **Given** the Sort section, **When** viewing sort options, **Then** horizontal chips for `Popular`, `Newest`, and `Price Hight to Low` are shown. Tapping an option selects it exclusively; `Popular` shows a blue circular checkmark badge when active.
8. **Given** the bottom action buttons, **When** the user taps `Clear`, **Then** all active filter selections (categories, size, color, price range, sort) reset to default values without closing the modal.
9. **Given** the bottom action buttons, **When** the user taps `Apply`, **Then** the active filter parameters are saved, the modal closes, and the Shop screen reloads with the filtered product set.
10. **Given** the Filter screen, **When** the user taps the top-right `✕` button, **Then** the modal is dismissed without applying changes, preserving the previous filter state.

---

### Edge Cases

- **Empty State After Filter**: When a user applies filter combinations that yield zero products, display a friendly empty state ("No products match your filter criteria") with a "Reset Filters" action button.
- **Filter Modal Dismissal**: Tapping the backdrop or the `✕` close button discards pending filter selections and retains the previously applied Shop state.
- **Clear Button Action**: Tapping "Clear" only resets the in-modal selection state and does not prematurely alter the Shop screen until "Apply" is tapped.
- **Price Range Bounds**: Ensure min price cannot exceed max price on the dual RangeSlider, and display clean integer prices (e.g., `$10 - $150`).
- **Responsive Layout & Text Scaling**: Ensure the 2-row category grid (5 items on top row, 4 on bottom row) scales proportionally on smaller devices (`375.w`) without horizontal overflow or text clipping.
- **Shimmer Loading**: Present clean shimmer loading placeholders during initial loading or filter refresh.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide the Shop screen mounted within the application's bottom navigation shell under the Catalog/Shop branch (`/catalog`).
- **FR-002**: System MUST render an App Bar containing the screen title "Shop", an active filter pill `[Clothing ✕]` with dismiss tap handler, a camera action button, and a filter gear button (`⚙`).
- **FR-003**: System MUST display a 2-row sub-category grid containing 9 apparel categories: Dresses, Pants, Skirts, Tunics, Jackets, Hoodies, Shirts, Polo, T-shirts.
- **FR-004**: Each sub-category item MUST display a rounded light-grey tile container (`16.r`), high-fidelity product graphic/illustration, and label text centered underneath.
- **FR-005**: Tapping any sub-category tile on the Shop screen MUST filter the product grid to that sub-category.
- **FR-006**: System MUST render a section header row with "All Items" title on the left and a filter gear icon (`⚙`) on the right.
- **FR-007**: System MUST render a responsive 2-column product grid featuring product photo, title ("Lorem ipsum dolor sit amet consectetur"), and price in Raleway font.
- **FR-008**: System MUST support discounted items displaying bold current price (e.g., `$16,00`) and strike-through original price (e.g., `$20,00`) in coral red/pink (`#FF5790` / `AppColors.error`), with optional discount badge support.
- **FR-009**: System MUST support sticky or persistent header behavior on scrolling so that title and filter shortcuts remain accessible.
- **FR-010**: System MUST open Screen 33 (Filter) upon tapping any filter gear icon (`⚙`).
- **FR-011**: System MUST render the Filter screen with "Filter" title and a circular dismiss button (`✕`) on the top right.
- **FR-012**: Filter screen MUST render the 2-row category grid with multi-selection support, displaying a blue circular badge with white checkmark on selected items.
- **FR-013**: Filter screen MUST provide a Size section with `[ Clothes | Shoes ]` segmented pill toggle and horizontal size pills (`XS`, `S`, `M`, `L`, `XL`, `2XL`).
- **FR-014**: Filter screen MUST style the active size pill with a circular white container, primary blue border (`#004BFE`), and vertical indicator notches.
- **FR-015**: Filter screen MUST provide a Color section with selectable circular swatches (White, Charcoal, Blue, Red, Teal, Yellow, Purple) showing active ring and checkmark badge on selected swatch.
- **FR-016**: Filter screen MUST provide a Price Range section with live text indicator (`$10 - $150`) and interactive dual-thumb `RangeSlider`.
- **FR-017**: Filter screen MUST provide single-select Sort chips (`Popular`, `Newest`, `Price Hight to Low`) with a checkmark badge on the active chip.
- **FR-018**: Filter screen MUST provide a `Clear` button that resets all selections to default values.
- **FR-019**: Filter screen MUST provide an `Apply` button that applies selected filters, closes the modal, and reloads the Shop product grid.
- **FR-020**: System MUST display shimmer loading cards during asynchronous data fetching.
- **FR-021**: System MUST supply rich, realistic mock data for all products, categories, and initial filter states.

---

### Key Entities *(include if feature involves data)*

- **ShopProduct**: Represents a catalog product. Attributes:
  - `id` (String): Unique product identifier.
  - `title` (String): Product display name ("Lorem ipsum dolor sit amet consectetur").
  - `imageUrl` (String): Image asset or network URL.
  - `price` (double): Current selling price (e.g., 16.0).
  - `originalPrice` (double?): Strikethrough comparison price if discounted (e.g., 20.0).
  - `isDiscounted` (bool): Whether the item is on sale.
  - `category` (String): Main category (e.g., "Clothing").
  - `subCategory` (String): Sub-category (e.g., "Dresses", "T-shirts").
  - `sizes` (List<String>): Available sizes (e.g., `["S", "M", "L"]`).
  - `colors` (List<Color>): Available color options.
  - `isPopular` (bool): Popularity flag for sorting.
  - `createdAt` (DateTime): Creation timestamp for newest sorting.

- **ShopSubCategory**: Represents an apparel sub-category item. Attributes:
  - `id` (String): Unique category identifier.
  - `name` (String): Sub-category name (e.g., "Dresses", "Pants", "T-shirts").
  - `assetPath` (String): Path to the category icon/illustration asset.
  - `isSelected` (bool): Selection status in Filter screen.

- **FilterCriteria**: Represents active filtering criteria. Attributes:
  - `selectedSubCategories` (List<String>): Multi-select sub-category names.
  - `sizeType` (String): "Clothes" or "Shoes".
  - `selectedSize` (String?): Active size (e.g., "M").
  - `selectedColor` (Color?): Active color swatch.
  - `priceRange` (RangeValues): Min and max price bounds (default 10.0 to 150.0).
  - `sortOption` (ShopSortOption): `popular`, `newest`, `priceHighToLow`.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% visual fidelity matching Figma screens 25, 26, and 33 across colors, typography, paddings, and component hierarchy.
- **SC-002**: Shop screen and Filter modal open and render with zero UI overflow errors across standard screen sizes (`375x812`, `390x844`, `412x915`).
- **SC-003**: Tapping sub-category tiles or applying filter criteria updates the product grid instantaneously (<16ms in-memory response).
- **SC-004**: Product grid and filter modal scroll smoothly at 60 FPS without frame jitter.
- **SC-005**: All UI elements strictly utilize design tokens (`AppColors`, `AppTypography`, `AppSpacing`) and `flutter_screenutil` responsive extensions.
- **SC-006**: Code passes `flutter analyze` with 0 errors or warnings.

---

## Assumptions

- **Phase 1 Scope**: Purely UI-driven experience backed by local mock data sources with realistic latency simulation.
- **Navigation Integration**: Mounted in the main `StatefulShellRoute` under `RouteNames.kCatalogPage` (`/catalog`), with the Filter screen presented as a modal bottom sheet or full-screen dialog route.
- **Architecture**: Implemented using Feature-First Clean Architecture under `lib/features/shop/` (or replacing `lib/features/catalog/`), leveraging Cubit state management, Equatable, and GetIt DI.
- **Assets**: Category illustrations and product images leverage existing assets or curated high-quality demo assets in `assets/`.
