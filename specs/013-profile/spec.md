# Feature Specification: User Profile, Activity Dashboard & Rewards Center

**Feature Directory**: `specs/013-profile`

**Feature Branch**: `feat/user-profile-activity-rewards`

**Created**: 2026-11-01

**Status**: Draft

**Input**: User description: "Profile feature covering Screens 62 (Profile Home with regular announcement), 81 (Profile Home with reward notification), 85 (Profile Home with voucher expiring notification), 64 (My Activity with donut chart + order stats), 82 (My Vouchers active rewards list), 83 (Active Rewards with expiring warning), 84 (Rewards Progress grid)"

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Profile Home Dashboard & Engagement (Screens 62, 81, 85) (Priority: P1)

As an active online shopper, I want to view my profile home screen with a personalized greeting, contextual announcements, recently viewed products, order status shortcuts, and creator stories, so that I can monitor my account status, quickly access my orders, and discover relevant updates.

**Why this priority**: The Profile Home screen is the primary entry hub for all account management, order navigation, and rewards engagement. Without this core screen, users cannot access their activity dashboard, vouchers, or account history.

**Independent Test**: Can be tested independently by navigating to the Profile tab (`/profile`), confirming that the header, personalized greeting ("Hello, Romina!"), dynamic announcement card, horizontal recently viewed products list, order status pills ("To Pay", "To Recieve", "To Review"), and creator stories carousel render accurately according to design specifications.

**Acceptance Scenarios**:

1. **Given** an authenticated user navigating to the Profile tab (`/profile`), **When** the page renders, **Then** they see a top header row with the user avatar (circular, ~44x44), a blue pill button labeled `My Activity`, and three circular utility icon buttons on the right (Chat, Menu, Settings).
2. **Given** the Profile Home screen, **When** the greeting section renders, **Then** the large bold title `Hello, Romina!` displays immediately below the header.
3. **Given** a regular announcement state (Screen 62), **When** the announcement card renders, **Then** it displays a light neutral rounded container with the title `Announcement`, descriptive text ("Lorem ipsum dolor sit amet..."), and a blue circular action button containing a white right arrow on the right edge.
4. **Given** a reward-earned announcement state (Screen 81), **When** the announcement card renders, **Then** it displays a circular light blue badge with a blue heart icon on the left, the title `You just got a Reward`, descriptive text, and a light neutral container.
5. **Given** a voucher-expiring announcement state (Screen 85), **When** the announcement card renders, **Then** it displays a light pink tinted background container, a circular light pink badge with a red shopping bag icon on the left, the title `Your Voucher will expire in 3 days`, and descriptive text.
6. **Given** the "Recently viewed" section, **When** rendered, **Then** the bold header `Recently viewed` is followed by a horizontal scrollable row of small, square rounded product preview cards reusing existing product image assets.
7. **Given** a product card in "Recently viewed", **When** the user taps it, **Then** the app navigates to the corresponding product details screen (`/product/:id`).
8. **Given** the "My Orders" section, **When** rendered, **Then** the bold header `My Orders` displays three pill tabs: `To Pay`, `To Recieve` (featuring an indicator dot badge: red dot in Screen 62, green dot in Screens 81/85), and `To Review`.
9. **Given** any of the "My Orders" pill tabs, **When** the user taps `To Pay`, `To Recieve`, or `To Review`, **Then** the application navigates to the Orders feature (`/orders?tab=<tab>`) with the corresponding tab pre-selected.
10. **Given** the "Stories" section, **When** rendered, **Then** the bold header `Stories` is followed by a horizontal scrollable row of vertical rounded cards with creator photos; the first card features a top-left pill with a red dot and `Live` badge, and each card displays a centered semi-transparent play button.
11. **Given** a story card, **When** the user taps it, **Then** the application displays a temporary feedback notice (SnackBar) indicating story playback.

---

### User Story 2 - Financial Spending Summary & Activity Tracking (Screen 64) (Priority: P2)

As a budget-conscious shopper, I want to inspect my monthly spending breakdown via an interactive donut chart and view my order fulfillment statistics, so that I understand where my money is going across shopping categories and track my monthly purchasing volume.

**Why this priority**: Financial transparency and spending analytics give users deep insights into their shopping behavior and provide direct access to order history.

**Independent Test**: Can be tested independently by tapping the `My Activity` pill from Profile Home or navigating directly to `/profile/my-activity`, verifying the month selector ("April") with navigation arrows, checking that the 4-segment donut chart accurately depicts category spending with the centered total (`$365,00`), confirming the 4 category pills and 3 order statistic badges ("12 Ordered", "7 Recieved", "5 To Recieve"), and tapping `Order History`.

**Acceptance Scenarios**:

1. **Given** the user on Profile Home, **When** they tap the blue `My Activity` button in the header, **Then** the application navigates to the My Activity screen (`/profile/my-activity`).
2. **Given** the My Activity screen, **When** rendered, **Then** the top bar displays the user avatar, bold title `My Activity`, and the three utility icon buttons (Chat, Menu, Settings).
3. **Given** the Month Selector, **When** rendered, **Then** a centered light grey pill displays the active month name (`April`).
4. **Given** the donut chart section, **When** rendered, **Then** circular navigation arrow buttons appear on the left and right, and a large multi-colored donut chart displays with 4 distinct proportional segments:
   - Blue segment (Clothing: `$183,00` ~ 50.1%)
   - Green segment (Lingerie: `$92,00` ~ 25.2%)
   - Orange segment (Shoes: `$47,00` ~ 12.9%)
   - Pink/Red segment (Bags: `$43,00` ~ 11.8%)
5. **Given** the donut chart center, **When** rendered, **Then** it clearly displays the label `Total` above the prominent bold amount `$365,00`.
6. **Given** the category legend below the chart, **When** rendered, **Then** four colored pills display with white typography matching the chart segments: `Clothing $183,00` (blue), `Lingerie $92,00` (green), `Shoes $47,00` (orange), and `Bags $43,00` (pink/red).
7. **Given** the order statistics row, **When** rendered, **Then** three circular blue badges display white counts with labels beneath: `12` with `Ordered`, `7` with `Recieved`, and `5` with `To Recieve`.
8. **Given** the `Order History` button at the bottom of My Activity, **When** the user taps it, **Then** the application navigates directly to the Order History list screen (`/orders/history`).
9. **Given** the left and right navigation arrows beside the donut chart, **When** tapped, **Then** the month updates and displays corresponding monthly expenditure data.

---

### User Story 3 - Active Voucher Management & Expiration Warnings (Screens 82, 83) (Priority: P3)

As a bargain shopper, I want to browse my available reward vouchers and clearly identify those approaching expiration, so that I can redeem my discounts before they expire and maximize my savings.

**Why this priority**: Vouchers directly incentivize purchases and drive conversion; clear expiration indicators prevent customer frustration over expired discounts.

**Independent Test**: Can be tested independently by navigating to `/profile/rewards`, verifying that the "Active Rewards" tab is selected, inspecting the ticket-notched voucher cards with dashed cut lines and validity dates, and confirming the urgent styling (red border, pink fill, "3 days left") on expiring vouchers.

**Acceptance Scenarios**:

1. **Given** the user navigates to the Rewards Center (`/profile/rewards`), **When** the page loads, **Then** two top toggle pills are displayed: `Active Rewards` (active light blue fill) and `Progress` (inactive neutral fill).
2. **Given** the `Active Rewards` tab is active (Screen 82), **When** vouchers are rendered, **Then** each voucher displays as a ticket-shaped card featuring rounded corners, concave circular side notch cutouts, a solid blue outline, and a horizontal dashed blue divider line connecting the notches.
3. **Given** a standard active voucher card, **When** rendered, **Then** above the dashed divider it displays `Voucher` on the left and coral-colored expiration text (e.g. `Valid Until 5.16.20` or `Valid Until 6.20.20`) on the right; below the dashed divider it displays a blue status badge icon (e.g. badge checkmark, shopping bag, or heart), a bold title (`From Customer Care`, `First Purchase`, `Loyal Customer`), and a subtitle discount description (`15% off your next purchase`, `5% off for your next order`).
4. **Given** an urgent expiring voucher state (Screen 83), **When** an expiring voucher is rendered, **Then** it displays with a prominent red outline, a soft pink tinted background fill, a red dashed divider, a red `Voucher` label, and a bold red warning label `3 days left` in place of the standard date.
5. **Given** any voucher card in the list, **When** the user taps the voucher card, **Then** the application acknowledges the selection with feedback (e.g. copying code or displaying voucher details).

---

### User Story 4 - Gamified Rewards Progress & Achievement Milestones (Screen 84) (Priority: P4)

As a loyal customer, I want to track my achievement progress and earned reward badges in a structured milestone grid, so that I feel recognized for my shopping loyalty and know what requirements to fulfill for upcoming rewards.

**Why this priority**: Gamified progress reinforces retention and incentivizes repeat purchases by making customer achievements visual and rewarding.

**Independent Test**: Can be tested independently by selecting the `Progress` tab on `/profile/rewards`, verifying the 2x3 grid of reward achievement badges with titles and descriptions, confirming that earned badges display checkmark indicators, and toggling between tabs without loss of state.

**Acceptance Scenarios**:

1. **Given** the user on the Rewards Center (`/profile/rewards`), **When** they tap the `Progress` pill tab, **Then** the `Progress` tab highlights in active light blue, the `Active Rewards` tab switches to neutral, and the rewards progress grid (Screen 84) is displayed.
2. **Given** the rewards progress grid, **When** rendered, **Then** six achievement cards are displayed in a 2-column by 3-row layout:
   - `First Purchase`: Blue rounded-square container with shopping bag icon and circular earned checkmark badge on top-right.
   - `Loyal Customer`: Blue rounded-square container with heart icon and circular earned checkmark badge on top-right.
   - `Review Maker`: Circular blue outline with white interior and solid blue 5-point star icon.
   - `Big Soul`: Circular blue outline with white interior and solid blue cloud icon.
   - `Cloth Expert`: Circular blue outline with white interior and solid blue t-shirt icon.
   - `10+ Orders`: Circular blue outline with white interior and solid blue smiley face icon.
3. **Given** each achievement card, **When** rendered, **Then** it displays a bold title and multi-line secondary description explaining the qualification criteria.
4. **Given** the user on the `Progress` tab, **When** they tap the `Active Rewards` tab, **Then** the screen immediately transitions back to the active vouchers ticket list without network re-fetching.

---

### Edge Cases

- **Empty Recently Viewed Products**: If the user has not recently viewed any products, the "Recently viewed" section renders a graceful empty state message prompting them to discover catalog items, preserving layout balance.
- **Zero Spending for Selected Month**: If a user navigates to a month with zero purchase activity in My Activity, the donut chart displays a neutral full-circle ring with a `$0,00` total, zeroed category legend items, and zeroed order counts.
- **Zero Active Vouchers**: If all vouchers are redeemed or expired, the Active Rewards tab renders a clean empty state with a friendly icon and a button directing users to explore current promotions.
- **Text Scaling & Long Descriptions**: Announcement copy, voucher titles, and reward descriptions must support variable length without vertical clipping or horizontal overflow on smaller screens.
- **Rapid Month Switching**: Tapping month navigation arrows in rapid succession queues state updates smoothly without UI stutters or corrupted chart segment calculations.
- **Offline / Network Interruption**: If cached profile data is available, it continues to display with a subtle offline notice; if initial load fails, a retry widget is presented.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST render the Profile Home view (`/profile`) as a primary tab inside the persistent bottom navigation shell (`CustomBottomNavBar`).
- **FR-002**: The system MUST display a top header row on Profile screens containing user avatar (~44x44), a blue pill button `My Activity`, and utility icon buttons (Chat, Menu, Settings).
- **FR-003**: The system MUST support dynamic contextual announcement cards on Profile Home across three distinct states:
  - `regular`: Neutral background, "Announcement" title, copy text, circular blue arrow button.
  - `rewardEarned`: Neutral background, circular blue heart badge on left, "You just got a Reward" title, copy text.
  - `voucherExpiring`: Soft pink background, circular red shopping bag badge on left, "Your Voucher will expire in 3 days" title, copy text.
- **FR-004**: The system MUST display a horizontal scrollable list of recently viewed products on Profile Home reusing existing product image assets, navigating to `/product/:id` on tap.
- **FR-005**: The system MUST display three order status filter tabs on Profile Home (`To Pay`, `To Recieve` with indicator dot badge, `To Review`), navigating to `/orders?tab=<tab>` with the corresponding filter active.
- **FR-006**: The system MUST display a horizontal creator stories carousel on Profile Home featuring creator images, play buttons, and a red `Live` badge on the first card.
- **FR-007**: The system MUST provide a "My Activity" financial dashboard (`/profile/my-activity`) featuring an interactive month selector, previous/next navigation controls, and aggregated monthly expenditure.
- **FR-008**: The system MUST render a proportional 4-segment donut chart on the My Activity screen depicting category expenditure (Clothing, Lingerie, Shoes, Bags) around a centered total spending display (`$365,00`).
- **FR-009**: The system MUST display a 4-pill category legend (with matching segment colors) and a 3-badge order statistics row (`Ordered`, `Recieved`, `To Recieve`) on the My Activity screen.
- **FR-010**: The system MUST provide an `Order History` primary CTA button on My Activity navigating directly to `/orders/history`.
- **FR-011**: The system MUST provide a Rewards Center (`/profile/rewards`) with toggleable tabs for `Active Rewards` (vouchers list) and `Progress` (milestones grid).
- **FR-012**: The system MUST render active vouchers as ticket-style cards featuring rounded corners, concave circular notch cutouts, dashed divider lines, validity dates, discount details, and special red alert styling (red border, pink fill, "3 days left") for expiring vouchers.
- **FR-013**: The system MUST render a 2-column by 3-row grid of gamified achievement badges on the Rewards Progress tab with distinct milestone icons, titles, descriptions, and earned completion checkmarks.
- **FR-014**: The system MUST display shimmer placeholder loaders during all asynchronous data loading across Profile, My Activity, and Rewards views.
- **FR-015**: The system MUST strictly enforce design tokens (`AppColors`, `AppSpacing`, `AppTypography`) with zero hardcoded values, adding any necessary tokens for chart colors, voucher alerts, and reward backgrounds to the tokens registry first.
- **FR-016**: The system MUST strictly reuse existing project assets from `assets/images/` and `assets/design_references/` without generating any new image or icon files.

---

### Key Entities

- **`UserProfileEntity`**: Represents the authenticated user profile, containing identifier (`id`), display name (`name`), greeting title (`greeting`), and avatar image path (`avatarUrl`).
- **`AnnouncementEntity`**: Represents home screen announcements, containing identifier (`id`), title, descriptive message (`subtitle`), announcement variant type (`ProfileAnnouncementType`: `regular`, `rewardEarned`, `voucherExpiring`), and navigation route action.
- **`RecentlyViewedItemEntity`**: Represents a previously browsed product item, containing item identifier and associated product details (`ShopProductEntity`).
- **`OrderStatsEntity`**: Represents post-purchase order volume metrics, containing counts for `orderedCount`, `receivedCount`, and `toReceiveCount`.
- **`ActivitySummaryEntity`**: Represents monthly financial spending analytics, containing month label (`month`), total amount spent (`totalAmount`), category breakdown list (`List<CategorySpendingEntity>`), and order statistics (`OrderStatsEntity`).
- **`CategorySpendingEntity`**: Represents spending within a single shopping category, containing category name (`name`), total amount spent (`amount`), and associated segment color token reference.
- **`VoucherEntity`**: Represents a discount voucher, containing identifier (`id`), title, description, validity date string (`validUntil`), expiration flag (`isExpiring`), and remaining days count (`daysLeft`).
- **`RewardMilestoneEntity`**: Represents a gamified loyalty achievement, containing identifier (`id`), title, criteria description, badge icon type identifier (`iconType`), and completion status (`isEarned`).

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Profile Home, My Activity, and Rewards screens load and render all respective components within 1 second under standard test conditions.
- **SC-002**: 100% visual fidelity matching Figma design reference images (`62`, `81`, `85`, `64`, `82`, `83`, `84`) in colors, spacing, typography, corner radii, and icon placements.
- **SC-003**: Navigation from Profile Home to My Activity (`/profile/my-activity`), Rewards (`/profile/rewards`), Orders (`/orders?tab=<tab>`), and Order History (`/orders/history`) completes seamlessly with 100% routing accuracy.
- **SC-004**: Donut chart angular arcs accurately reflect mathematical proportions of total spending ($183 / $365 = 50.1%, $92 / $365 = 25.2%, $47 / $365 = 12.9%, $43 / $365 = 11.8%) within ±0.5% precision.
- **SC-005**: Switching between `Active Rewards` and `Progress` tabs occurs instantaneously (<100ms) with zero layout jump or unhandled state transitions.
- **SC-006**: Expiring vouchers are visually distinguished within 100ms of rendering via red border styling and "3 days left" badge, matching Screen 83.
- **SC-007**: Static analysis (`fvm flutter analyze`) passes with zero warnings or errors.
- **SC-008**: 100% compliance with design tokens: zero hardcoded color hex values, zero hardcoded spacing values, and zero hardcoded font styles in widget implementations.
- **SC-009**: Zero new image or icon files introduced; all visuals reuse existing project assets.

---

## Assumptions

- Target user is authenticated with an established session and profile (default mock persona "Romina").
- Phase 1 scope operates strictly with structured mock data sources for user profile, announcements, spending activity, vouchers, and rewards.
- Secondary utility icon buttons (Chat, Menu, Settings) and Stories interaction display informative SnackBar placeholders during Phase 1.
- Orders integration relies on the existing `/orders` and `/orders/history` routes implemented in previous features.
- Screen dimensions and responsive scaling are handled via `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`).
- The bottom navigation bar persists across all main profile views using the existing `CustomBottomNavBar` shell.

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
12. **FVM-ONLY CLI COMMANDS**: ALWAYS use `fvm flutter` (NOT bare `flutter`) for ALL Flutter CLI commands (`analyze`, `test`, `run`, `build`, `pub get`, etc.).

