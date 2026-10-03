# Implementation Plan: Orders Management, Tracking & Reviews

**Branch**: `012-orders` | **Date**: 2026-10-03 | **Spec**: [specs/012-orders/spec.md](spec.md)

**Input**: Feature specification from `specs/012-orders/spec.md` covering Screens 57, 58, 59, 60, 61, 63, 65, 66, 67.

---

## Summary

The Orders feature encompasses:
1. **Orders List (Screen 57)**: Filterable orders view with tabs ("To Pay", "To Receive", "To Review"), multi-item card previews with status badges, and dynamic actions (`Track` for packed/shipped vs `Review` for delivered).
2. **Order Tracking Timeline (Screens 59, 61, 63)**: Unified tracking screen displaying order summary and a 5-milestone vertical timeline reflecting in-progress fulfillment, full delivery completion, or failed delivery attempts.
3. **Delivery Failed Modal (Screen 60)**: Bottom sheet modal opened from failed delivery tracking steps offering customer care guidance and a `Chat Now` CTA.
4. **Order History (Screen 65)**: Historical order list displaying past purchases with date pills and direct review triggers.
5. **Review Authoring & Confirmation Flow (Screens 58, 66, 67)**: Item picker modal for multi-item orders, 5-star interactive rating and text review sheet, and centered "Done!" confirmation dialog.

The implementation strictly follows Feature-First Clean Architecture, the project Constitution, Rule #11 (Strict Design Tokens), Rule #12 (FVM-Only CLI), and DRY component reuse.

---

## Technical Context

**Language/Version**: Dart 3.5.4 (Flutter 3.44.6 via FVM)  
**Primary Dependencies**: `flutter_bloc`, `go_router`, `flutter_screenutil`, `get_it`, `dartz`, `equatable`, `shimmer`  
**Storage**: In-memory mock data source (`OrdersMockDataSourceImpl`)  
**Testing**: `flutter_test` (unit & widget tests in `test/features/orders/`)  
**Target Platform**: Android, iOS  
**Project Type**: Mobile Application Feature Module  
**Performance Goals**: Instant tab switching (< 100ms), 60 fps smooth timeline scrolling and modal presentations  
**Constraints**: Zero hardcoded colors/dimensions (Rule #11), FVM CLI only (Rule #12), no analysis/testing until final phase (Rule #1)  
**Scale/Scope**: 9 design reference screens, 3 Cubits, 5 UseCases, 1 standalone feature module  

---

## Constitution & Rule Compliance Check

| Rule | Requirement | Compliance Plan |
|---|---|---|
| Rule 1 | Verification Timing | No `analyze` or `test` runs until the final phase of implementation |
| Rule 2 | Asset Policy | Reuse existing images in `assets/images/` and design references; no new asset generation |
| Rule 3 | Architectural Adherence | Feature-First Clean Architecture (`domain/`, `data/`, `presentation/`, `di/`) |
| Rule 4 | Code Quality & Design Patterns | UseCases with `Either<Failure, T>`, `safeCall` in repository, Cubits with `Equatable` states |
| Rule 5 | Dimensions & Frameworks | ScreenUtil (`.w`, `.h`, `.r`, `.sp`), `go_router` for navigation, `flutter_bloc` |
| Rule 6 | Component Reuse (DRY) | Reuse `CustomBottomNavBar`, `PrimaryButton`, `MetaPill`, `NoDataFoundWidget`, rating stars pattern |
| Rule 7 | Clean Architecture Layers | Complete Domain, Data, Presentation layers with DI registration |
| Rule 8 | Phase 1 Data Scope | Mock data source with 5+ orders, 3+ tracking steps, 2+ reviewable items |
| Rule 9 | Loading Experience | Shimmer placeholders for orders list and tracking timelines |
| Rule 10 | Visual Perfection | 1:1 match with Figma references (`57`, `58`, `59`, `60`, `61`, `63`, `65`, `66`, `67`) |
| Rule 11 | Strict Token Enforcement | 100% tokens from `AppColors`, `AppSpacing`, `AppTypography`. Add missing tokens to `app_colors.dart` FIRST |
| Rule 12 | FVM-Only CLI Commands | Always use `fvm flutter` for all verification and build commands |

---

## Component Reuse & DRY Strategy

### Existing Widgets to Reuse:
1. **`CustomBottomNavBar`**: Integrated into application shell; Profile tab (index 4) remains active.
2. **`PrimaryButton`** (`lib/shared/widgets/primary_button.dart`): Reused for:
   - `Track` action in `OrderCard`
   - `Chat Now` in `DeliveryFailedSheet`
   - `Send Review` in `ReviewSheet`
   - `Review` in `ReviewOptionSheet`
3. **Rating Stars**: Reusing star rating pattern from `lib/features/product/presentation/widgets/review_card.dart` (`Icons.star_rounded`, `AppColors.starGold`), extracted into an interactive 5-star selector widget.
4. **`MetaPill`** (`lib/shared/widgets/meta_pill.dart`): Reused for "3 items", "Standard Delivery", and date pills (e.g., `April, 06`).
5. **`NoDataFoundWidget`** (`lib/shared/widgets/no_data_found_widget.dart`): Reused for empty order tab views.
6. **Modal Bottom Sheet Pattern**: Reused `showModalBottomSheet` with `BorderRadius.vertical(top: Radius.circular(24.r))` and backdrop blur across Screens 58, 60, and 66.

### Justification for New Feature Widgets:
- **`OrdersHeader`**: No existing header includes user avatar + 2-line title/subtitle ("To Receive" / "My Orders") + 3 utility actions (message, filter, settings).
- **`OrdersTabs`**: Dedicated horizontal filter tabs for the 3 post-purchase order states ("To Pay", "To Receive", "To Review") with active pill highlight.
- **`OrderCard`**: Multi-thumbnail cluster with `+N` badge, delivery tier, item count pill, fulfillment status label, and dynamic action button (`Track` vs `Review`). Distinct from single-product rows.
- **`OrderTrackingTimeline`**: Vertical step-based fulfillment milestone visualizer with connected nodes. Net-new component.
- **`TrackingStepTile`**: Atomic milestone node in vertical timeline with circular status icon and vertical connecting divider line.
- **`ReviewOptionSheet`**: Multi-item picker modal for orders with multiple items to review (Screen 58).
- **`DeliveryFailedSheet`**: Operational support modal explaining delivery failure with hotline and `Chat Now` (Screen 60).
- **`ReviewSheet`**: Interactive post-purchase review authoring modal with 5 stars and text field (Screen 66).
- **`ReviewDoneDialog`**: Centered celebration confirmation dialog with blue checkmark badge, golden stars, and auto-dismiss timer (Screen 67).
- **`HistoryItemTile`**: Historical order list item with thumbnail, description, order number, date pill, and outlined `Review` button (Screen 65). `ProductItemRow` is not reused here because it mandates price, delete button, and cart controls which are absent in order history.

---

## Project Structure & Planned Files

```text
lib/
├── core/
│   └── theme/
│       └── app_colors.dart                     [MODIFY: Add statusPacked, statusShipped, statusDelivered, statusFailed, starGold, timelineLine]
│
├── config/
│   └── routing/
│       ├── route_names.dart                    [MODIFY: Add kOrdersPage, kOrderHistoryPage, kOrderTrackingPage]
│       └── app_router.dart                     [MODIFY: Register orders routes under Profile shell]
│
└── features/
    └── orders/
        ├── orders_injection.dart               [CREATE: Feature DI container]
        │
        ├── domain/
        │   ├── entities/
        │   │   ├── order_entity.dart           [CREATE: Order entity, OrderStatus, OrderTab]
        │   │   ├── order_item_entity.dart      [CREATE: Order line item entity]
        │   │   ├── tracking_step_entity.dart   [CREATE: Tracking milestone step entity]
        │   │   └── order_review_entity.dart    [CREATE: Submitted review entity]
        │   ├── repositories/
        │   │   └── orders_repository.dart      [CREATE: Repository contract]
        │   └── usecases/
        │       ├── get_orders_usecase.dart     [CREATE: Fetch orders by tab]
        │       ├── get_order_history_usecase.dart [CREATE: Fetch past orders]
        │       ├── get_order_tracking_usecase.dart [CREATE: Fetch order tracking]
        │       ├── get_items_to_review_usecase.dart [CREATE: Fetch reviewable items]
        │       └── submit_review_usecase.dart  [CREATE: Submit review]
        │
        ├── data/
        │   ├── models/
        │   │   ├── order_model.dart            [CREATE: Order data model]
        │   │   ├── order_item_model.dart       [CREATE: Order item model]
        │   │   ├── tracking_step_model.dart    [CREATE: Tracking step model]
        │   │   └── order_review_model.dart     [CREATE: Order review model]
        │   ├── datasources/
        │   │   ├── orders_mock_datasource.dart [CREATE: Data source contract]
        │   │   └── orders_mock_datasource_impl.dart [CREATE: Mock implementation (5+ orders, steps, review items)]
        │   └── repositories/
        │       └── orders_repository_impl.dart [CREATE: Repository implementation with safeCall]
        │
        └── presentation/
            ├── cubit/
            │   ├── orders_cubit.dart & orders_state.dart [CREATE: Orders list & history state management]
            │   ├── order_tracking_cubit.dart & order_tracking_state.dart [CREATE: Tracking timeline state management]
            │   └── order_review_cubit.dart & order_review_state.dart [CREATE: Review flow state management]
            ├── pages/
            │   ├── orders_page.dart            [CREATE: Screen 57 Orders list with tabs]
            │   ├── order_tracking_page.dart    [CREATE: Screens 59, 61, 63 unified timeline page]
            │   └── order_history_page.dart     [CREATE: Screen 65 Order history page]
            └── widgets/
                ├── orders_header.dart          [CREATE: Avatar + Title + 3 action icons]
                ├── orders_tabs.dart            [CREATE: To Pay / To Receive / To Review tabs]
                ├── order_card.dart             [CREATE: Order card with thumbnails, status, action button]
                ├── order_tracking_timeline.dart [CREATE: Vertical timeline widget]
                ├── tracking_step_tile.dart     [CREATE: Atomic milestone row with icon & line]
                ├── review_option_sheet.dart    [CREATE: Screen 58 modal bottom sheet]
                ├── delivery_failed_sheet.dart  [CREATE: Screen 60 modal bottom sheet]
                ├── review_sheet.dart           [CREATE: Screen 66 modal bottom sheet with 5 stars]
                ├── review_done_dialog.dart     [CREATE: Screen 67 centered confirmation dialog]
                ├── history_item_tile.dart      [CREATE: Screen 65 historical order tile]
                └── orders_shimmer_loading.dart [CREATE: Shimmer loading placeholder]
```

---

## Detailed Implementation Breakdown

### Phase 1: Design Tokens & Routing Setup
1. **Add Tokens to `AppColors`**:
   - `statusPacked = Color(0xFFFFAE00)`
   - `statusShipped = Color(0xFF004BFE)`
   - `statusDelivered = Color(0xFF34C759)`
   - `statusFailed = Color(0xFFFF3B30)`
   - `starGold = Color(0xFFFFAE00)`
   - `timelineLine = Color(0xFFE5E7EB)`
2. **Update Routing**:
   - Add routes in `route_names.dart`: `kOrdersPage = '/orders'`, `kOrderHistoryPage = '/orders/history'`, `kOrderTrackingPage = '/orders/:id/tracking'`.
   - Register routes in `app_router.dart` inside the `Profile` shell branch.

### Phase 2: Domain Layer
1. Create entities (`OrderEntity`, `OrderItemEntity`, `TrackingStepEntity`, `OrderReviewEntity`, `OrderStatus`, `OrderTab`).
2. Create repository contract `OrdersRepository`.
3. Create 5 UseCases (`GetOrdersUseCase`, `GetOrderHistoryUseCase`, `GetOrderTrackingUseCase`, `GetItemsToReviewUseCase`, `SubmitReviewUseCase`).

### Phase 3: Data Layer
1. Create models (`OrderModel`, `OrderItemModel`, `TrackingStepModel`, `OrderReviewModel`) with JSON serialization and entity conversions.
2. Implement `OrdersMockDataSource` and `OrdersMockDataSourceImpl` with:
   - 5+ orders representing all statuses (`packed`, `shipped`, `delivered`, `failedAttempt`, `toPay`).
   - Detailed milestone steps for each tracking flow (normal in-progress, completed, failed attempt).
   - Reviewable items.
3. Implement `OrdersRepositoryImpl` wrapping data calls with `safeCall`.

### Phase 4: Dependency Injection
1. Create `orders_injection.dart` registering mock data source, repository, 5 use cases, and 3 cubits.
2. Register `initOrdersInjection()` into `injection_container.dart`.

### Phase 5: Presentation Layer — Orders List & History (Screens 57, 65)
1. Implement `OrdersCubit` and `OrdersState`.
2. Build `OrdersHeader` (avatar, title, subtitle, 3 utility icons).
3. Build `OrdersTabs` (To Pay, To Receive, To Review).
4. Build `OrderCard` with thumbnail cluster (+N overflow badge), `MetaPill` badges, status labels, and `Track` / `Review` actions.
5. Build `HistoryItemTile` for Screen 65.
6. Build `OrdersShimmerLoading`.
7. Assemble `OrdersPage` (Screen 57) and `OrderHistoryPage` (Screen 65).

### Phase 6: Presentation Layer — Order Tracking (Screens 59, 61, 63)
1. Implement `OrderTrackingCubit` and `OrderTrackingState`.
2. Build `TrackingStepTile` with status icons, vertical connector line, and `Learn more` button in failure state.
3. Build `OrderTrackingTimeline` assembling steps.
4. Build `DeliveryFailedSheet` (Screen 60) with customer support details and `Chat Now`.
5. Assemble `OrderTrackingPage` displaying order summary card and vertical timeline, switching between normal progress, delivered, and failed attempt based on cubit state.

### Phase 7: Presentation Layer — Review Flow (Screens 58, 66, 67)
1. Implement `OrderReviewCubit` and `OrderReviewState`.
2. Build `ReviewOptionSheet` (Screen 58) displaying reviewable items in a modal bottom sheet.
3. Build `ReviewSheet` (Screen 66) with interactive 5-star rating selector, multiline comment input, and `Send Review` button.
4. Build `ReviewDoneDialog` (Screen 67) displaying blue checkmark badge, 5 golden stars, and auto-dismiss timer.

### Phase 8: Verification & Testing (Final Phase Only)
1. Write widget tests for Orders list, Tracking timeline, and Review modals in `test/features/orders/`.
2. Run `dart format --output=none --set-exit-if-changed lib test`.
3. Run `fvm flutter analyze` (must be 0 issues).
4. Run `fvm flutter test` (all tests green).
