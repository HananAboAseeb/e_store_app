# Feature Specification: Orders Management, Tracking & Reviews

**Feature Directory**: `specs/012-orders`

**Feature Branch**: `feat/orders-tracking-reviews`

**Created**: 2026-10-03

**Status**: Draft

**Input**: User description: "Orders feature covering Screens 57 (To Receive Orders List), 58 (Review Option Sheet), 59 (Tracking Timeline in progress), 60 (Delivery Failed Modal), 61 (Delivery Attempt Failed Timeline), 63 (Delivered Timeline Complete), 65 (Order History List), 66 (Write Review Modal), 67 (Review Confirmation Dialog)"

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Viewing & Filtering Active Orders (Screen 57) (Priority: P1)

As an online shopper, I want to access my order center and filter orders across tabs ("To Pay", "To Receive", "To Review"), so that I can monitor my ongoing purchases, view shipment status at a glance, and initiate actions like tracking or reviewing.

**Why this priority**: Core entry point for all post-purchase interactions. Without the orders list and status visibility, users cannot monitor shipments or access tracking and review capabilities.

**Independent Test**: Can be tested independently by navigating to the Orders screen (`/orders`), verifying that order cards render with product thumbnails (+N badge), order numbers, delivery tier labels, item count badges, and accurate status labels ("Packed", "Shipped", "Delivered ✓"), and confirming that clicking tabs filters the list.

**Acceptance Scenarios**:

1. **Given** a user navigating to the Orders page (`/orders`), **When** the screen loads, **Then** they see the top header with user avatar, title "To Receive", subtitle "My Orders", action icons (message, filter, settings), and three filter tabs: "To Pay", "To Receive" (active by default with blue highlight), and "To Review".
2. **Given** the "To Receive" tab is active, **When** order cards are displayed, **Then** each card shows 2–3 thumbnail product images with an overflow indicator (e.g., `+2`), order number (e.g., `Order #92287157`), "Standard Delivery" label, an item count pill (e.g., `3 items`), and a fulfillment status indicator (`Packed`, `Shipped`, or `Delivered ✓`).
3. **Given** an order in `Packed` or `Shipped` status, **When** the user looks at the right-side action button, **Then** they see a solid blue pill button labeled `Track`.
4. **Given** an order in `Delivered` status, **When** the user looks at the right-side action button, **Then** they see an outlined blue pill button labeled `Review`.
5. **Given** an order card, **When** the user taps `Track`, **Then** the application navigates to the order tracking timeline (`/orders/:id/tracking`).
6. **Given** an order card with `Delivered` status, **When** the user taps `Review`, **Then** the application opens the item selection modal (Screen 58).

---

### User Story 2 - Real-Time Order Tracking & Milestone Timeline (Screens 59, 63) (Priority: P2)

As a shopper awaiting a parcel, I want to view a detailed vertical progress timeline of my order from warehouse packing to final doorstep delivery, so that I have complete transparency on my package's current transit stage and estimated fulfillment.

**Why this priority**: Shipment tracking provides customer peace of mind, reduces support inquiries, and serves as the visual confirmation of fulfillment progress.

**Independent Test**: Can be tested independently by opening `/orders/:id/tracking` for an active order, verifying the summary header with thumbnails and LGS tracking code, and confirming that the 5-step milestone timeline renders completed steps in blue with timestamps and pending steps in neutral gray.

**Acceptance Scenarios**:

1. **Given** the user navigates to Order Tracking (`/orders/:id/tracking`), **When** the screen loads, **Then** they see the top header, an order summary card (thumbnails, order number, delivery tier, item count pill, repeated order ID, and LGS tracking code with copy action), and a vertical 5-step timeline.
2. **Given** an order in progress (Screen 59), **When** the timeline renders, **Then** completed milestones (e.g., "Packed" at `April 19 12:31`, "On the Way to Logistic Facility" at `April 19 16:20`) display with blue circular status icons and timestamps, while remaining milestones ("Arrived at Logistic Facility", "Shipped", "Delivered") render with neutral gray icons and timestamps.
3. **Given** a fully delivered order (Screen 63), **When** the tracking screen renders, **Then** all 5 timeline milestones display as completed in blue, with the final step "Delivered" marked at `April 21 09:34`.
4. **Given** the tracking screen, **When** the user taps the copy icon next to the tracking number, **Then** the tracking number is copied to clipboard with immediate feedback.

---

### User Story 3 - Handling Failed Delivery Attempts (Screens 61, 60) (Priority: P3)

As a shopper whose delivery could not be completed, I want to see an explicit failed delivery notification in the tracking timeline and access actionable support options, so that I understand why delivery stopped and can promptly reschedule or contact customer care.

**Why this priority**: Prevents lost parcels and user frustration by providing direct resolution steps when exceptions occur during last-mile delivery.

**Independent Test**: Can be tested independently by navigating to the tracking page for an order with a delivery failure state (Screen 61), verifying the red failed milestone, tapping "Learn more", and confirming the "Delivery was failed" modal (Screen 60) appears with customer care details and "Chat Now".

**Acceptance Scenarios**:

1. **Given** an order with an unsuccessful delivery attempt (Screen 61), **When** the tracking timeline displays, **Then** an alert milestone is shown at the end with a red circular status icon, the description "Attempt to deliver your parcel was not successful", and an inline blue pill button labeled `Learn more`.
2. **Given** the failed delivery milestone, **When** the user taps `Learn more`, **Then** the "Delivery was failed" modal bottom sheet (Screen 60) appears.
3. **Given** the "Delivery was failed" modal, **When** presented, **Then** the user sees title "Delivery was failed", subtitle "What should I do?", informative explanation text with support contact number `+00 000 000 000`, a dismiss `✕` button, and a primary `Chat Now` button.
4. **Given** the "Delivery was failed" modal, **When** the user taps `Chat Now`, **Then** the app triggers the customer care chat channel (or displays a helpful snackbar notice if live chat is pending).
5. **Given** the modal, **When** the user taps `✕` or outside the modal, **Then** the modal is dismissed and tracking view is restored.

---

### User Story 4 - Order History Inspection & Review Selection (Screens 65, 58) (Priority: P4)

As a returning customer, I want to view my past completed order history and select specific purchased items to review, so that I can easily browse my previous transactions and share product feedback.

**Why this priority**: Historical visibility gives users a record of past purchases and is the prerequisite gateway for writing product reviews on multi-item orders.

**Independent Test**: Can be tested independently by navigating to `/orders/history` (Screen 65), verifying the vertical past orders list with date pills and outline "Review" buttons, tapping "Review", and verifying that the "Review item" bottom sheet (Screen 58) opens with the items list.

**Acceptance Scenarios**:

1. **Given** the user navigates to `/orders/history`, **When** the page renders, **Then** they see the top header ("History", user avatar, action icons) and a vertical list of completed orders displaying product thumbnail, 2-line title/description, order number, delivery date pill (e.g., `April, 06`), and an outlined blue pill button labeled `Review`.
2. **Given** a historical order with multiple items, **When** the user taps `Review`, **Then** the "Review item" modal bottom sheet (Screen 58) opens with a top rounded radius of 24.r, header "Review item", subtitle "Which item you want to review?", and a `✕` dismiss button.
3. **Given** the "Review item" modal, **When** items are displayed, **Then** each item shows its product image, title, order ID, date pill, and a solid blue pill `Review` button.
4. **Given** an item in the "Review item" modal, **When** the user taps its `Review` button, **Then** the review authoring sheet (Screen 66) opens for that specific item.
5. **Given** the "Review item" modal, **When** the user taps `✕`, **Then** the sheet closes cleanly.

---

### User Story 5 - Item Rating, Comment Submission & Confirmation (Screens 66, 67) (Priority: P5)

As a verified buyer, I want to rate a purchased item using an interactive 5-star selector and write a text review, so that I can share authentic product feedback with other shoppers and confirm my submission.

**Why this priority**: Completes the end-to-end post-purchase lifecycle, generating social proof and customer ratings.

**Independent Test**: Can be tested independently by opening the review sheet (Screen 66), selecting a star rating (1–5), entering comments, tapping "Send Review", and confirming that the "Done!" confirmation dialog (Screen 67) renders with golden stars and auto-dismisses.

**Acceptance Scenarios**:

1. **Given** the user opens the review sheet (Screen 66), **When** the sheet renders, **Then** they see header "Review", `✕` close button, product summary with user avatar, product description, order number, an interactive row of 5 star rating icons, a multi-line "Your comment" text field, and a solid `Send Review` primary button.
2. **Given** the star rating row, **When** the user taps the 4th star, **Then** stars 1 through 4 light up in gold (`#FFAE00`) and the 5th star remains unfilled.
3. **Given** a selected star rating and text comment, **When** the user taps `Send Review`, **Then** the review is submitted and the "Done!" confirmation dialog (Screen 67) opens.
4. **Given** the "Done!" confirmation dialog, **When** displayed, **Then** it shows a centered circular blue badge with white checkmark (`✓`), title "Done!", subtitle "Your review has been successfully sent", and 5 golden stars.
5. **Given** the confirmation dialog, **When** 2–3 seconds elapse or the user taps the dialog, **Then** the dialog dismisses and the user is returned to the updated Orders or History list.

---

### Edge Cases

- **Zero Orders in Tab**: When an active tab ("To Pay", "To Receive", or "To Review") contains no orders, display a friendly empty state using the shared `NoDataFoundWidget` with an appropriate message and "Shop Now" action instead of an empty blank page.
- **Multi-Item Order Display**: Orders containing more than 3 items must display 2–3 thumbnails with a "+N" overflow badge (e.g., `+2`) that correctly calculates the remaining item count without layout overflow.
- **Copy Tracking Number**: Tapping the copy icon must copy the tracking code to the system clipboard and show a transient snackbar "Tracking number copied to clipboard".
- **Empty Review Submission**: The "Send Review" button must be disabled or require at least 1 star selected before submission. Text comments are optional or must enforce standard validation without crashing.
- **Long Item Titles & Comments**: Product descriptions in the order card, history list, and review sheet must truncate with `TextOverflow.ellipsis` (`maxLines: 2`) preventing render overflows.
- **Back Navigation from Modals**: Closing modals via `✕` button, background barrier tap, or system back gesture must cleanly restore previous state without navigating away from the parent page.
- **Persistent Bottom Nav**: The Orders feature must maintain the persistent bottom navigation shell with the Profile tab (index 4) highlighted.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide an Orders page at route `/orders` with three category tabs: "To Pay", "To Receive", and "To Review".
- **FR-002**: Orders page MUST display a header containing the user's avatar, page title ("To Receive"), subtitle ("My Orders"), and three utility action icons (Messages, Filter, Settings).
- **FR-003**: System MUST display orders in a vertical scrollable list, each presented within an `OrderCard` with rounded corners and elevated card surface.
- **FR-004**: Each `OrderCard` MUST display 2–3 product thumbnail previews with an overflow badge (e.g., `+2`) for remaining items.
- **FR-005**: Each `OrderCard` MUST display order identifier (e.g., `Order #92287157`), delivery tier (`Standard Delivery`), item count pill (`3 items`), fulfillment status (`Packed`, `Shipped`, or `Delivered ✓`), and contextual action button.
- **FR-006**: When order status is `Packed` or `Shipped`, action button MUST be a solid pill button labeled `Track`.
- **FR-007**: When order status is `Delivered`, action button MUST be an outlined pill button labeled `Review`.
- **FR-008**: Tapping `Track` MUST navigate to the Order Tracking page at `/orders/:id/tracking`.
- **FR-009**: Order Tracking page MUST display an order summary card with product thumbnails, order ID, delivery tier, item count pill, repeated order identifier, LGS tracking code, and a copy button.
- **FR-010**: Order Tracking page MUST render a 5-milestone vertical timeline:
  1. Packed
  2. On the Way to Logistic Facility
  3. Arrived at Logistic Facility
  4. Shipped
  5. Delivered
- **FR-011**: In-progress tracking milestones (Screen 59) MUST render completed steps with primary blue circular badges and date/time stamps, while incomplete steps render in neutral gray.
- **FR-012**: Completed tracking milestones (Screen 63) MUST render all 5 steps with primary blue circular badges and completion timestamps.
- **FR-013**: When a delivery attempt fails (Screen 61), the timeline MUST display an additional alert step with a red circular badge, text "Attempt to deliver your parcel was not successful", and an inline blue pill button `Learn more`.
- **FR-014**: Tapping `Learn more` MUST open the "Delivery was failed" bottom sheet modal (Screen 60).
- **FR-015**: "Delivery was failed" modal MUST display bold title "Delivery was failed", subtitle "What should I do?", resolution guidance text with support number `+00 000 000 000`, a `✕` dismiss button, and a primary `Chat Now` button.
- **FR-016**: System MUST provide an Order History page at route `/orders/history` displaying completed past orders in a vertical list.
- **FR-017**: Each history item MUST display product image, description, order number, delivery date pill (e.g., `April, 06`), and an outlined `Review` button.
- **FR-018**: Tapping `Review` on a multi-item order MUST open the "Review Option" bottom sheet modal (Screen 58) with 24.r top border radius.
- **FR-019**: "Review Option" modal MUST display list of purchased items, each with thumbnail, title, order number, date pill, and a solid blue `Review` button.
- **FR-020**: Tapping `Review` on a specific item MUST open the "Review" bottom sheet modal (Screen 66) with 24.r top border radius.
- **FR-021**: "Review" modal MUST display product summary with user avatar, description, order number, an interactive 5-star rating bar (1–5 stars), a multi-line comment input field ("Your comment"), and a `Send Review` primary button.
- **FR-022**: Tapping `Send Review` MUST submit the review and open the centered "Review Done" confirmation dialog (Screen 67).
- **FR-023**: "Review Done" dialog MUST display a circular blue checkmark badge, title "Done!", subtitle "Your review has been successfully sent", 5 golden star icons, and dismiss automatically after 2.5 seconds or upon tap.
- **FR-024**: System MUST display shimmer loading placeholders during asynchronous data fetches across Orders list, Tracking, and History.

---

### Key Entities

- **`OrderEntity`**: Represents a customer order.
  - Attributes: `id` (String), `orderNumber` (String), `items` (List of `OrderItemEntity`), `deliveryType` (String), `itemCount` (int), `status` (`OrderStatus`), `trackingNumber` (String?), `createdAt` (DateTime), `deliveredAt` (DateTime?).
- **`OrderItemEntity`**: Represents an individual product line item within an order.
  - Attributes: `id` (String), `orderId` (String), `productId` (String), `title` (String), `description` (String), `imageUrl` (String), `price` (double), `formattedDate` (String), `isReviewed` (bool).
- **`TrackingStepEntity`**: Represents a milestone within the shipment tracking timeline.
  - Attributes: `id` (String), `title` (String), `timestamp` (String?), `isCompleted` (bool), `isFailed` (bool), `iconType` (String).
- **`OrderReviewEntity`**: Represents a customer-submitted product review.
  - Attributes: `id` (String), `orderId` (String), `itemId` (String), `rating` (int), `comment` (String), `submittedAt` (DateTime).
- **`OrderStatus` (Enum)**: `toPay`, `packed`, `shipped`, `delivered`, `failedAttempt`.
- **`OrderTab` (Enum)**: `toPay`, `toReceive`, `toReview`.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Orders list, Tracking timeline, and History screens load and render with mock data in under 500ms.
- **SC-002**: Switching tabs ("To Pay", "To Receive", "To Review") updates the filtered order list in under 100ms without UI flicker.
- **SC-003**: 100% of interactive widgets adhere strictly to the DRY principle (reusing `PrimaryButton`, `MetaPill`, `CustomBottomNavBar`, star rating patterns, and modal sheets).
- **SC-004**: 100% of design tokens are sourced from `AppColors`, `AppSpacing`, and `AppTypography` with zero hardcoded color or dimension literals.
- **SC-005**: All review submissions update local state immediately and present the confirmation dialog within 200ms.
- **SC-006**: Codebase static analysis (`fvm flutter analyze`) reports 0 errors and 0 warnings.

---

## Assumptions

- Orders feature is mounted in the application shell's 5-tab navigation under the Profile tab (index 4) or accessible via direct sub-route `/orders`.
- The user profile avatar and top action icons (message, filter, settings) use existing assets or standard Material/Cupertino icons matching Figma visual specs.
- Phase 1 relies exclusively on local mock data sources (`OrdersMockDataSource`) with at least 5 structured orders covering all statuses (`packed`, `shipped`, `delivered`, `failedAttempt`).
- The `Chat Now` action in the Delivery Failed modal displays a snackbar notification ("Connecting to Customer Care...") if live chat routing is pending integration.
- Star rating in Screen 66 defaults to 5 stars or requires the user to select at least 1 star before submitting.

---

## Architectural Definition & Clean Architecture Separation

### Architecture & Layer Structure

The `orders` feature is implemented as a standalone feature module (`lib/features/orders/`) strictly adhering to Feature-First Clean Architecture:

```
lib/features/orders/
├── data/
│   ├── datasources/
│   │   ├── orders_mock_datasource.dart
│   │   └── orders_mock_datasource_impl.dart
│   ├── models/
│   │   ├── order_model.dart
│   │   ├── order_item_model.dart
│   │   ├── tracking_step_model.dart
│   │   └── order_review_model.dart
│   └── repositories/
│       └── orders_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── order_entity.dart
│   │   ├── order_item_entity.dart
│   │   ├── tracking_step_entity.dart
│   │   └── order_review_entity.dart
│   ├── repositories/
│   │   └── orders_repository.dart
│   └── usecases/
│       ├── get_orders_usecase.dart
│       ├── get_order_history_usecase.dart
│       ├── get_order_tracking_usecase.dart
│       ├── get_items_to_review_usecase.dart
│       └── submit_review_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── orders_cubit.dart & orders_state.dart
    │   ├── order_tracking_cubit.dart & order_tracking_state.dart
    │   └── order_review_cubit.dart & order_review_state.dart
    ├── pages/
    │   ├── orders_page.dart (Screen 57)
    │   ├── order_tracking_page.dart (Screens 59, 61, 63)
    │   └── order_history_page.dart (Screen 65)
    └── widgets/
        ├── orders_header.dart
        ├── orders_tabs.dart
        ├── order_card.dart
        ├── order_tracking_timeline.dart
        ├── tracking_step_tile.dart
        ├── review_option_sheet.dart (Screen 58)
        ├── delivery_failed_sheet.dart (Screen 60)
        ├── review_sheet.dart (Screen 66)
        ├── review_done_dialog.dart (Screen 67)
        └── history_item_tile.dart (Screen 65)
```

### Cubit Responsibility Partitioning

1. **`OrdersCubit`** (Screens 57, 65):
   - Manages loading orders, tab switching (`toPay`, `toReceive`, `toReview`), and fetching order history.
   - States: `OrdersInitial`, `OrdersLoading`, `OrdersLoaded(orders, activeTab, filteredOrders, historyOrders)`, `OrdersError(Failure)`.
2. **`OrderTrackingCubit`** (Screens 59, 61, 63):
   - Manages tracking timeline data, milestone progression, and failure state flags (`hasFailedAttempt`).
   - States: `TrackingInitial`, `TrackingLoading`, `TrackingLoaded(order, steps, hasFailedAttempt)`, `TrackingError(Failure)`.
3. **`OrderReviewCubit`** (Screens 58, 66, 67):
   - Manages loading items to review, item selection, interactive star rating, comment editing, and review submission.
   - States: `ReviewInitial`, `ReviewItemsLoaded(items)`, `ReviewEditing(selectedItem, rating, comment)`, `ReviewSubmitting`, `ReviewSubmitted(review)`, `ReviewError(Failure)`.

---

## Widget Reuse Assessment (DRY Enforcement)

| Widget / Component | Reuse Decision | Source / Implementation |
| :--- | :--- | :--- |
| **Bottom Navigation Bar** | Existing widget found: `CustomBottomNavBar` — reusing it. | Reused in `ShellRoute` / Page scaffold (Profile Tab active). |
| **PrimaryButton** | Existing widget found: `PrimaryButton` — reusing it. | `lib/shared/widgets/primary_button.dart` (for Review, Chat Now, Send Review). |
| **Rating Stars** | Existing widget found: star rating pattern in `features/product` — reusing it. | Reusing star rating pattern from `lib/features/product/presentation/widgets/review_card.dart` / extracting clean reusable star rating widget. |
| **MetaPill** | Existing widget found: `MetaPill` — reusing it. | `lib/shared/widgets/meta_pill.dart` (for "3 items", "Standard Delivery", date pills). |
| **Modal Pattern** | Existing pattern found: `showModalBottomSheet` with `24.r` radius and backdrop blur — reusing it. | Follows pattern from `PaymentMethodSheet`, `VoucherBottomSheet`, and `EditShippingAddressSheet`. |
| **Empty State** | Existing widget found: `NoDataFoundWidget` — reusing it. | `lib/shared/widgets/no_data_found_widget.dart`. |
| **OrdersHeader** | No existing widget found — creating new: `OrdersHeader`. | Dedicated header with avatar, title, subtitle, and 3 action icons. |
| **OrdersTabs** | No existing widget found — creating new: `OrdersTabs`. | Filter tabs row for To Pay, To Receive, To Review. |
| **OrderCard** | No existing widget found — creating new: `OrderCard`. | Order card with thumbnail previews, pills, status label, and action button. |
| **OrderTrackingTimeline** | No existing widget found — creating new: `OrderTrackingTimeline`. | Vertical milestone timeline component. |
| **TrackingStepTile** | No existing widget found — creating new: `TrackingStepTile`. | Individual step in vertical timeline with circular badge and line. |
| **ReviewOptionSheet** | No existing widget found — creating new: `ReviewOptionSheet`. | Modal bottom sheet to pick which item to review (Screen 58). |
| **DeliveryFailedSheet** | No existing widget found — creating new: `DeliveryFailedSheet`. | Modal bottom sheet explaining failed delivery (Screen 60). |
| **ReviewSheet** | No existing widget found — creating new: `ReviewSheet`. | Modal bottom sheet to author rating & comments (Screen 66). |
| **ReviewDoneDialog** | No existing widget found — creating new: `ReviewDoneDialog`. | Centered confirmation dialog for successful review (Screen 67). |
| **HistoryItemTile** | No existing widget found — creating new: `HistoryItemTile`. | Order history list item tile (Screen 65). |

---

## Permanent Project Rules Reference

All features MUST strictly comply with the Permanent Project Rules defined in `.specify/instructions/permanent-project-rules.md` and Constitution v1.2.0:
1. **Verification Timing**: Do NOT run `fvm flutter analyze` or `fvm flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PrimaryButton, MetaPill, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
11. **STRICT COLOR & TOKEN ENFORCEMENT**: All colors, spacing, and typography must reference tokens from `AppColors`, `AppSpacing`, and `AppTypography`. No hardcoded values are allowed. If a token is missing, add it to the tokens file first.
12. **FVM-ONLY CLI COMMANDS**: ALWAYS use `fvm flutter` (NOT bare `flutter`) for ALL Flutter CLI commands (`analyze`, `test`, `run`, `build`, `pub get`, etc.). The project uses FVM with Flutter 3.44.6. The global Flutter (3.24.5) has incompatible API differences. Using bare `flutter` causes type mismatch errors and reverts fixes.
