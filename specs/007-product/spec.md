# Feature Specification: Product (Screens 34, 35, 36, 37)

**Feature Branch**: `feature/product`

**Created**: 2026-09-17

**Status**: Draft

**Input**: User specification and Figma design reference screenshots for Screen 34 (Product Details Full), Screen 35 (Product Details with Flash Sale Banner + Countdown), Screen 36 (Product Details Compact/Initial View), and Screen 37 (All Reviews). Provides comprehensive product details view with interactive image gallery, breadcrumb navigation, wishlist and sharing controls, rating summaries, color variant and size selectors, specifications pills, delivery options, 5-star ratings breakdown, reviews preview with direct navigation to dedicated full reviews screen, carousel of most popular items, "You Might Like" 2-column recommendations grid, and a sticky bottom purchase bar. Includes real-time countdown timer integration for flash sale periods.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Product Overview, Image Gallery & Variant Selection (Screens 34, 36) (Priority: P1)

As a shopper, I want to view high-resolution imagery, breadcrumb navigation, ratings, color options, and size choices for a selected product, so that I can inspect details and configure my preferred item before adding it to my basket.

**Why this priority**: Fundamental shopping experience. Without visual inspection, variant selection (color/size), and core item identity, shoppers cannot evaluate or purchase a product.

**Independent Test**: Navigate to the product details page (`/product/caviar-jacket`). Verify the top image gallery displays multiple product images with active dot indicators below, the breadcrumb trail (`Shop > Jackets > Caviar`) with wishlist heart and share icons, product title "Caviar Leather Jacket", rating score `4.7` with comment count pill `2986 Comments >`, horizontal color variant thumbnails with blue selection indicator on the active choice, and expandable size selector pill (`M`). Select a different color or size and verify the UI state updates immediately.

**Acceptance Scenarios**:

1. **Given** the user navigates to `/product/:id`, **When** the page loads, **Then** the image gallery renders at the top with rounded corners (`20.r`), displaying the initial product photo with horizontal swipe pagination and dot indicators (active blue indicator `#004BFE`).
2. **Given** the breadcrumb section, **When** rendered, **Then** it shows `Shop > Jackets > Caviar` in secondary muted typography alongside a toggleable wishlist heart icon and a share icon on the far right.
3. **Given** the wishlist heart icon, **When** tapped by the user, **Then** the icon toggles between outlined and filled states reflecting the product's saved state.
4. **Given** the product title and rating row, **When** rendered, **Then** the title "Caviar Leather Jacket" appears in bold header typography, accompanied by a gold star icon (`#FFB800`), rating value `4.7`, and a pill button displaying `2986 Comments >`.
5. **Given** the Color selector section, **When** displayed, **Then** it renders a "Color" header and 3 thumbnail variant cards (rounded `12.r`) with colored circular badges (e.g., Red, Purple, Green); tapping an inactive color moves the blue selection border to that variant and updates the gallery images.
6. **Given** the Size selector section, **When** displayed, **Then** it renders a "Size" header and a selectable pill (defaulting to `M`); tapping the pill expands available size options (`XS`, `S`, `M`, `L`, `XL`, `2XL`) allowing the user to select their desired size.
7. **Given** the sticky bottom bar, **When** viewed on initial load or during scroll, **Then** it remains pinned to the bottom displaying the active price point (e.g., `$17,00`) and a Primary 400 blue "Add to Basket" action button.

---

### User Story 2 - Flash Sale Banner & Real-Time Countdown (Screen 35) (Priority: P2)

As a shopper viewing a product currently on flash promotion, I want to clearly see the active discount, original price, and a live countdown timer showing the remaining promotional window, so that I am motivated to take timely advantage of the limited-time discount.

**Why this priority**: Drives urgency and promotional engagement. Clearly communicates active savings and remaining sale duration directly above the core product information.

**Independent Test**: Navigate to a product marked with an active flash sale (`/product/caviar-jacket?sale=true`). Verify a bold red banner (`#FF3B30`) is positioned directly below the image gallery and above the breadcrumb. Verify the banner displays the discounted sale price (`$17,00`), strikethrough original price (`$24,00`), `-20%` discount pill, clock icon, and live countdown timer boxes (`HH:MM:SS`) ticking down every second.

**Acceptance Scenarios**:

1. **Given** a product with active flash sale status, **When** the page renders, **Then** a prominent red promotional banner (`#FF3B30`) appears inserted between the image gallery and the breadcrumbs.
2. **Given** the Flash Sale banner, **When** viewed, **Then** the left area displays the sale price `$17,00` in bold white text, strikethrough original price `$24,00` in semi-transparent white text, and a rounded pill indicating `-20%`.
3. **Given** the Flash Sale banner, **When** viewed, **Then** the right area displays a clock icon alongside countdown timer boxes displaying remaining hours, minutes, and seconds (`00 : 36 : 58`).
4. **Given** the countdown timer, **When** active, **Then** the seconds, minutes, and hours decrement synchronously every second without UI stutter.
5. **Given** the countdown timer reaches zero (`00:00:00`), **When** the promotion expires, **Then** the flash sale banner automatically collapses and prices revert to standard non-promotional values.
6. **Given** the sticky bottom bar during a flash sale, **When** rendered, **Then** the price column displays the discounted `$17,00` alongside strikethrough `$24,00`.

---

### User Story 3 - Product Specifications, Delivery Options & Ratings Breakdown (Screen 34) (Priority: P3)

As a shopper, I want to inspect technical specifications (materials, origin), shipping timelines with associated costs, and an aggregate breakdown of customer ratings, so that I can make an informed purchasing decision.

**Why this priority**: Essential informational depth that resolves customer doubts regarding fabric composition, shipping guarantees, sizing guidance, and peer sentiment.

**Independent Test**: Scroll down past the variant selectors on `/product/caviar-jacket`. Verify the Specifications section displays pills for Material (`Cotton: 95%`, `Nylon: 5%`), Origin (`EUROPE`), and a circular Size Guide arrow button (`→`). Verify the Delivery section displays two rows: Standard (`5 - 7 Days`, `$3,00`) and Express (`1 - 2 Days`, `$12,00`). Verify the Ratings section displays `4.7` with `3654 Scores` and 5 horizontal percentage breakdown bars.

**Acceptance Scenarios**:

1. **Given** the Specifications section, **When** rendered, **Then** it presents pills for fabric composition (`Cotton: 95%`, `Nylon: 5%`), country of origin (`EUROPE`), and a circular blue arrow button (`→`) linking to size guidance.
2. **Given** the Delivery section, **When** rendered, **Then** two distinct rounded cards present shipping options: "Standard" indicating `5 - 7 Days` and `$3,00`, and "Express" indicating `1 - 2 Days` and `$12,00`.
3. **Given** the Ratings breakdown section, **When** rendered, **Then** it prominently features the average score `4.7` alongside total score count `3654 Scores`, accompanied by 5 segmented rating bars showing distribution across 1 to 5 stars with percentage markers.
4. **Given** the Size Guide arrow button (`→`), **When** tapped, **Then** the user receives sizing reference feedback or opens sizing guidelines.

---

### User Story 4 - Dedicated All Reviews Screen & Social Feedback (Screen 37) (Priority: P4)

As a shopper, I want to read verified customer reviews with star ratings, feedback text, timestamps, and helpfulness reactions, and access a dedicated full-screen reviews view, so that I can evaluate genuine buyer feedback.

**Why this priority**: Social proof and customer feedback drive conversion. Buyers depend on in-depth reviews and community ratings to validate fit, quality, and satisfaction.

**Independent Test**: On the Product Details page, locate the Reviews preview showing 2 customer reviews and tap "View All 2986 Reviews". Verify navigation to the dedicated Reviews screen (`/product/:id/reviews`). Verify the top bar displays "Reviews" with a circular close button (`✕`) on the right. Verify a scrollable list of review cards displaying author avatar, author name "Veronica", 4/5 gold stars, review narrative, dislike count (`24 ↓`), like count (`24 ↑`), and relative timestamp (`2 Days Ago`). Tap `✕` to verify return to the product page. Tap like or dislike icons to verify counter toggle.

**Acceptance Scenarios**:

1. **Given** the Reviews preview on the product page, **When** rendered, **Then** it showcases 2 preview cards and a Primary 400 blue button labeled "View All 2986 Reviews".
2. **Given** the user taps "View All 2986 Reviews" or the comments pill in the rating row, **When** clicked, **Then** the application navigates to the dedicated Reviews screen (`/product/:id/reviews`).
3. **Given** the Reviews screen (`Screen 37`), **When** displayed, **Then** the top app bar features the title "Reviews" in bold typography and a circular dismiss button (`✕`) at the top right.
4. **Given** each review card on Screen 37, **When** rendered, **Then** it contains a circular avatar, author name (e.g., "Veronica"), star rating (gold stars `#FFB800`), descriptive text, and a bottom row displaying dislike reaction (`↓`), like reaction (`↑`), and relative date (e.g., `2 Days Ago`).
5. **Given** a review card, **When** the user taps the like (`↑`) or dislike (`↓`) icon, **Then** the corresponding counter updates interactively to reflect the user's vote.
6. **Given** the circular `✕` button on the Reviews screen, **When** tapped, **Then** the view dismisses and returns the user to the Product Details page.

---

### User Story 5 - Product Recommendations ("Most Popular" & "You Might Like") (Screen 34) (Priority: P5)

As a shopper browsing a product, I want to see a curated carousel of "Most Popular" trending items and a "You Might Like" 2-column grid of related products, so that I can continue exploring similar or matching apparel.

**Why this priority**: Increases product discovery, average order value, and continuous catalog browsing after reviewing a single item.

**Independent Test**: Scroll toward the bottom of `/product/caviar-jacket`. Verify the "Most Popular" section displays a "See All →" link and a horizontal carousel of product cards tagged with badges (`New`, `Sale`, `Hot`) and price `$17,80`. Verify the "You Might Like" section renders below with a star icon in its header and a 2-column responsive grid reusing canonical `ShopProductCard` elements. Tap any card to navigate to that product's details page.

**Acceptance Scenarios**:

1. **Given** the "Most Popular" section, **When** rendered, **Then** it features a header with "Most Popular" and an active "See All →" link leading to the shop catalog.
2. **Given** the "Most Popular" carousel, **When** scrolled horizontally, **Then** it displays product cards with imagery, title, pricing (`$17,80`), and promotional tags (`New`, `Sale`, `Hot`).
3. **Given** the "You Might Like" section, **When** rendered, **Then** it features a header labeled "You Might Like" prefixed with a star icon, followed by a 2-column grid of product items.
4. **Given** product cards in "You Might Like", **When** displayed, **Then** they reuse the canonical `ShopProductCard` layout with proper discount formatting.
5. **Given** any product card in either recommendation section, **When** tapped by the user, **Then** the app navigates to the Product Details screen for the selected product.

---

### Edge Cases

- **Promotion Expiration While On Screen**: If a user is actively viewing Screen 35 and the countdown timer reaches zero, the flash sale banner must smoothly transition/collapse out of view and product pricing must revert without screen reload or crash.
- **Single or Missing Product Images**: If a product has only 1 image, the horizontal carousel should display that image without showing dot pagination indicators; if an image fails to load, a graceful placeholder card must appear.
- **Out of Stock Variants**: Color or size variants that are unavailable must display visually distinct disabled/unavailable states and prevent selection.
- **Long Review Text & Author Names**: Review comments of arbitrary length must support expanding/collapsing ("...") without overflowing their container cards.
- **Empty Reviews List**: If a product has zero reviews, the preview section and Reviews screen must display a clean empty state ("No reviews yet. Be the first to review this product!").
- **Offline / Mock Latency Failures**: Failed product or review loads must display a standard error illustration with a "Try Again" retry action button.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST render a full Product Details page (`/product/:id`) displaying image gallery, breadcrumbs, title, rating summary, color variants, size options, specifications, shipping options, ratings breakdown, reviews preview, recommendations, and a sticky bottom purchase bar.
- **FR-002**: The Image Gallery MUST support horizontal swiping through multiple product photos with synchronous dot indicator updates (active blue `#004BFE`, inactive `#D1D1D6`).
- **FR-003**: The Breadcrumb trail MUST display the category path (e.g., `Shop > Jackets > Caviar`) and allow tapping the parent category (`Jackets`) to navigate to that catalog category.
- **FR-004**: Users MUST be able to toggle the wishlist heart icon on the product details header, reflecting immediate optimistic state updates.
- **FR-005**: System MUST provide a Color variant selector showing available colorway thumbnails; tapping a colorway MUST update the selected variant and switch gallery photos accordingly.
- **FR-006**: System MUST provide an expandable Size selector pill; tapping MUST display available sizing options (`XS`, `S`, `M`, `L`, `XL`, `2XL`) and update the selected size.
- **FR-007**: When a product has an active flash sale, system MUST display a prominent red promotional banner (`#FF3B30`) above the breadcrumb containing sale price, original strikethrough price, `-20%` badge, and a real-time countdown timer.
- **FR-008**: The countdown timer MUST decrement hours, minutes, and seconds every 1000 milliseconds via an active stream/timer; upon timer expiry, the banner MUST dismiss and regular pricing MUST apply.
- **FR-009**: System MUST render a Specifications section displaying material composition pills (e.g., `Cotton: 95%`, `Nylon: 5%`), origin badge (`EUROPE`), and a size guide button.
- **FR-010**: System MUST render a Delivery section presenting standard (`5 - 7 Days`, `$3,00`) and express (`1 - 2 Days`, `$12,00`) shipping options.
- **FR-011**: System MUST present an aggregate Ratings section with the numeric rating (e.g., `4.7`), score count (`3654 Scores`), and 5 horizontal distribution bars.
- **FR-012**: System MUST display a Reviews preview showing 2 recent reviews and a "View All [N] Reviews" action button.
- **FR-013**: Tapping "View All Reviews" or the comments count pill MUST navigate to the dedicated full-screen Reviews screen (`/product/:id/reviews`).
- **FR-014**: The Reviews screen MUST render a scrollable list of customer reviews containing avatar, author name, star rating, feedback text, vote buttons (like/dislike), and relative timestamp.
- **FR-015**: The Reviews screen MUST provide a circular `✕` button at the top right that pops the route and returns to the Product Details page.
- **FR-016**: Users MUST be able to toggle like and dislike reactions on individual review cards, updating vote tallies interactively.
- **FR-017**: System MUST render a horizontal scrolling "Most Popular" carousel displaying product cards with promotional tags (`New`, `Sale`, `Hot`) and a "See All →" action.
- **FR-018**: System MUST render a "You Might Like" 2-column grid reusing canonical `ShopProductCard` components from `feature/shop`.
- **FR-019**: Tapping any recommended product card MUST push navigation to that product's details route (`/product/:id`).
- **FR-020**: System MUST display a sticky Bottom Bar pinned at the bottom of the viewport featuring the active price and an "Add to Basket" primary button.
- **FR-021**: Tapping "Add to Basket" MUST trigger the add-to-cart action with selected color and size options, providing feedback to the user.
- **FR-022**: System MUST manage `product` state using two dedicated Cubits within the same feature: `ProductDetailsCubit` (for product page and timer) and `ReviewsCubit` (for reviews listing and reactions).
- **FR-023**: All asynchronous loading states MUST display shimmer placeholders conforming to project design tokens.
- **FR-024**: All dimensions MUST be defined using `flutter_screenutil` responsive values (`.w`, `.h`, `.r`, `.sp`).
- **FR-025**: All colors MUST strictly utilize tokens defined in `lib/core/theme/app_colors.dart` without hardcoded hex constants.

---

### Key Entities

- **ProductDetailsEntity**: Represents complete product specifications including ID, title, category breadcrumb, image URLs, rating value, total reviews count, available color variants, available size options, material specifications, shipping options, ratings breakdown, reviews preview, flash sale status, flash sale expiration timestamp, base price, sale price, and discount percentage.
- **ProductVariantEntity**: Represents a specific color or style variant with unique ID, display name, color hex code, and corresponding gallery image URLs.
- **SpecificationEntity**: Represents technical product attributes such as material percentages, country of origin, and sizing guide references.
- **DeliveryOptionEntity**: Represents a shipping tier with ID, title (e.g., "Standard", "Express"), expected transit timeframe (e.g., "5 - 7 Days"), and formatted shipping fee.
- **RatingBreakdownEntity**: Represents star rating distributions (1 through 5 stars), count of ratings, and corresponding percentage share.
- **ReviewEntity**: Represents an individual verified customer review with ID, author name, avatar image URL, star score (1–5), feedback description text, like count, dislike count, user vote status, and creation date.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can inspect product imagery, switch color variants, and choose sizing options in under 5 seconds from initial page load.
- **SC-002**: Real-time Flash Sale countdown timer updates synchronously every second without causing dropped UI frames or rebuilding unrelated page sections.
- **SC-003**: Navigation from Product Details to the full Reviews screen (`/product/:id/reviews`) occurs seamlessly in under 200 milliseconds.
- **SC-004**: Users can successfully trigger "Add to Basket" with their chosen variant selections in a single intuitive tap from the sticky bottom bar.
- **SC-005**: 100% of UI elements match the ShopX Figma design specifications for Screens 34, 35, 36, and 37 across standard mobile device viewports (`375.w` to `430.w`).
- **SC-006**: Automated static analysis (`flutter analyze`) reports 0 errors, warnings, or lint issues across all newly implemented files.

---

## Assumptions

- **Phase 1 Mock Data**: As established by the project Constitution, all product details, variants, countdown end-times, and customer reviews are provided by a structured in-memory mock data source (`ProductMockDataSourceImpl`) with realistic latency simulation.
- **Cart Integration**: "Add to Basket" in Phase 1 performs an optimistic local state confirmation (e.g., snackbar / status feedback) while the full cart checkout feature is queued for subsequent phases.
- **Single Page for Screens 34 & 36**: Screen 36 represents the initial compact view of Screen 34 prior to scrolling; both screens share a unified implementation in `ProductDetailsPage`.
- **Architectural Scope**: `reviews` is maintained as a sub-module of `feature/product` with its own dedicated Cubit (`ReviewsCubit`) rather than an independent feature package.
- **Asset Availability**: Product photography and reviewer avatars reuse existing assets located in `assets/images/` without creating new asset binaries.

---

## Permanent Project Rules Reference

All features MUST strictly comply with the Permanent Project Rules defined in the project Constitution (`.specify/memory/constitution.md`):
1. **Verification Timing**: Do NOT run `flutter analyze` or `flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (.w, .h, .r, .sp). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., `DiscountBadge`, `ShopProductCard`, `PrimaryButton`, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
