# Research & Technical Decisions: Orders Feature

**Feature Directory**: `specs/012-orders`  
**Date**: 2026-10-03  
**Status**: Completed  

---

## 1. Unification of Screens 59, 61, and 63

### Decision
Screens 59 (Tracking in Progress), 61 (Delivery Attempt Failed), and 63 (Delivery Complete) will be unified into a single page widget: `OrderTrackingPage` located at `lib/features/orders/presentation/pages/order_tracking_page.dart`, driven by `OrderTrackingCubit`.

### Rationale
- **Identical Visual Shell**: All three screens share the exact same top header (avatar, "To Receive", "My Orders"), the same order summary card (3 thumbnail previews, order number, delivery tier, item count pill, repeated order ID, and LGS tracking number with copy action), and the same vertical timeline layout.
- **State-Driven Differences Only**:
  - Screen 59 represents normal progress where completed steps (e.g., Packed, On the Way) are blue with timestamps, while remaining steps (Arrived, Shipped, Delivered) are neutral gray.
  - Screen 63 represents full fulfillment where all 5 steps are blue with completion timestamps.
  - Screen 61 appends a failure milestone at the end with a red status badge ("Attempt to deliver your parcel was not successful") and a `Learn more` action button.
- **Maintainability**: Unifying into a single page prevents triplicating identical UI scaffolding, tracking header components, and route definitions.

### Alternatives Considered
- *Three distinct pages (`OrderTrackingInProgressPage`, `OrderTrackingFailedPage`, `OrderTrackingDeliveredPage`)*: Rejected due to >85% code duplication, violating the DRY principle and bloating the bundle.

---

## 2. Cubit Partitioning & State Management Strategy

### Decision
Three distinct, focused Cubits inside `lib/features/orders/presentation/cubit/`:
1. **`OrdersCubit`**:
   - Scope: Screens 57 (Orders list) and 65 (Order History).
   - Responsibilities: Tab switching (`toPay`, `toReceive`, `toReview`), loading active orders, fetching past order history.
   - States: `OrdersInitial`, `OrdersLoading`, `OrdersLoaded`, `OrdersError`.
2. **`OrderTrackingCubit`**:
   - Scope: Screens 59, 61, 63 (Shipment timeline).
   - Responsibilities: Fetching order tracking details by `orderId`, tracking milestones, handling delivery failure states, triggering `DeliveryFailedSheet`.
   - States: `TrackingInitial`, `TrackingLoading`, `TrackingLoaded`, `TrackingError`.
3. **`OrderReviewCubit`**:
   - Scope: Screens 58 (Item selection modal), 66 (Review authoring sheet), 67 (Confirmation dialog).
   - Responsibilities: Loading multi-item order line items, tracking selected item to review, managing rating (1–5) and comment text input, executing `submitReview()`, and triggering `ReviewDoneDialog`.
   - States: `ReviewInitial`, `ReviewItemsLoaded`, `ReviewEditing`, `ReviewSubmitting`, `ReviewSubmitted`, `ReviewError`.

### Rationale
- **Single Responsibility Principle**: Separates list navigation, tracking timeline updates, and form authoring into distinct lifecycles.
- **Predictable Modals**: Modals for reviews and delivery failures can listen to dedicated state streams without re-triggering parent order lists.
- **Equatability**: All states extend `Equatable` to ensure zero redundant rebuilds.

---

## 3. Timeline Architecture: `OrderTrackingTimeline` & `TrackingStepTile`

### Decision
A clean, modular vertical timeline component consisting of:
- `OrderTrackingTimeline`: Renders a `ListView.separated` or `Column` of milestones.
- `TrackingStepTile`: An atomic row displaying:
  - Left column: Circular status indicator (28.r) with icon (`Icons.inventory_2_outlined`, `Icons.local_shipping_outlined`, `Icons.error_outline_rounded`, etc.) and a vertical connecting divider (`timelineLine`).
  - Right column: Milestone title (`AppTypography.bodyMedium`), timestamp (`AppTypography.caption`), and optional actions (e.g., `Learn more` button in `statusFailed` mode).

### Rationale
- Decouples milestone rendering logic from order data structures.
- Allows rendering 3, 5, or 6 steps dynamically depending on tracking history.
- Guarantees pixel-perfect connecting line alignment across all device screen densities using `flutter_screenutil`.

---

## 4. Review Flow Modal Lifecycle (Screens 58 → 66 → 67)

### Decision
- **Screen 58 (`ReviewOptionSheet`)**: Triggered via `ReviewOptionSheet.show(context, orderId: orderId)`. Uses standard modal bottom sheet with `BorderRadius.vertical(top: Radius.circular(24.r))` and backdrop blur.
- **Screen 66 (`ReviewSheet`)**: When user taps `Review` on an item in Screen 58, Screen 58 closes and `ReviewSheet.show(context, item: item)` opens with 24.r radius, interactive 5-star rating selector, and multiline text field.
- **Screen 67 (`ReviewDoneDialog`)**: On review submission success, `ReviewSheet` closes and `ReviewDoneDialog.show(context)` displays a centered dialog with white card surface, blue checkmark badge, 5 golden stars, and auto-dismisses after 2.5 seconds (or upon tap).

### Rationale
- Matches existing modal bottom sheet architecture established in `PaymentMethodSheet`, `VoucherBottomSheet`, and `EditShippingAddressSheet`.
- Provides a frictionless 3-step review experience with instant visual feedback.

---

## 5. DRY Widget Reuse Assessment & Justifications

### Mandatory Reusable Widgets Confirmed:
1. **`CustomBottomNavBar`**: Reused directly via application `ShellRoute` (Profile Tab index 4 active).
2. **`PrimaryButton`** (`lib/shared/widgets/primary_button.dart`): Reused for:
   - `Track` action in `OrderCard`
   - `Chat Now` in `DeliveryFailedSheet`
   - `Send Review` in `ReviewSheet`
   - `Review` in `ReviewOptionSheet`
3. **Rating Stars**: Reused rating star visual pattern from `features/product/presentation/widgets/review_card.dart` (`Icons.star_rounded`, `Color(0xFFFFAE00)`), extracted into a clean tappable rating selector component.
4. **`MetaPill`** (`lib/shared/widgets/meta_pill.dart`): Reused for "3 items", "Standard Delivery", and date pills (e.g., `April, 06`).
5. **`NoDataFoundWidget`** (`lib/shared/widgets/no_data_found_widget.dart`): Reused for empty order tab states.
6. **Modal Bottom Sheet Pattern**: Reused `showModalBottomSheet` with `BorderRadius.vertical(top: Radius.circular(24.r))` and backdrop blur.

### Justification for New Feature Widgets:
| Widget | Reason Existing Widgets Cannot Be Reused | Reused Constituent Elements |
| :--- | :--- | :--- |
| **`OrdersHeader`** | No existing header has user avatar + 2-line title/subtitle ("To Receive" / "My Orders") + 3 utility icon actions (message, filter, settings). | Uses `AppColors`, `AppTypography`. |
| **`OrdersTabs`** | Specific 3-state horizontal order filter tabs ("To Pay", "To Receive", "To Review") with active pill highlight. `RecentlyViewedDateTabs` is date-specific with a calendar chevron toggle. | Reuses design token styling and pill shape. |
| **`OrderCard`** | Needs multi-thumbnail cluster (2–3 thumbnails with `+N` badge), delivery tier, item count pill, fulfillment status label, and dynamic action button (`Track` vs `Review`). `ProductItemRow` is designed for single-product rows with delete/quantity. | Reuses `MetaPill` and `PrimaryButton`. |
| **`OrderTrackingTimeline`** | Vertical order fulfillment timeline with connected milestone nodes does not exist anywhere in the codebase. | New specialized visual component. |
| **`TrackingStepTile`** | Atomic node in the vertical timeline with status icon circle and vertical connector line. | New atomic milestone component. |
| **`ReviewOptionSheet`** | Multi-item selector modal for orders with multiple items to review. | Reuses modal bottom sheet pattern, `MetaPill`, and `PrimaryButton`. |
| **`DeliveryFailedSheet`** | Customer support modal with failure explanation and `Chat Now` button. | Reuses modal bottom sheet pattern and `PrimaryButton`. |
| **`ReviewSheet`** | Interactive review modal with 5-star rating selector and comment field. | Reuses modal bottom sheet pattern, star rating pattern, and `PrimaryButton`. |
| **`ReviewDoneDialog`** | Centered celebration dialog with auto-dismiss timer, blue checkmark, and golden star row. | Reuses dialog pattern and star rating pattern. |
| **`HistoryItemTile`** | Historical order row displaying thumbnail, description, order number, date pill, and outlined `Review` button. Distinct from `ProductItemRow` which requires price, delete icon, and cart controls. | Reuses `MetaPill` and outline button pattern. |

---

## 6. Design Tokens & Rule #11 Compliance

### New Color Tokens to Add to `lib/core/theme/app_colors.dart` (Task 1):
```dart
  // ─────────────────────────────────────────────
  // Orders & Shipment Status Colors (Screens 57–67)
  // ─────────────────────────────────────────────
  /// Amber/Orange status color for Packed milestone (Screen 57, 59)
  static const Color statusPacked = Color(0xFFFFAE00);

  /// Primary blue status color for Shipped milestone (Screen 57, 59)
  static const Color statusShipped = Color(0xFF004BFE);

  /// Green status color for Delivered milestone (Screen 57, 63)
  static const Color statusDelivered = Color(0xFF34C759);

  /// Alert red color for failed delivery attempt milestone (Screen 60, 61)
  static const Color statusFailed = Color(0xFFFF3B30);

  /// Golden yellow color for interactive and displayed rating stars (Screen 66, 67)
  static const Color starGold = Color(0xFFFFAE00);

  /// Neutral gray vertical timeline connecting line (Screen 59, 61, 63)
  static const Color timelineLine = Color(0xFFE5E7EB);
```
These tokens guarantee 100% Rule #11 compliance with zero hardcoded color literals across all widgets and pages.
