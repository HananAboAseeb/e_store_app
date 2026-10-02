# Feature Specification: Wishlist & Recently Viewed

**Feature Directory**: `specs/011-wishlist`

**Feature Branch**: `feat/wishlist-recently-viewed`

**Created**: 2026-09-29

**Status**: Draft

**Input**: User description: "Wishlist feature covering Screen 38 (Wishlist with items + Empty state), Screen 39 (Recently Viewed with Today/Yesterday tabs), Screen 40 (Recently Viewed Date Picker open), Screen 41 (Recently Viewed Date chosen - April 18)"

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Viewing Wishlist Items & Managing Saved Products (Priority: P1)

As a shopper, I want to view all the products I have saved to my wishlist in a clear vertical list, with the ability to delete items I no longer want or move items into my shopping cart, so that I can easily keep track of items I plan to purchase.

**Why this priority**: The primary value of a wishlist is saving and reviewing desired items with direct conversion actions (Add to Cart). Delivering this story alone provides a fully functioning wishlist MVP.

**Independent Test**: Can be tested independently by launching the Wishlist screen with mock items, verifying that the list displays product image, title, price, attributes, and ensuring that tapping the trash icon removes an item while tapping the add-to-cart icon triggers addition to the cart.

**Acceptance Scenarios**:

1. **Given** a user with saved products in their wishlist, **When** they navigate to the Wishlist screen (Tab index 1), **Then** they see a vertical list of wishlist items with product image, 2-line title, bold price, meta pills (`Pink`, `M`), a blue add-to-cart button, and a delete icon on the bottom-left of each product image.
2. **Given** a wishlist item, **When** the user taps the delete (trash) icon, **Then** the item is removed from the wishlist with an immediate UI update.
3. **Given** a wishlist item, **When** the user taps the blue add-to-cart button, **Then** the item is added to the cart and a confirmation is provided.
4. **Given** any wishlist item card, **When** the user taps the product details, **Then** they navigate to `/product/:id`.
5. **Given** the Wishlist screen, **When** the user taps the `✕` close button in the top-right header, **Then** the screen is dismissed (navigates back).

---

### User Story 2 - Empty Wishlist State & Product Discovery (Priority: P2)

As a shopper with an empty wishlist, I want to see a clear empty state notification and a curated carousel of "Most Popular" products, so that I can discover new items and add them to my wishlist or cart.

**Why this priority**: When a user has not saved any items (or deletes all items), providing product recommendations prevents a dead-end and drives engagement.

**Independent Test**: Can be tested independently by opening the Wishlist screen when no items are saved, verifying the circular heart empty badge, the "Your Wishlist is Empty" text, and the "Most Popular" horizontal carousel with working navigation.

**Acceptance Scenarios**:

1. **Given** a user with 0 items in their wishlist (or who removes the last item), **When** they view the Wishlist screen, **Then** they see a circular grey badge with a blue heart icon and the text "Your Wishlist is Empty".
2. **Given** the empty wishlist state, **When** the user scrolls down, **Then** they see the "Most Popular" section with a "See All →" header button and a horizontal carousel of popular products.
3. **Given** the "Most Popular" section, **When** the user taps "See All →", **Then** the app navigates to `/catalog` (Shop screen).
4. **Given** any popular product card in the carousel, **When** the user taps the card, **Then** the app navigates to `/product/:id`.

---

### User Story 3 - Recently Viewed Products & Tab Filtering (Priority: P3)

As a shopper, I want to browse products I recently viewed organized by date tabs (Today and Yesterday) in a 2-column grid, so that I can quickly re-find items I looked at recently.

**Why this priority**: Recently viewed tracking helps users resume shopping sessions without searching again.

**Independent Test**: Can be tested independently by navigating to `/wishlist/recently-viewed`, verifying that "Today" tab is initially selected with a blue checkmark, switching to "Yesterday", and confirming that the 2-column product grid re-filters accordingly.

**Acceptance Scenarios**:

1. **Given** the user navigates to Recently Viewed, **When** the screen opens, **Then** they see the title "Recently viewed", a circular `✕` close button, filter tabs for "Today" (selected with blue background and checkmark) and "Yesterday", a circular blue chevron-down button, and a 2-column grid of product cards.
2. **Given** the Recently Viewed screen, **When** the user taps the "Yesterday" tab, **Then** the "Yesterday" tab becomes active and the 2-column grid displays products viewed yesterday.
3. **Given** any product card in the 2-column grid, **When** the user taps the card, **Then** the app navigates to `/product/:id`.
4. **Given** the Recently Viewed screen, **When** the user taps the `✕` button, **Then** the screen is dismissed.

---

### User Story 4 - Date Picker Expansion & Filtering by Chosen Date (Priority: P4)

As a shopper, I want to expand a calendar date picker from the Recently Viewed screen, choose a specific past date (e.g., April 18), and filter my browsing history by that specific date, so that I can locate products viewed on a particular day.

**Why this priority**: Enhances the standard Today/Yesterday filter by enabling granular date exploration through a custom visual calendar.

**Independent Test**: Can be tested independently by tapping the chevron-down button to expand the calendar (Screen 40), selecting a day number (e.g., 18), confirming the calendar collapses and a new active tab "April, 18" appears with its filtered products (Screen 41).

**Acceptance Scenarios**:

1. **Given** the Recently Viewed screen, **When** the user taps the circular blue chevron-down button `∨`, **Then** the calendar date picker card expands below the header displaying month navigation (`< April >`), a 7-column day grid (01–31), and a bottom collapse button `^`.
2. **Given** the expanded calendar date picker, **When** the user taps a date (e.g., `18`), **Then** the day is highlighted, the calendar collapses, and a new tab "April, 18" (active with blue checkmark) is displayed in the filter tabs row.
3. **Given** the newly added date tab "April, 18", **When** it is active, **Then** the 2-column product grid displays products viewed on that specific date.
4. **Given** the expanded calendar, **When** the user taps `<` or `>`, **Then** the displayed month changes accordingly.
5. **Given** the expanded calendar, **When** the user taps the upward chevron button `^`, **Then** the calendar collapses without altering the active filter.

---

### Edge Cases

- **Empty Wishlist Transition**: Removing the last item in a populated wishlist must dynamically animate/transition to the Empty State (Screen 38-Empty) without requiring a pull-to-refresh or page reload.
- **Empty Date History**: If a selected date (e.g., April 18) has no recorded views, display a friendly message "No products viewed on this date" instead of a blank or broken layout.
- **Long Product Titles**: Titles exceeding two lines must truncate gracefully (`TextOverflow.ellipsis`, `maxLines: 2`) without causing layout overflow.
- **Duplicate Add to Cart**: Tapping "Add to Cart" multiple times rapidly must prevent duplicate concurrent requests through cubit state debouncing.
- **Calendar Boundary**: The calendar must not allow selecting future dates beyond today's current date.
- **Bottom Navigation State**: The Wishlist tab (index 1) in `CustomBottomNavBar` must remain active and highlighted in blue across both Wishlist and Recently Viewed screens.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide a Wishlist page accessible via the 2nd tab (index 1) of the bottom navigation bar (`/wishlist`).
- **FR-002**: Wishlist screen MUST display a top header with the title "Wishlist" and a circular `✕` dismiss button.
- **FR-003**: System MUST display saved products in a vertical scrollable list when the wishlist contains 1 or more items.
- **FR-004**: Each wishlist item MUST display: product image with rounded corners, delete button at bottom-left of the image, 2-line title, bold price, variant meta pills (`Pink`, `M`), and a blue add-to-cart button.
- **FR-005**: Tapping the delete button on any item MUST remove that item from the wishlist immediately.
- **FR-006**: Tapping the add-to-cart button MUST trigger adding the product variant to the cart.
- **FR-007**: When the wishlist has 0 items, the system MUST display the Empty Wishlist view with a circular badge, heart icon, and "Your Wishlist is Empty" heading.
- **FR-008**: The Empty Wishlist view MUST display a "Most Popular" section with a "See All →" action and a horizontal carousel of popular products.
- **FR-009**: Tapping "See All →" MUST navigate to `/catalog`.
- **FR-010**: Tapping any product in the wishlist or popular carousel MUST navigate to `/product/:id`.
- **FR-011**: System MUST provide a Recently Viewed screen accessible via route `/wishlist/recently-viewed` or direct navigation.
- **FR-012**: Recently Viewed screen MUST display a top header with title "Recently viewed" and circular `✕` dismiss button.
- **FR-013**: Recently Viewed screen MUST provide a horizontal filter row containing preset tabs ("Today", "Yesterday") and a circular blue chevron button `∨` to open the date picker.
- **FR-014**: The active tab in Recently Viewed MUST be highlighted with a soft blue background (`AppColors.primarySoft`), primary text (`AppColors.primary`), and a circular checkmark icon `✓`.
- **FR-015**: Inactive tabs in Recently Viewed MUST display a neutral background (`AppColors.surfaceOption`) and dark text.
- **FR-016**: Products in Recently Viewed MUST be displayed in a 2-column grid utilizing the reusable `ShopProductCard` widget.
- **FR-017**: Tapping the chevron button `∨` MUST expand an inline calendar date picker card directly below the header.
- **FR-018**: The calendar date picker MUST include previous/next month navigation arrows, month name pill, 7-column day grid (01 to 31), day selection highlight, and an upward collapse button `^`.
- **FR-019**: Selecting a date in the calendar MUST collapse the calendar, create or activate a corresponding date tab (e.g., "April, 18"), and filter the 2-column grid to products viewed on that date.
- **FR-020**: Tapping the upward collapse button `^` in the calendar MUST close the calendar without changing the current filter.
- **FR-021**: Shimmer loading indicators MUST be displayed while wishlist or recently viewed data is loading.
- **FR-022**: User error states with a retry button MUST be displayed if loading fails.
- **FR-023**: Component reuse MUST be strictly enforced:
  - Re-use Cart's product row pattern for wishlist items.
  - Re-use `ShopProductCard` for the 2-column recently viewed grid.
  - Re-use `MostPopularSection` and `PopularProductCard` for the empty state recommendations.
  - Re-use `CustomBottomNavBar` with Tab index 1 selected.
- **FR-024**: Design token compliance (Rule #11) MUST be strictly enforced: all colors must use `AppColors`, spacing via `AppSpacing`, typography via `AppTypography`. No hardcoded colors or dimension literals.
- **FR-025**: All state management MUST use `flutter_bloc` (Cubit) with `Equatable` states, and all navigation MUST use `go_router`.

---

### Key Entities

- **`WishlistItemEntity`**: Represents a product saved to the wishlist.
  - Attributes: `id` (String), `productId` (String), `title` (String), `price` (double), `imageUrl` (String), `color` (String), `size` (String), `addedAt` (DateTime).
- **`RecentlyViewedItemEntity`**: Represents a product viewed by the user with timestamp.
  - Attributes: `id` (String), `product` (`ShopProductEntity`), `viewedAt` (DateTime).
- **`DateTabEntity`**: Represents a date filter tab in the Recently Viewed screen.
  - Attributes: `id` (String), `label` (String), `date` (DateTime?), `isActive` (bool).
- **`WishlistProductEntity`**: Reuses `ShopProductEntity` or `HomeProductEntity` for product recommendations in the empty state.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can view and browse their saved wishlist items within 500ms of opening the screen.
- **SC-002**: Removing an item from the wishlist updates the UI immediately (< 100ms) and smoothly transitions to the empty state if the last item is removed.
- **SC-003**: Adding a wishlist item to the shopping cart takes no more than 1 tap and provides instant visual confirmation.
- **SC-004**: Switching date tabs (Today, Yesterday, Custom Date) filters the 2-column product grid in under 200ms.
- **SC-005**: 100% of reusable components (`ShopProductCard`, `PopularProductCard`, `CustomBottomNavBar`) are shared across features without code duplication.
- **SC-006**: Codebase static analysis (`fvm flutter analyze`) reports 0 errors and all unit/widget tests pass with 100% green status.

---

## Assumptions

- The Wishlist screen is mounted in the application shell's 5-tab navigation at index 1 (`NavEnum.wishlist`).
- The circular `✕` button on Wishlist (Screen 38) and Recently Viewed (Screen 39) acts as a dismiss/pop action (or switches to the Home tab if popped at shell root).
- Mock data will provide 5 initial wishlist items and 8 recently viewed items partitioned across Today, Yesterday, and April 18.
- Cart additions from the wishlist will interface with the existing in-memory cart state / cubit.
- Phase 1 relies exclusively on local mock data sources without remote backend APIs.

---

## Permanent Project Rules Reference

All features MUST strictly comply with the Permanent Project Rules defined in the project Constitution (`.specify/memory/constitution.md`):
1. **Verification Timing**: Do NOT run `fvm flutter analyze` or `fvm flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PopularProductCard, MostPopularSection, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
11. **STRICT COLOR & TOKEN ENFORCEMENT**: All colors, spacing, and typography must reference tokens from `AppColors`, `AppSpacing`, and `AppTypography`. No hardcoded values are allowed. If a token is missing, add it to the tokens file first.
12. **FVM-ONLY CLI COMMANDS**: ALWAYS use `fvm flutter` (NOT bare `flutter`) for ALL Flutter CLI commands (`analyze`, `test`, `run`, `build`, `pub get`, etc.). The project uses FVM with Flutter 3.44.6. The global Flutter (3.24.5) has incompatible API differences. Using bare `flutter` causes type mismatch errors and reverts fixes.
