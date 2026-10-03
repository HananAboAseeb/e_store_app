# Tasks: Orders Management, Tracking & Reviews

**Input**: Design documents from `specs/012-orders/` (`spec.md`, `plan.md`, `data-model.md`, `contracts/orders_repository_contract.md`, `research.md`, `quickstart.md`)  
**Prerequisites**: All permanent project rules in `.specify/instructions/permanent-project-rules.md` and Constitution v1.2.0  
**Verification Timing**: No `fvm flutter analyze` or `fvm flutter test` until Phase 8 (final phase only)  

---

## Phase 1: Setup & Token Scaffolding (Shared Infrastructure)

**Purpose**: Establish feature directory layout and register mandatory status and rating tokens in `AppColors` before any UI implementation begins.

- [X] T001 Add 6 status and rating tokens (`statusPacked`, `statusShipped`, `statusDelivered`, `statusFailed`, `starGold`, `timelineLine`) to `lib/core/theme/app_colors.dart` FIRST.
- [X] T002 [P] Create feature directory structure under `lib/features/orders/{data,domain,presentation}` per implementation plan.

---

## Phase 2: Foundational (Domain, Data, DI & Routing)

**Purpose**: Core Clean Architecture contracts, entities, use cases, mock data sources, DI container, and navigation routing.

- [X] T003 [P] Create `OrderEntity`, `OrderItemEntity`, `TrackingStepEntity`, `OrderReviewEntity`, and enums (`OrderStatus`, `OrderTab`) in `lib/features/orders/domain/entities/order_entity.dart`.
- [X] T004 [P] Define `OrdersRepository` contract in `lib/features/orders/domain/repositories/orders_repository.dart`.
- [X] T005 [P] Implement `GetOrdersUseCase`, `GetOrderHistoryUseCase`, `GetOrderTrackingUseCase`, `GetItemsToReviewUseCase`, and `SubmitReviewUseCase` in `lib/features/orders/domain/usecases/`.
- [X] T006 [P] Implement data models (`OrderModel`, `OrderItemModel`, `TrackingStepModel`, `OrderReviewModel`) in `lib/features/orders/data/models/`.
- [X] T007 Implement `OrdersMockDataSource` and `OrdersMockDataSourceImpl` in `lib/features/orders/data/datasources/orders_mock_datasource.dart` and `lib/features/orders/data/datasources/orders_mock_datasource_impl.dart` (5+ orders covering all statuses, 3+ tracking steps, 2+ review items).
- [X] T008 Implement `OrdersRepositoryImpl` in `lib/features/orders/data/repositories/orders_repository_impl.dart` wrapping data source calls with `safeCall`.
- [X] T009 [P] Register route constants (`kOrdersPage`, `kOrderHistoryPage`, `kOrderTrackingPage`) in `lib/config/routing/route_names.dart` and register routes in `lib/config/routing/app_router.dart` inside the Profile shell branch.
- [X] T010 Create `lib/features/orders/orders_injection.dart` and register `initOrdersInjection()` in `lib/core/di/injection_container.dart`.

**Checkpoint**: Foundation complete — data contracts, mock data, and DI bindings ready for presentation layer.

---

## Phase 3: User Story 1 (P1) — Orders List with Tabs (Screen 57) 🎯 MVP

**Goal**: Display active orders categorized by tabs ("To Pay", "To Receive", "To Review") with product thumbnail previews, status pills, and action buttons (`Track` / `Review`).  
**Independent Test**: Navigate to `/orders`; verify top header with avatar and action icons, switch tabs, confirm `OrderCard` renders thumbnail cluster (+N badge), order number, delivery tier, `MetaPill` count, and status badges with `Track` or `Review` buttons.

- [X] T011 [US1] Implement `OrdersCubit` and `OrdersState` in `lib/features/orders/presentation/cubit/orders_cubit.dart` and `lib/features/orders/presentation/cubit/orders_state.dart` (with `loadOrders` and `selectTab` filtering).
- [X] T012 [P] [US1] Implement `OrdersHeader` in `lib/features/orders/presentation/widgets/orders_header.dart` (user avatar, title "To Receive", subtitle "My Orders", and 3 utility icons: message, filter, settings).
- [X] T013 [P] [US1] Implement `OrdersTabs` in `lib/features/orders/presentation/widgets/orders_tabs.dart` (filter tabs row for "To Pay", "To Receive", "To Review" with active pill indicator).
- [X] T014 [P] [US1] Implement `OrderCard` in `lib/features/orders/presentation/widgets/order_card.dart` (thumbnail preview cluster with `+N` badge, order ID, "Standard Delivery", `MetaPill` count, status label, and `Track` / `Review` actions using `PrimaryButton`).
- [X] T015 [P] [US1] Implement `OrdersShimmerLoading` in `lib/features/orders/presentation/widgets/orders_shimmer_loading.dart`.
- [X] T016 [US1] Assemble `OrdersPage` in `lib/features/orders/presentation/pages/orders_page.dart` with `OrdersCubit`, empty state via `NoDataFoundWidget`, and navigation triggers.

**Checkpoint**: User Story 1 functional — users can view, filter, and inspect orders with status indicators.

---

## Phase 4: User Story 2 (P2) — Order Tracking Timeline (Screens 59, 61, 63)

**Goal**: Vertical fulfillment milestone timeline showing order progress from Packed to Delivered or Failed Attempt.  
**Independent Test**: Navigate to `/orders/:id/tracking` for an in-progress order (`order-1`), verify blue milestones 1-2 and gray milestones 3-5 (Screen 59); navigate to delivered order (`order-4`), verify all 5 milestones blue (Screen 63); navigate to failed order (`order-3`), verify red milestone with `Learn more` button (Screen 61).

- [X] T017 [US2] Implement `OrderTrackingCubit` and `OrderTrackingState` in `lib/features/orders/presentation/cubit/order_tracking_cubit.dart` and `lib/features/orders/presentation/cubit/order_tracking_state.dart` (loading milestones, tracking steps, handling `hasFailedAttempt` and `isDelivered`).
- [X] T018 [P] [US2] Implement `TrackingStepTile` in `lib/features/orders/presentation/widgets/tracking_step_tile.dart` (circular milestone badge, vertical connector line via `AppColors.timelineLine`, title, timestamp, and optional `Learn more` action).
- [X] T019 [P] [US2] Implement `OrderTrackingTimeline` in `lib/features/orders/presentation/widgets/order_tracking_timeline.dart` (connected vertical milestone sequence adapting dynamically).
- [X] T020 [US2] Assemble unified `OrderTrackingPage` in `lib/features/orders/presentation/pages/order_tracking_page.dart` displaying order summary card with copy action, dynamic vertical timeline for Screens 59, 61, 63, and back navigation.

**Checkpoint**: User Story 2 functional — shipment tracking with dynamic milestones and failure alerts operating cleanly in a unified view.

---

## Phase 5: User Story 3 (P3) — Review Flow (Screens 58, 66, 67)

**Goal**: End-to-end review lifecycle: select item from multi-item order, author review with interactive 5 stars and comments, and celebrate with confirmation dialog.  
**Independent Test**: Tap `Review` on a delivered order to open Screen 58 modal; select an item to open Screen 66 review modal; tap 4th star and enter text; tap `Send Review` to display Screen 67 centered confirmation dialog with auto-dismiss.

- [X] T021 [US3] Implement `OrderReviewCubit` and `OrderReviewState` in `lib/features/orders/presentation/cubit/order_review_cubit.dart` and `lib/features/orders/presentation/cubit/order_review_state.dart` (loading items, setting rating, updating comment, submitting review).
- [X] T022 [P] [US3] Implement `ReviewOptionSheet` in `lib/features/orders/presentation/widgets/review_option_sheet.dart` (Screen 58 modal bottom sheet, 24.r radius, list of reviewable items with `MetaPill` date, and `Review` button).
- [X] T023 [P] [US3] Implement `ReviewSheet` in `lib/features/orders/presentation/widgets/review_sheet.dart` (Screen 66 modal bottom sheet, 24.r radius, user avatar, product info, interactive 5-star rating using `AppColors.starGold`, multiline comment field, and `Send Review` button via `PrimaryButton`).
- [X] T024 [P] [US3] Implement `ReviewDoneDialog` in `lib/features/orders/presentation/widgets/review_done_dialog.dart` (Screen 67 centered confirmation dialog with blue checkmark badge, 5 golden stars, auto-dismiss timer).
- [X] T025 [US3] Connect review flow interactions between `OrdersPage` (Screen 57), `ReviewOptionSheet` (Screen 58), `ReviewSheet` (Screen 66), and `ReviewDoneDialog` (Screen 67).

**Checkpoint**: User Story 3 functional — multi-item item selection, rating authoring, and visual confirmation complete.

---

## Phase 6: User Story 4 (P4) — Delivery Failed Resolution (Screen 60)

**Goal**: Modal bottom sheet communicating delivery failure with hotline and customer care chat access.  
**Independent Test**: Tap `Learn more` on failed delivery milestone (Screen 61); verify Screen 60 modal opens with customer care hotline `+00 000 000 000` and tapping `Chat Now` shows feedback.

- [X] T026 [US4] Implement `DeliveryFailedSheet` in `lib/features/orders/presentation/widgets/delivery_failed_sheet.dart` (Screen 60 modal bottom sheet, 24.r radius, explanation text, customer care contact `+00 000 000 000`, `✕` close, and `Chat Now` button via `PrimaryButton`).
- [X] T027 [US4] Wire `Learn more` action on the failed milestone in `OrderTrackingPage` / `TrackingStepTile` to trigger `DeliveryFailedSheet.show(context)` with feedback on `Chat Now`.

**Checkpoint**: User Story 4 functional — customer support gateway accessible upon delivery failure.

---

## Phase 7: User Story 5 (P5) — Order History (Screen 65)

**Goal**: Dedicated history screen displaying completed past purchases with direct review triggers.  
**Independent Test**: Navigate to `/orders/history`; verify top header ("History"), list of past orders with product image, description, order number, date pill (`MetaPill`), and outlined `Review` buttons launching Screen 58 or 66.

- [X] T028 [P] [US5] Implement `HistoryItemTile` in `lib/features/orders/presentation/widgets/history_item_tile.dart` (Screen 65 completed order card with product thumbnail, 2-line description, order ID, date pill via `MetaPill`, and outlined `Review` button).
- [X] T029 [US5] Assemble `OrderHistoryPage` in `lib/features/orders/presentation/pages/order_history_page.dart` using `OrdersCubit.loadHistory()`, `OrdersHeader` (title "History"), `HistoryItemTile` list, empty state via `NoDataFoundWidget`, and review triggers.

**Checkpoint**: User Story 5 functional — past purchase history and review triggers accessible.

---

## Phase 8: Polish, Verification & Quality Assurance (Run Once at End)

**Purpose**: Format code, run static analysis, and verify all unit/widget tests passing 100% green.

- [X] T030 [P] Write comprehensive widget and cubit tests in `test/features/orders/presentation/orders_page_test.dart` and `test/features/orders/presentation/order_tracking_page_test.dart`.
- [X] T031 Run `dart format --output=none --set-exit-if-changed lib test` to ensure clean code formatting.
- [X] T032 Run `fvm flutter analyze` to verify 0 errors and 0 warnings.
- [X] T033 Run `fvm flutter test` to verify all tests pass with 100% green status.

---

## Dependencies & Execution Sequence

```
Phase 1 (Tokens: AppColors)
       │
       ▼
Phase 2 (Foundational: Domain, Data, DI, Routes)
       │
       ├──────────────────────────────┐
       ▼                              ▼
Phase 3 (US1: Orders List - Screen 57)  Phase 4 (US2: Tracking Timeline - Screens 59, 61, 63)
       │                              │
       ▼                              ▼
Phase 5 (US3: Review Flow - 58, 66, 67) Phase 6 (US4: Delivery Failed - Screen 60)
       │
       ▼
Phase 7 (US5: Order History - Screen 65)
       │
       ▼
Phase 8 (Verification & Tests - Final Phase)
```
