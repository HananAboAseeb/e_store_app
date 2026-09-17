# Feature Specification: Search (Screens 28, 29, 30, 31, 32)

**Feature Branch**: `feature/search`

**Created**: 2026-09-16

**Status**: Draft

**Input**: User specification and Figma design reference screenshots for Screens 28 (Search Main), 29 (Search Results - Text), 30 (Image Search - Capture), 31 (Image Recognized - Selection Frame & Retry), and 32 (Image Search Results - Modal Sheet). Provides comprehensive text-based search with history chips, recommendations, and discover carousel, full-featured search results grid with pricing discounts and filter modal access, and visual/image-based search flow with camera capture simulation, bounding frame object recognition, and bottom sheet results.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Text Search, History & Recommendations (Screens 28, 29) (Priority: P1)

As a shopper, I want to initiate searches via query input or selectable search chips (recent history and curated recommendations), and be able to clear my previous search history, so that I can quickly discover products matching my intent.

**Why this priority**: Core entry point for product discovery. Enables fast keyword search, quick access to past queries, and curated recommendation exploration.

**Independent Test**: Navigate to the Search screen (`/search`). Verify the screen displays the "Search" title, rounded light grey search bar with camera icon and close cross (`✕`), the "Search History" section with 5 chips (`Socks`, `Red Dress`, `Sunglasses`, `Mustard Pants`, `80's Skirt`) and a red trash icon, the "Recommendations" section with 5 chips (`Skirt`, `Accessories`, `Black T-Shirt`, `Jeans`, `White Shoes`), and the "Discover" section. Tap any history or recommendation chip to verify immediate navigation to Search Results (`/search/results?q=...`). Tap the trash icon and verify history chips are cleared.

**Acceptance Scenarios**:

1. **Given** the user navigates to the main Search screen (`/search`), **When** the screen finishes loading, **Then** the header displays "Search" in bold primary typography, a rounded light grey search field (`#F5F5F5`) with a camera icon on the right, and a dismiss button (`✕`) adjacent to the field.
2. **Given** the Search History section, **When** rendered, **Then** a header "Search History" is displayed with a red trash icon (`#FF3B30`) on the right, followed by 5 rounded grey chips: `Socks`, `Red Dress`, `Sunglasses`, `Mustard Pants`, and `80's Skirt`.
3. **Given** the Recommendations section, **When** rendered, **Then** a header "Recommendations" is displayed followed by 5 rounded grey chips: `Skirt`, `Accessories`, `Black T-Shirt`, `Jeans`, and `White Shoes`.
4. **Given** the search input field, **When** the user types a query (e.g., "Socks") and presses submit/enter, **Then** the app navigates to `/search/results?q=Socks`.
5. **Given** any search history or recommendation chip, **When** the user taps the chip, **Then** the app navigates to `/search/results` with the selected chip label as the search query.
6. **Given** the Search History section with chips present, **When** the user taps the red trash icon, **Then** the search history items are cleared from state and the history section cleanly collapses or shows an empty state.
7. **Given** the search header, **When** the user taps the camera icon inside the search input, **Then** the app navigates to the Image Search screen (`/search/image`).

---

### User Story 2 - Search Results Grid, Discount Pricing & Filter Access (Screen 29) (Priority: P2)

As a shopper, I want to view search results in a responsive 2-column product grid with clear regular and discounted sale pricing, edit or clear the current query, and open the filter modal, so that I can evaluate and narrow down matched products.

**Why this priority**: Users need to see search results presented clearly, identify discounts at a glance, refine their query, and access filter tools.

**Independent Test**: Navigate to Search Results with query "Socks" (`/search/results?q=Socks`). Verify the header displays "Search", the search field populated with "Socks" and an inline clear button (`✕`), and a filter gear icon (`⚙`) on the right. Verify products appear in a 2-column grid displaying product images, titles ("Lorem ipsum dolor sit amet consectetur"), and price points ($16,00, $17,00, or discounted $16,00 with strikethrough original $20,00 in coral red `#FF5790`). Tapping the gear icon opens the filter modal.

**Acceptance Scenarios**:

1. **Given** the user navigates to the Search Results screen with a query, **When** results load, **Then** the top bar displays "Search", the search input containing the active query string with an inline `✕` clear icon, and a gear icon (`⚙`) on the right.
2. **Given** the Search Results grid, **When** rendered, **Then** matching products are arranged in a 2-column grid reusing the canonical `ShopProductCard` layout.
3. **Given** a discounted product in results, **When** displayed, **Then** it presents the current price in bold text alongside a strikethrough original price (e.g., `$20,00`) styled in coral red (`#FF5790`).
4. **Given** the search input on the results screen, **When** the user taps the inline `✕` icon, **Then** the query text is cleared, allowing instant re-entry.
5. **Given** the Search Results header, **When** the user taps the gear icon (`⚙`), **Then** the filter modal/bottom sheet opens (reusing the filter interface from `feature/shop`).
6. **Given** any product card in the results grid, **When** tapped, **Then** the app navigates to the Product Details screen for that item.

---

### User Story 3 - Visual / Image Search Capture & Object Recognition (Screens 30, 31) (Priority: P3)

As a shopper, I want to use my device camera or photo library to capture or pick an image of a garment or accessory, and have the system visually recognize and frame the item, so that I can search visually without typing keywords.

**Why this priority**: Visual search provides a modern, intuitive way to search for fashion and merchandise using real-world photos or saved inspiration screenshots.

**Independent Test**: Navigate to Image Search (`/search/image`). Verify the full-screen viewfinder displays the target product image on a backdrop with three circular bottom buttons: Gallery (grey circle, left), Camera (Primary 400 blue `#004BFE`, center), and More (grey circle with `...`, right). Tap the center Camera button; verify transition to Screen 31 displaying the black rounded selection frame enclosing the recognized product and a white "Retry" pill button at the bottom. Tap "Retry" to return to capture mode.

**Acceptance Scenarios**:

1. **Given** the user navigates to Image Search (`/search/image`), **When** loaded, **Then** the screen renders a full-screen image capture viewport with a top back/dismiss button and three circular control buttons positioned horizontally at the bottom.
2. **Given** the bottom control bar, **When** viewed, **Then** the left control is a circular grey button with a gallery/photo icon, the center control is a prominent Primary 400 blue circular button (`#004BFE`) with a camera icon, and the right control is a circular grey button with an ellipsis icon (`...`).
3. **Given** the capture screen, **When** the user taps the center Camera button, **Then** the system captures the image and transitions to the Image Recognized view (Screen 31).
4. **Given** the capture screen, **When** the user taps the Gallery icon button, **Then** the system triggers the photo selection flow and proceeds to Image Recognized view.
5. **Given** the Image Recognized view (Screen 31), **When** displayed, **Then** a prominent black rounded-rectangle selection frame is drawn over the recognized product region, and a white pill-shaped "Retry" button is centered at the bottom.
6. **Given** the Image Recognized view, **When** the user taps "Retry", **Then** the selection frame is dismissed and the user returns to capture mode (Screen 30).
7. **Given** the recognized image state, **When** recognition completes (or upon user confirmation), **Then** the system automatically presents the Image Search Results modal (Screen 32).

---

### User Story 4 - Visually Similar Product Results Sheet & Discover Carousel (Screens 32, 28) (Priority: P4)

As a shopper, I want to see visually similar products in a slide-up modal bottom sheet after image recognition, complete with detected category confirmation, and explore trending items on the Discover carousel, so that I can browse relevant matching apparel.

**Why this priority**: Completes the visual search loop with actionable product matches and complements main search with serendipitous discovery.

**Independent Test**: On Screen 31, trigger recognition to open the modal bottom sheet (Screen 32). Verify the bottom sheet overlays the dimmed/blurred background, has rounded top corners (`24.r`), displays the header "Image Search" with a circular `✕` button, shows a blue detected category chip (`Shoes`) with the prompt "Is this what you meant?", and renders a 2-column grid of visually matching product cards. Tap `✕` to dismiss back to the capture screen. Verify on Screen 28 that the Discover section renders a horizontal carousel of product cards.

**Acceptance Scenarios**:

1. **Given** image recognition completes, **When** the Image Search Results modal (Screen 32) opens, **Then** it appears as a modal bottom sheet with rounded top corners (`24.r`) over the dimmed background.
2. **Given** the Image Search Results sheet, **When** observing the header, **Then** it displays "Image Search" in bold typography and a circular dismiss button (`✕`) at the top right.
3. **Given** the sheet header area, **When** viewed, **Then** a category pill (e.g., `Shoes`) is rendered in solid Primary 400 blue (`#004BFE`) with white text, adjacent to blue text asking "Is this what you meant?".
4. **Given** the modal results area, **When** rendered, **Then** a 2-column grid displays visually matching product cards with imagery, titles, and formatted prices.
5. **Given** the results modal, **When** the user taps the circular `✕` button or swipes down, **Then** the bottom sheet dismisses and returns to the capture screen.
6. **Given** the main Search screen (Screen 28), **When** scrolling to the "Discover" section, **Then** a horizontal scrolling carousel presents curated discover product cards with image, title, and price (`$17,00`).
7. **Given** any product card in the Image Search Results modal or Discover carousel, **When** tapped, **Then** the app navigates to the Product Details screen for that product.

---

### Edge Cases

- **No Search Results Found**: When a text search query or filter yields zero matching products, display a friendly empty state ("No results found for '<query>'") with a suggestion to try different keywords or reset filters.
- **Empty Search History**: When the user clears history via the red trash icon or when no prior searches exist, the "Search History" section should cleanly hide or show a subtle placeholder ("No recent searches").
- **Long Query Strings & Chip Text**: Chip labels (e.g., `Mustard Pants`, `80's Skirt`) and search field text must handle dynamic scaling without line breakage or overlapping layout artifacts across standard screen widths down to `375.w`.
- **Rapid Navigation / Multi-Tap Protection**: Consecutive taps on search chips, filter gear, or camera capture buttons must be debounced to prevent duplicate route pushes or conflicting state emissions.
- **Camera / Gallery Permission Handling**: In Phase 1 mock mode, graceful fallback ensures mock captures and photo selections work reliably without runtime hardware crashes.
- **Dismissal & Back Stack Flow**: Dismissing the modal bottom sheet returns smoothly to Screen 30; tapping back on Screen 30 returns cleanly to Screen 28 without orphaned navigation state.
- **Loading & Skeleton Shimmer**: Shimmer placeholder layouts must be displayed during search data loading, query search execution, and image similarity matching.
- **Persistent Bottom Nav Shell**: Screen 28 (Main Search) maintains persistent bottom navigation shell context with the active Home tab highlighted.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide the main Search screen mounted at route `/search`, accessible via bottom nav or home search entry points.
- **FR-002**: System MUST render a search header on Screen 28 with title "Search", a rounded light grey search bar (`#F5F5F5`), an integrated camera icon button inside the field, and a trailing dismiss button (`✕`).
- **FR-003**: System MUST display a "Search History" section on Screen 28 containing a section title, a red trash icon (`#FF3B30`), and 5 rounded search query chips (`Socks`, `Red Dress`, `Sunglasses`, `Mustard Pants`, `80's Skirt`).
- **FR-004**: System MUST allow clearing all search history chips when the red trash icon is tapped.
- **FR-005**: System MUST display a "Recommendations" section on Screen 28 containing a section title and 5 rounded recommendation chips (`Skirt`, `Accessories`, `Black T-Shirt`, `Jeans`, `White Shoes`).
- **FR-006**: Tapping any history chip or recommendation chip MUST immediately trigger navigation to the Search Results screen (`/search/results?q=<query>`).
- **FR-007**: Submitting a typed query in the search input field MUST navigate to `/search/results?q=<query>`.
- **FR-008**: System MUST display a "Discover" section on Screen 28 featuring a horizontal scrolling carousel of product cards with photos, titles, and pricing.
- **FR-009**: Tapping the camera icon inside the search input MUST navigate to the Image Search screen (`/search/image`).
- **FR-010**: System MUST render the Search Results screen mounted at route `/search/results` with query parameter `q`.
- **FR-011**: Search Results header MUST display "Search", a search input field reflecting the active query with an inline `✕` clear button, and a filter gear icon (`⚙`) on the right.
- **FR-012**: Tapping the inline `✕` clear button in the results search field MUST clear the active query string.
- **FR-013**: Tapping the filter gear icon (`⚙`) MUST open the filter modal (reusing the filter criteria and bottom sheet from `feature/shop`).
- **FR-014**: Search Results screen MUST render matching products in a responsive 2-column grid reusing `ShopProductCard`.
- **FR-015**: Product cards in results MUST support both standard pricing and discounted pricing with current price and strikethrough original price in coral red (`#FF5790`).
- **FR-016**: System MUST render the Image Search screen mounted at route `/search/image` (Screen 30).
- **FR-017**: Image Search screen MUST display a full-screen image capture viewport with top dismiss/back control and a bottom control bar containing 3 circular buttons: Gallery picker (left), Camera capture (Primary 400 `#004BFE`, center), and More options (right).
- **FR-018**: Tapping the center Camera button MUST trigger image capture and transition to the Image Recognized state (Screen 31).
- **FR-019**: Tapping the Gallery button MUST trigger photo library selection and transition to the Image Recognized state.
- **FR-020**: System MUST render the Image Recognized state (Screen 31) displaying a black rounded selection frame overlay bounding the detected product region.
- **FR-021**: Image Recognized view MUST display a white pill-shaped "Retry" button at the bottom that returns the user to capture mode (Screen 30).
- **FR-022**: System MUST present the Image Search Results (Screen 32) as a modal bottom sheet with rounded top corners (`24.r`).
- **FR-023**: Image Search Results bottom sheet MUST render a header with title "Image Search" and a circular dismiss button (`✕`) at the top right.
- **FR-024**: Image Search Results sheet MUST display a detected category badge (e.g., `Shoes` in Primary 400 blue `#004BFE` with white text) accompanied by "Is this what you meant?" prompt text.
- **FR-025**: Image Search Results sheet MUST render visually similar products in a 2-column grid with regular and discount pricing.
- **FR-026**: Tapping the circular `✕` button or swiping down on the bottom sheet MUST dismiss the modal and restore the capture viewport.
- **FR-027**: Tapping any product card across Search Results, Discover carousel, or Image Search Results modal MUST navigate to the Product Details screen for that product.
- **FR-028**: System MUST display shimmer loading placeholders during data fetching for main search, text results, and image search matching.
- **FR-029**: All layout dimensions, paddings, border radii, and font sizes MUST use `flutter_screenutil` extensions (`.w`, `.h`, `.r`, `.sp`).
- **FR-030**: All colors and typography MUST strictly adhere to design tokens (`AppColors`, `AppSpacing`, `AppTypography`) with zero hardcoded values.
- **FR-031**: State management MUST be implemented using `flutter_bloc` (Cubit) with immutable `Equatable` states.
- **FR-032**: All data calls MUST use Clean Architecture with domain use cases returning `Either<Failure, T>` via `dartz`, and repository implementations utilizing `safeCall`.

---

### Key Entities *(include if feature involves data)*

- **SearchHistoryEntity**: Represents an individual past search query record.
  - `id` (String): Unique identifier.
  - `query` (String): Search keyword string (e.g., `"Socks"`, `"Red Dress"`, `"Sunglasses"`).
  - `timestamp` (DateTime): Timestamp of when query was executed.

- **RecommendationEntity**: Represents a curated suggested search query.
  - `id` (String): Unique identifier.
  - `label` (String): Suggested keyword label (e.g., `"Skirt"`, `"Accessories"`, `"Black T-Shirt"`).

- **SearchDataEntity**: Aggregated data entity for the main Search screen.
  - `history` (List<SearchHistoryEntity>): List of recent search queries.
  - `recommendations` (List<RecommendationEntity>): Curated search recommendation suggestions.
  - `discoverProducts` (List<ShopProductEntity>): Curated products for the horizontal Discover carousel.

- **ImageSearchResultEntity**: Represents the outcome of visual image recognition.
  - `id` (String): Unique search result identifier.
  - `imagePath` (String): Reference path to the captured or selected image.
  - `detectedCategory` (String): Name of the detected merchandise category (e.g., `"Shoes"`, `"Dresses"`).
  - `confidence` (double): Confidence score of recognition.
  - `boundingBox` (Map<String, double>?): Coordinates/rect for the selection frame overlay.
  - `products` (List<ShopProductEntity>): Visually similar matched products.

- **ShopProductEntity** *(reused)*: Domain product entity representing catalog items with id, name, imageUrl, price, originalPrice, isDiscounted, and category.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% pixel-perfect visual match with Figma design references across Screens 28, 29, 30, 31, and 32 (colors, typography, border radii `8.r`, `12.r`, `16.r`, `20.r`, `24.r`, and spacing tokens).
- **SC-002**: Main Search screen loads initial history, recommendations, and discover items in under 300ms.
- **SC-003**: Text search query execution and results rendering completes in under 300ms with smooth 2-column grid rendering.
- **SC-004**: Image search flow (capture → recognition bounding frame → bottom sheet results) transitions fluidly at 60 FPS without UI jank.
- **SC-005**: All interactive elements (chips, buttons, input fields, cards, modal dismissals) meet minimum accessibility touch targets (44x44 dp) and deliver immediate visual feedback.
- **SC-006**: Zero UI layout overflow errors across standard device viewports (`375x812`, `390x844`, `412x915`).
- **SC-007**: Strict adherence to the 10 Permanent Project Rules and Constitution v1.1.0 with zero new assets generated, complete shared component reuse, and `flutter analyze` passing with 0 errors and 0 warnings.

---

## Assumptions

- **Phase 1 Mock Data**: The feature is entirely backed by realistic local mock data sources (`SearchMockDataSource`), simulating query matching, search history mutation, recommendations, and visual image recognition without live cloud or device hardware dependencies.
- **Camera & Gallery Simulation**: For Phase 1, camera capture and gallery picking are simulated using pre-configured mock image assets located in `assets/images/` and `assets/design_references/` without requiring external hardware camera plugins.
- **Filter Modal Integration**: The filter gear icon (`⚙`) reuses the existing filter modal and criteria mechanisms established in `feature/shop` (`Screen 33`).
- **Shared Component Reuse**: Existing reusable UI components, including `ShopProductCard`, `DiscountBadge`, and common buttons from `lib/shared/widgets/` or `lib/features/shop/`, will be reused without duplicating code.
- **Routing & Shell Navigation**: Route `/search` is mounted within the bottom navigation shell to preserve the active Home navigation tab, while `/search/image` and results can be pushed cleanly onto the navigation stack.

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
