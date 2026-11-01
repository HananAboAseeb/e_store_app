# Tasks: User Profile, Activity Dashboard & Rewards Center

**Input**: Design documents from `specs/013-profile/` (`spec.md`, `plan.md`, `data-model.md`, `contracts/profile_repository_contract.md`, `research.md`, `quickstart.md`)  
**Prerequisites**: All permanent project rules in `.specify/instructions/permanent-project-rules.md` and Constitution v1.2.0  
**Verification Timing**: No `fvm flutter analyze` or `fvm flutter test` until Phase 7 (final phase only)  

---

## Phase 1: Setup & Token Scaffolding (Shared Infrastructure)

**Purpose**: Register all 11 new tokens in `AppColors` FIRST before any UI implementation begins, and establish clean directory structure.

- [X] T001 Add 11 new tokens (`rewardBackground`, `voucherWarning`, `voucherWarningBg`, `voucherValidDate`, `chartBlue`, `chartGreen`, `chartOrange`, `chartRed`, `storyLiveRed`, `rewardIconBlue`, `tabInactiveBg`) to `lib/core/theme/app_colors.dart` FIRST.
- [X] T002 [P] Establish directory structure for profile subpackages under `lib/features/profile/` per implementation plan.

---

## Phase 2: Foundational (Domain, Data, DI & Routing)

**Purpose**: Core Clean Architecture contracts, entities, use cases, mock data sources, DI container, and navigation routing.

- [X] T003 [P] Create domain entities (`UserProfileEntity`, `AnnouncementEntity`, `RecentlyViewedItemEntity`, `OrderStatsEntity`, `CategorySpendingEntity`, `ActivitySummaryEntity`, `VoucherEntity`, `RewardMilestoneEntity`, `StoryEntity`) and enums (`ProfileAnnouncementType`, `RewardsTab`) in `lib/features/profile/domain/entities/`.
- [X] T004 [P] Define `ProfileRepository` contract in `lib/features/profile/domain/repositories/profile_repository.dart`.
- [X] T005 [P] Implement 7 UseCases (`GetUserProfileUseCase`, `GetAnnouncementUseCase`, `GetRecentlyViewedUseCase`, `GetStoriesUseCase`, `GetActivitySummaryUseCase`, `GetVouchersUseCase`, `GetRewardsUseCase`) in `lib/features/profile/domain/usecases/`.
- [X] T006 [P] Implement 9 data models (`UserProfileModel`, `AnnouncementModel`, `RecentlyViewedItemModel`, `OrderStatsModel`, `CategorySpendingModel`, `ActivitySummaryModel`, `VoucherModel`, `RewardMilestoneModel`, `StoryModel`) in `lib/features/profile/data/models/`.
- [X] T007 Implement `ProfileMockDataSource` and `ProfileMockDataSourceImpl` in `lib/features/profile/data/datasources/profile_mock_data_source.dart` and `lib/features/profile/data/datasources/profile_mock_data_source_impl.dart` (1 user Romina, 3 announcement variants, 5 recently viewed products, 4 stories with live badge, 1 activity summary with April $365 / 4 categories / 12-7-5 orders, 3 vouchers with 1 expiring, 6 reward milestones).
- [X] T008 Implement `ProfileRepositoryImpl` in `lib/features/profile/data/repositories/profile_repository_impl.dart` wrapping mock data source calls with `safeCall`.
- [X] T009 [P] Register route constants (`kMyActivityPage`, `kRewardsPage`) in `lib/config/routing/route_names.dart` and register routes under Profile shell branch in `lib/config/routing/app_router.dart`.
- [X] T010 Register all 3 Cubits, 7 UseCases, Repository, and MockDataSource in `lib/features/profile/profile_injection.dart` and ensure hook in `lib/core/di/injection_container.dart`.

**Checkpoint**: Foundation complete — data contracts, mock data, and DI bindings ready for presentation layer.

---

## Phase 3: User Story 1 (P1) — Profile Home (Screens 62, 81, 85) 🎯 MVP

**Goal**: Deliver the unified Profile Home view featuring personalized greeting ("Hello, Romina!"), 3 announcement variations, recently viewed products carousel, post-purchase order status tabs with indicator dot, and creator stories with live badge.  
**Independent Test**: Navigate to `/profile`; verify user avatar, blue pill "My Activity" button, 3 circular utility buttons, greeting text, announcement card variations (`regular`, `rewardEarned`, `voucherExpiring`), horizontal recently viewed list navigating to `/product/:id`, "My Orders" tabs navigating to `/orders?tab=...`, and creator stories with red "Live" badge.

- [X] T011 [US1] Implement `ProfileCubit` and `ProfileState` in `lib/features/profile/presentation/manager/profile/profile_cubit.dart` and `lib/features/profile/presentation/manager/profile/profile_state.dart` (loading profile, announcement, recently viewed, stories, and `setAnnouncementType` switching).
- [X] T012 [P] [US1] Implement `ProfileHeader` in `lib/features/profile/presentation/widgets/profile_header.dart` (user avatar ~44x44, blue pill `My Activity` button navigating to `/profile/my-activity`, and 3 circular utility buttons: Scan `assets/images/icons/scan logo.png`, Menu `assets/images/icons/top menu logo.png`, Settings).
- [X] T013 [P] [US1] Implement `AnnouncementCard` in `lib/features/profile/presentation/widgets/announcement_card.dart` (supporting regular state with blue arrow button, rewardEarned with circular blue heart badge, and voucherExpiring with `AppColors.rewardBackground` soft pink fill and red shopping bag badge).
- [X] T014 [P] [US1] Implement `RecentlyViewedHorizontalList` in `lib/features/profile/presentation/widgets/recently_viewed_horizontal_list.dart` (horizontal scroll of 5 compact square cards reusing existing product images and navigating to `/product/:id`).
- [X] T015 [P] [US1] Implement `MyOrdersTabs` in `lib/features/profile/presentation/widgets/my_orders_tabs.dart` (row of 3 filter tabs using `MetaPill`: "To Pay", "To Recieve" with indicator dot [red in Screen 62, green in Screen 81/85], "To Review", navigating to `/orders?tab=<tab>`).
- [X] T016 [P] [US1] Implement `StoriesSection` in `lib/features/profile/presentation/widgets/stories_section.dart` (horizontal scroll of creator story cards with central play button overlay, and top-left red "Live" badge with `AppColors.storyLiveRed` on the first card).
- [X] T017 [P] [US1] Implement `ProfileShimmerLoading` in `lib/features/profile/presentation/widgets/profile_shimmer_loading.dart` for skeleton loading states.
- [X] T018 [US1] Overhaul and assemble `ProfilePage` in `lib/features/profile/presentation/pages/profile_page.dart` wiring `ProfileCubit`, header, greeting "Hello, Romina!", `AnnouncementCard`, `RecentlyViewedHorizontalList`, `MyOrdersTabs`, `StoriesSection`, and persistent `CustomBottomNavBar` (tab 4).

**Checkpoint**: User Story 1 complete and independently verifiable as the core MVP.

---

## Phase 4: User Story 2 (P2) — My Activity Dashboard (Screen 64)

**Goal**: Deliver financial activity dashboard displaying monthly expenditure, proportional 4-segment canvas-drawn donut chart with centered `$365,00` total, category legend pills, order statistics badges, and Order History navigation.  
**Independent Test**: Tap `My Activity` from Profile Home header or navigate to `/profile/my-activity`; verify top header with avatar and title "My Activity", month selector ("April") with `←` / `→` arrows, donut chart segment proportions (Blue 50.1%, Green 25.2%, Orange 12.9%, Red 11.8%), 4 category pills with matching colors, 3 circular order stat badges ("12 Ordered", "7 Recieved", "5 To Recieve"), and full-width `Order History` button navigating to `/orders/history`.

- [X] T019 [US2] Implement `MyActivityCubit` and `MyActivityState` in `lib/features/profile/presentation/manager/my_activity/my_activity_cubit.dart` and `lib/features/profile/presentation/manager/my_activity/my_activity_state.dart` (loading activity summary, handling month offset changes).
- [X] T020 [P] [US2] Implement `MonthSelector` in `lib/features/profile/presentation/widgets/month_selector.dart` (centered light gray pill displaying active month "April" with previous and next circular navigation arrows).
- [X] T021 [P] [US2] Implement `DonutChart` in `lib/features/profile/presentation/widgets/donut_chart.dart` (native `CustomPainter` with `canvas.drawArc` calculating exact proportional angles: Blue 50.1%, Green 25.2%, Orange 12.9%, Red 11.8%, with centered "Total" and bold amount `$365,00`).
- [X] T022 [P] [US2] Implement `CategoryLegendPills` in `lib/features/profile/presentation/widgets/category_legend_pills.dart` (2x2 grid formatting category spending pills using `MetaPill` with white text: "Clothing $183,00", "Lingerie $92,00", "Shoes $47,00", "Bags $43,00").
- [X] T023 [P] [US2] Implement `OrderStatsCircles` in `lib/features/profile/presentation/widgets/order_stats_circles.dart` (row of 3 circular blue stat badges: "12" with "Ordered", "7" with "Recieved", "5" with "To Recieve").
- [X] T024 [US2] Assemble `MyActivityPage` in `lib/features/profile/presentation/pages/my_activity_page.dart` combining top bar (avatar, title "My Activity", 3 circular utility buttons), `MonthSelector`, `DonutChart`, `CategoryLegendPills`, `OrderStatsCircles`, full-width `PrimaryButton` ("Order History" navigating to `/orders/history`), and persistent bottom nav.

**Checkpoint**: User Story 2 complete and independently verifiable.

---

## Phase 5: User Story 3 (P3) — Active Vouchers & Expiration Alert (Screens 82, 83)

**Goal**: Deliver active rewards list featuring ticket-shaped voucher cards with concave circular notches, dashed dividers, validity dates, discount details, and urgent red warning styling ("3 days left") for expiring vouchers.  
**Independent Test**: Navigate to `/profile/rewards`; verify "Active Rewards" tab is selected, inspect ticket voucher cards with blue outline and coral "Valid Until" dates (Screen 82), and verify first voucher card renders red border, soft pink fill, red dashed cut line, and bold red "3 days left" badge (Screen 83).

- [X] T025 [US3] Implement `RewardsCubit` and `RewardsState` in `lib/features/profile/presentation/manager/rewards/rewards_cubit.dart` and `lib/features/profile/presentation/manager/rewards/rewards_state.dart` (loading vouchers and rewards progress, switching active tab, handling voucher interactions).
- [X] T026 [P] [US3] Implement `RewardsTabs` in `lib/features/profile/presentation/widgets/rewards_tabs.dart` (side-by-side pill tabs for "Active Rewards" and "Progress" with active light blue highlight and `AppColors.tabInactiveBg` for inactive).
- [X] T027 [P] [US3] Implement `VoucherCard` in `lib/features/profile/presentation/widgets/voucher_card.dart` (ticket shape with rounded corners, side concave circular notches, dashed divider line; standard variant with blue outline and coral date "Valid Until 5.16.20"; expiring variant with `AppColors.voucherWarning` red border, `AppColors.voucherWarningBg` pink fill, red dashed line, and bold red "3 days left" text).
- [X] T028 [US3] Implement `VouchersTab` view within `lib/features/profile/presentation/pages/rewards_page.dart` (vertical list of active voucher cards using `VoucherCard`, empty state via `NoDataFoundWidget`, handling Screens 82 and 83).

**Checkpoint**: User Story 3 complete and independently verifiable.

---

## Phase 6: User Story 4 (P4) — Rewards Progress (Screen 84)

**Goal**: Deliver gamified achievement progress view featuring a 2-column by 3-row grid of milestone badges with earned completion checkmarks and qualification descriptions.  
**Independent Test**: On `/profile/rewards`, tap the `Progress` tab; verify instantaneous tab switch, 2x3 grid displaying 6 achievement milestones (First Purchase, Loyal Customer, Review Maker, Big Soul, Cloth Expert, 10+ Orders), earned checkmark badges via `VerifiedCheckBadge`, and seamless toggle back to Active Rewards.

- [X] T029 [P] [US4] Implement `RewardMilestoneCard` in `lib/features/profile/presentation/widgets/reward_milestone_card.dart` (card item displaying milestone icon badge, title, criteria description, and reusing `VerifiedCheckBadge` for unlocked/earned milestones).
- [X] T030 [US4] Implement `RewardsProgressTab` view in `lib/features/profile/presentation/pages/rewards_page.dart` (2-column by 3-row grid of milestone cards for First Purchase, Loyal Customer, Review Maker, Big Soul, Cloth Expert, 10+ Orders, and integrating tab switching between Active Rewards and Progress).

**Checkpoint**: User Story 4 complete; all 7 profile screens implemented and functional.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements, formatting, code cleanup, static analysis, and automated widget tests. Run strictly once at the end.

- [X] T031 [P] Code cleanup, formatting (`dart format`), ensuring 100% token usage (no hardcoded colors/radii/fonts), and verifying DRY widget reuse.
- [X] T032 Execute static analysis verification (`fvm flutter analyze`) and ensure 0 issues found across all feature files.
- [X] T033 [P] Write widget test suite in `test/features/profile/presentation/pages/profile_page_test.dart` verifying Profile Home announcement variations, My Activity donut chart rendering, and Rewards tab switching.

---

## Phase 8: Convergence

**Purpose**: Address visual discrepancies discovered during manual visual verification of screens 62, 81, 85, and 64, establishing shared Design System components (`AppText`, `AppContainer`, `RedDotBadge`), and applying targeted visual fixes.

- [X] T034 [CRITICAL] [P] Create shared typography widget `AppText` in `lib/shared/widgets/app_text.dart` supporting `h1`, `h2`, `h3`, `body`, `bodySecondary`, `caption`, `price` variants per Rule #11.
- [X] T035 [CRITICAL] [P] Create shared surface container `AppContainer` in `lib/shared/widgets/app_container.dart` with default `#F2F2F2` background and `20.r` radius per Rule #11.
- [X] T036 [CRITICAL] [P] Create shared indicator badge `RedDotBadge` in `lib/shared/widgets/red_dot_badge.dart` with customizable offset and size.
- [X] T037 [HIGH] [US1] Apply FIX 1: Reposition red notification dot on "To Recieve" tab using `RedDotBadge` inside padding box in `lib/features/profile/presentation/widgets/my_orders_tabs.dart`.
- [X] T038 [HIGH] [US1] Apply FIX 2: Refactor `AnnouncementCard` in `lib/features/profile/presentation/widgets/announcement_card.dart` to use `AppContainer` (`16.r`, `#F2F2F2`) and `AppText.h3` / `AppText.caption`.
- [X] T039 [HIGH] [US2] Apply FIX 3: Refactor `MonthSelector` in `lib/features/profile/presentation/widgets/month_selector.dart` to use `AppContainer` (`340x36px`, `48.r`, `#F2F2F2`) and centered `AppText.body`.
- [X] T040 [HIGH] [US2] Apply FIX 4: Update `PrimaryButton` and `MyActivityPage` for Order History CTA button to exact `335x48px` pill shape (`24.r`).
- [X] T041 [HIGH] [US2] Apply FIX 5: Rewrite `DonutChart` CustomPainter in `lib/features/profile/presentation/widgets/donut_chart.dart` with 4 arcs, small gap, Figma clockwise order (Orange -> Red -> Blue -> Green), and centered `AppText.bodySecondary` + `AppText.price`.
- [X] T042 [MEDIUM] Apply FIX 6: Add temporary debug long-press on My Activity button in `lib/features/profile/presentation/widgets/profile_header.dart` navigating to `/profile/rewards`.

---

## Dependencies & Execution Order

### Phase Dependencies
- **Phase 1 (Setup & Tokens)**: No dependencies — starts immediately. 11 tokens added to `AppColors` FIRST.
- **Phase 2 (Foundational)**: Depends on Phase 1 — BLOCKS all user stories.
- **Phase 3 (US1 - Profile Home)**: Depends on Phase 2. Delivers core MVP.
- **Phase 4 (US2 - My Activity)**: Depends on Phase 2. Integrates with US1 header.
- **Phase 5 (US3 - Active Vouchers)**: Depends on Phase 2.
- **Phase 6 (US4 - Rewards Progress)**: Depends on Phase 5 (shares `RewardsPage` and `RewardsCubit`).
- **Phase 7 (Polish & Verification)**: Depends on Phases 1–6 complete.

---

## Permanent Project Rules Reference

All tasks MUST strictly adhere to the Permanent Project Rules from `.specify/memory/constitution.md`:
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
