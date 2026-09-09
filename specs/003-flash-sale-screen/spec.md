# Feature Specification: Flash Sale Screen

**Feature Branch**: `003-flash-sale-screen`

**Created**: 2026-09-04

**Status**: Draft

**Input**: User description: Dedicated flash sale page displaying discounted products with live countdown, discount filters, and live stream section. Accessed from Home's "Flash Sale" section or "See All" button. Phase 1 — UI Only with Mock Data. Design extracted from Figma screenshots.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Browse Flash Sale Products by Discount Filter (Priority: P1)

As a shopper, I want to open the Flash Sale screen and view limited-time discounted products filtered by discount tiers (All, 10%, 20%, 30%, 40%, 50%), so that I can quickly find deals tailored to my budget and preferences.

**Why this priority**: Core value of the screen is discovering and browsing discounted items organized by discount percentage.

**Independent Test**: Navigate to the Flash Sale screen, observe default/active discount filter (e.g., 20% Discount active), and verify that products matching that discount tier are displayed in a two-column grid.

**Acceptance Scenarios**:

1. **Given** the user navigates to the Flash Sale screen from Home, **When** the screen finishes loading, **Then** the header shows "Flash Sale", a live countdown timer box `[00] [36] [58]`, a subtitle "Choose Your Discount", and the horizontal discount filter bar with "20%" selected by default.
2. **Given** the user is viewing the Flash Sale screen with "20%" selected, **When** the user taps on another discount chip (e.g., "30%" or "All"), **Then** the active filter chip updates with the selected pill/indicator styling, the section heading updates to reflect the active selection (e.g., "30% Discount"), and the product grid displays items corresponding to that discount.
3. **Given** the user views each product card in the grid, **When** observing its details, **Then** it renders a grey rounded product image container with light border/padding, a top-right corner pill-shaped discount tag `-20%` (gradient pink/red with white text), a 2-line title/description ("Lorem ipsum dolor sit amet consectetur"), and price row showing current price `$16,00` in bold black and crossed-out original price `$20,00` in strike-through light red/pink.

---

### User Story 2 - Flash Sale Header with Live Countdown & Filter Controls (Priority: P2)

As a shopper, I want to see an urgent countdown timer and easily switch categories or access filter settings, so that I understand how much time remains for these deals.

**Why this priority**: The countdown and header styling (soft gradient glow at top) create excitement and urgency which defines the "Flash Sale" shopping pattern.

**Independent Test**: Inspect the Flash Sale top bar; verify the stopwatch icon and 3 white rounded rectangular countdown timer blocks (HH:MM:SS), subtitle text, and settings/filter gear icon next to the section title.

**Acceptance Scenarios**:

1. **Given** the screen is open, **When** observing the top AppBar area, **Then** it displays "Flash Sale" (bold, ~22sp), an outline stopwatch icon followed by three distinct white rounded rectangular countdown boxes with dark numbers separated by spacing (`00`, `36`, `58`), against a subtle blue aura gradient background.
2. **Given** the discount section header, **When** observing the row above the product grid, **Then** the current discount level title (e.g., "20% Discount") appears on the left, and a settings/filter gear icon appears on the right. Tapping the gear icon opens a filter options sheet or toast.

---

### User Story 3 - Live Stream Banner & Promotional Media Showcase (Priority: P3)

As a shopper, I want to see a live shopping showcase banner ("ARTICALE REIMAGINED" / "LIVE") with a video play indicator, so that I can explore featured live streams or curated brand collections.

**Why this priority**: Enhances engagement and showcases live commerce features integrated into the sale.

**Independent Test**: Verify the live card banner appears below the discount filter chips, displaying the collage image, translucent play button, title "ARTICALE REIMAGINED", and vibrant green pill badge "LIVE".

**Acceptance Scenarios**:

1. **Given** the user scrolls past the discount filter chips, **When** viewing the media showcase banner, **Then** it displays a rounded rectangle card with multi-model promotional imagery, a centered circular play icon button, a lower bar with text "ARTICALE REIMAGINED" and a bright green rounded pill badge displaying "LIVE" in white bold uppercase text.
2. **Given** the user taps on the live banner card, **When** tapped, **Then** it provides visual feedback (tap interaction placeholder for live stream player).

---

### User Story 4 - Mid-Page Promotional Banner & "Most Popular" Carousel (Priority: P4)

As a shopper, I want to see promotional sale banners ("Big Sale Up to 50%") and a "Most Popular" trending items row with quick stats, so that I discover additional trending deals within the flash sale page.

**Why this priority**: Keeps users engaged with cross-promoted campaigns and popular items without leaving the flash sale context.

**Independent Test**: Scroll down the page past the product grid, observe the golden-yellow and blue split "Big Sale Up to 50% - Happening Now" banner, and the "Most Popular" section with product cards displaying item views/likes (e.g., "1780 ❤️ New", "1780 ❤️ Sale", "1780 ❤️ Hot").

**Acceptance Scenarios**:

1. **Given** the user scrolls below the flash sale product grid, **When** reaching the promotional section, **Then** a dual-color rounded banner ("Big Sale", "Up to 50%", "Happening Now" on blue curved splash with model graphic on mustard gold) is displayed.
2. **Given** the user reaches the "Most Popular" section, **When** viewing the section header, **Then** "Most Popular" title appears on the left, and "See All" with a blue circular arrow icon appears on the right.
3. **Given** the "Most Popular" horizontal list, **When** viewing each card, **Then** each card shows a rounded image container, bottom caption bar with views/likes count, blue heart icon, and status badge ("New", "Sale", "Hot").

---

### Edge Cases

- **Empty State for a Filter**: If a selected discount percentage has no matching products in the mock data, display an empty state placeholder ("No products found for this discount tier").
- **Zero Countdown**: When the timer reaches `00:00:00`, the timer maintains `00:00:00` gracefully without crashing or throwing state errors.
- **Screen Dimensions & Scaling**: All cards, badges, and grids maintain aspect ratio and padding across different screen sizes using `flutter_screenutil`.
- **Fast Tab Switching**: Rapid tapping across discount tabs does not trigger duplicate state emissions or UI flickering.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide a dedicated Flash Sale screen accessible via navigation route (e.g., `/flash-sale`).
- **FR-002**: System MUST render an AppBar with back button, screen title "Flash Sale", stopwatch icon, and 3 countdown timer boxes (Hours, Minutes, Seconds) with active countdown ticking.
- **FR-003**: System MUST display a horizontal scrollable/selectable discount filter bar containing chips: "All", "10%", "20%", "30%", "40%", "50%".
- **FR-004**: System MUST highlight the currently selected discount filter with the custom selected indicator pill style matching the Figma design (blue border/indicator notch, bold font).
- **FR-005**: System MUST present the Live Stream showcase card featuring collage thumbnail, central play button, title "ARTICALE REIMAGINED", and green "LIVE" badge.
- **FR-006**: System MUST render a discount section header with dynamic text (e.g., "[X]% Discount") matching the active filter, accompanied by a settings/filter gear action button.
- **FR-007**: System MUST render a 2-column responsive product grid displaying flash sale items with corner discount badges, grey image container, 2-line title, current price, and crossed-out original price.
- **FR-008**: System MUST display the "Big Sale Up to 50%" promotional split-color banner below the product grid.
- **FR-009**: System MUST render the "Most Popular" section with "See All" action and horizontal cards showing view counts, blue heart icons, and status labels ("New", "Sale", "Hot").
- **FR-010**: System MUST maintain the persistent bottom navigation shell as defined by the application architecture.
- **FR-011**: System MUST supply rich, realistic mock data for all sections (products, countdown initial time, discount tiers, live stream info, popular products).

### Key Entities *(include if feature involves data)*

- **FlashSaleProduct**: Represents a product on sale. Attributes: id, name, imageUrl, currentPrice, originalPrice, discountPercentage (e.g., 20), rating/likes.
- **DiscountTier**: Represents filter chip options. Attributes: id, label (e.g., "All", "10%", "20%"), discountValue (nullable for "All"), isSelected.
- **FlashSaleLiveStream**: Represents live shopping event. Attributes: id, title ("ARTICALE REIMAGINED"), thumbnailUrl, isLive, viewerCount.
- **PopularProduct**: Represents trending item in Most Popular. Attributes: id, name, imageUrl, likeCount (e.g., 1780), tag ("New", "Sale", "Hot").

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% visual fidelity with the provided Figma screenshot across typography, colors, badges, paddings, and component hierarchy.
- **SC-002**: Flash Sale screen opens smoothly with zero UI overflow errors on standard screen sizes (375x812, 390x844, 412x915).
- **SC-003**: Switching discount filter chips updates the displayed product list and title within 1 frame (instant UI response).
- **SC-004**: Countdown timer ticks down second-by-second accurately without memory leaks or excessive rebuilds.
- **SC-005**: Product cards, banners, and carousels scroll smoothly at 60fps with no frame drops.

## Assumptions

- **Phase 1 Scope**: Implementation is purely UI-driven backed by local mock data sources (no live network backend or WebRTC live streaming engine required in Phase 1).
- **Design Tokens**: Colors, fonts, and icons leverage existing tokens in `lib/core/` and `lib/config/theme/` (extending with any flash-sale specific constants like the custom live green badge and countdown box styles).
- **Responsive Sizing**: Sizing uses `flutter_screenutil` according to the E-Store Constitution.
- **Architecture**: Implemented as Clean Architecture feature under `lib/features/flash_sale/` (or structured under existing shop navigation) using Cubit state management.
