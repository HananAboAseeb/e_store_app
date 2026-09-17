# Tasks: Search Feature (Screens 28, 29, 30, 31, 32)

**Input**: Design documents and specifications from `/specs/006-search/`  
**Prerequisites**: [plan.md](./plan.md), [spec.md](./spec.md), [research.md](./research.md), [data-model.md](./data-model.md), [contracts/search_contracts.md](./contracts/search_contracts.md)  
**Branch**: `feature/search`  
**Organization**: Tasks are grouped into Setup, Foundational, User Stories (US1 → US2 → US3 → US4), and Polish phases to enable independent implementation and testing.

## Format: `- [x] [TaskID] [P?] [Story?] Description with file path`

- **[P]**: Parallelizable (independent files, no blocking dependencies on incomplete tasks)
- **[Story]**: Belongs to a specific user story ([US1], [US2], [US3], [US4])
- Every task includes Prerequisites, Estimated Effort, and Quality Gate.

---

## Phase 1: Setup (Directory Structure, DI Skeleton & Route Placeholders)

**Purpose**: Scaffolding directories, injection skeleton, and route placeholders for `lib/features/search/`.

- [x] T001 Create complete folder structure in lib/features/search/
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Directories created: `domain/entities/`, `domain/repositories/`, `domain/usecases/`, `data/models/`, `data/datasources/`, `data/repositories/`, `presentation/cubit/`, `presentation/pages/`, `presentation/widgets/`.

- [x] T002 [P] Create initial dependency injection file in lib/features/search/search_injection.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Defines `initSearch()` function skeleton registered via `sl`.

- [x] T003 [P] Add search route constants in lib/config/routing/route_names.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: `kSearchPage = '/search'`, `kSearchResultsPage = '/search/results'`, `kImageSearchPage = '/search/image'` added to `RouteNames`.

- [x] T004 Register route placeholders in lib/config/routing/app_router.dart and wire initSearch in lib/core/di/injection_container.dart
  - **Prerequisites**: T002, T003
  - **Estimated Effort**: 5m
  - **Quality Gate**: Route placeholders registered for search routes; `initSearch()` called inside `injection_container.dart`.

---

## Phase 2: Foundational (Domain Entities, Repository Contract, Use Cases & Data Layer)

**Purpose**: Core domain entities, repository contract, use cases, models, mock datasource, and repository implementation with `safeCall`. MUST be completed before UI work.

- [x] T005 [P] Implement SearchHistoryEntity in lib/features/search/domain/entities/search_history_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `id`, `query`, `timestamp`.

- [x] T006 [P] Implement RecommendationEntity in lib/features/search/domain/entities/recommendation_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `id`, `label`.

- [x] T007 [P] Implement SearchDataEntity in lib/features/search/domain/entities/search_data_entity.dart
  - **Prerequisites**: T005, T006
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `history`, `recommendations`, `discoverProducts`.

- [x] T008 [P] Implement ImageSearchResultEntity in lib/features/search/domain/entities/image_search_result_entity.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, contains `id`, `imagePath`, `detectedCategory`, `confidence`, `products`.

- [x] T009 Define SearchRepository contract in lib/features/search/domain/repositories/search_repository.dart
  - **Prerequisites**: T007, T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Abstract class defining `getSearchData()`, `searchByText()`, `searchByImage()`, `clearSearchHistory()` returning `Either<Failure, T>`.

- [x] T010 [P] Implement GetSearchDataUseCase in lib/features/search/domain/usecases/get_search_data_usecase.dart
  - **Prerequisites**: T009
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<SearchDataEntity, NoParams>` delegating to `SearchRepository.getSearchData()`.

- [x] T011 [P] Implement SearchByTextUseCase in lib/features/search/domain/usecases/search_by_text_usecase.dart
  - **Prerequisites**: T009
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<List<ShopProductEntity>, SearchByTextParams>` delegating to `SearchRepository.searchByText()`.

- [x] T012 [P] Implement SearchByImageUseCase in lib/features/search/domain/usecases/search_by_image_usecase.dart
  - **Prerequisites**: T009
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<ImageSearchResultEntity, String>` delegating to `SearchRepository.searchByImage()`.

- [x] T013 [P] Implement ClearSearchHistoryUseCase in lib/features/search/domain/usecases/clear_search_history_usecase.dart
  - **Prerequisites**: T009
  - **Estimated Effort**: 5m
  - **Quality Gate**: Implements `UseCase<Unit, NoParams>` delegating to `SearchRepository.clearSearchHistory()`.

- [x] T014 [P] Implement SearchHistoryModel in lib/features/search/data/models/search_history_model.dart
  - **Prerequisites**: T005
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `SearchHistoryEntity`, implements `fromJson`, `toJson`, and `fromEntity`.

- [x] T015 [P] Implement RecommendationModel in lib/features/search/data/models/recommendation_model.dart
  - **Prerequisites**: T006
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `RecommendationEntity`, implements `fromJson`, `toJson`, and `fromEntity`.

- [x] T016 [P] Implement ImageSearchResultModel in lib/features/search/data/models/image_search_result_model.dart
  - **Prerequisites**: T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `ImageSearchResultEntity`, implements `fromJson`, `toJson`, and `fromEntity`.

- [x] T017 Define SearchMockDataSource interface in lib/features/search/data/datasources/search_mock_datasource.dart
  - **Prerequisites**: T014, T015, T016
  - **Estimated Effort**: 5m
  - **Quality Gate**: Interface specifying methods for search history, recommendations, discover products, text search, image search, and clear history.

- [x] T018 Implement SearchMockDataSourceImpl in lib/features/search/data/datasources/search_mock_datasource_impl.dart
  - **Prerequisites**: T017
  - **Estimated Effort**: 15m
  - **Quality Gate**: Concrete mock datasource containing 5 history chips (`Socks`, `Red Dress`, `Sunglasses`, `Mustard Pants`, `80's Skirt`), 5 recommendation chips (`Skirt`, `Accessories`, `Black T-Shirt`, `Jeans`, `White Shoes`), discover products with `$17,00` prices, text search with regular and discounted items (`$16,00` / strikethrough `$20,00`), and mock image recognition detecting `Shoes` using existing static assets from `assets/images/`.

- [x] T019 Implement SearchRepositoryImpl in lib/features/search/data/repositories/search_repository_impl.dart
  - **Prerequisites**: T009, T018
  - **Estimated Effort**: 10m
  - **Quality Gate**: Implements `SearchRepository` delegating to `SearchMockDataSource` and wrapping calls with `safeCall`.

- [x] T020 Register Search data and domain dependencies in lib/features/search/search_injection.dart
  - **Prerequisites**: T002, T010, T011, T012, T013, T019
  - **Estimated Effort**: 5m
  - **Quality Gate**: DataSource, Repository, and UseCases registered in GetIt container.

---

## Phase 3: User Story 1 — Search Main Screen 28 (Priority: P1) 🎯 MVP

**Goal**: Render Screen 28 with top search header (with embedded camera icon and dismiss cross `✕`), Search History section (with red trash icon `#FF3B30` and 5 chips), Recommendations section (5 chips), and horizontal Discover carousel, mounted within the persistent bottom nav shell.

- [x] T021 Implement SearchState in lib/features/search/presentation/cubit/search_state.dart
  - **Prerequisites**: T007, T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, defines `SearchInitial`, `SearchLoading`, `SearchLoaded`, `SearchResultsLoading`, `SearchResultsLoaded`, and `SearchError`.

- [x] T022 Implement SearchCubit in lib/features/search/presentation/cubit/search_cubit.dart
  - **Prerequisites**: T010, T011, T013, T021
  - **Estimated Effort**: 10m
  - **Quality Gate**: Extends `Cubit<SearchState>`, handles `loadSearchData()`, `submitQuery()`, `clearHistory()`, `clearQuery()`, and `applyFilter()`.

- [x] T023 [P] [US1] Implement SearchHeader widget in lib/features/search/presentation/widgets/search_header.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 10m
  - **Quality Gate**: Displays bold title "Search", rounded light grey `#F5F5F5` search input with camera icon button navigating to `/search/image`, and dismiss cross button `✕`.

- [x] T024 [P] [US1] Implement SearchChip widget in lib/features/search/presentation/widgets/search_chip.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Reusable rounded chip with `#F5F5F5` background, `12.r` radius, label text, and onTap callback.

- [x] T025 [P] [US1] Implement SearchHistorySection widget in lib/features/search/presentation/widgets/search_history_section.dart
  - **Prerequisites**: T024
  - **Estimated Effort**: 10m
  - **Quality Gate**: Renders "Search History" title, red trash icon button (`#FF3B30`) that calls `clearHistory()`, and wrap layout of history chips (`Socks`, `Red Dress`, etc.).

- [x] T026 [P] [US1] Implement SearchRecommendationsSection widget in lib/features/search/presentation/widgets/search_recommendations_section.dart
  - **Prerequisites**: T024
  - **Estimated Effort**: 10m
  - **Quality Gate**: Renders "Recommendations" title and wrap layout of recommendation chips (`Skirt`, `Accessories`, etc.).

- [x] T027 [P] [US1] Implement SearchDiscoverCarousel widget in lib/features/search/presentation/widgets/search_discover_carousel.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 10m
  - **Quality Gate**: Renders "Discover" title and horizontal scrolling list of product cards reusing `ShopProductCard` with price points `$17,00`.

- [x] T028 [P] [US1] Implement SearchShimmerLoading widget in lib/features/search/presentation/widgets/search_shimmer_loading.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 10m
  - **Quality Gate**: Smooth shimmer skeleton matching header, chip rows, and discover carousel.

- [x] T029 [US1] Implement SearchPage (Screen 28) in lib/features/search/presentation/pages/search_page.dart
  - **Prerequisites**: T022, T023, T025, T026, T027, T028
  - **Estimated Effort**: 15m
  - **Quality Gate**: Assembles Screen 28 with `BlocBuilder<SearchCubit, SearchState>`, handling chip taps by navigating to `/search/results?q=<query>`, camera icon navigating to `/search/image`, and trash icon clearing history.

- [x] T030 [US1] Register SearchCubit in search_injection.dart and wire SearchPage in lib/config/routing/app_router.dart
  - **Prerequisites**: T020, T029
  - **Estimated Effort**: 5m
  - **Quality Gate**: `SearchCubit` registered as factory in GetIt; `/search` route mounted in app router shell branch 0.

---

## Phase 4: User Story 2 — Search Results Screen 29 (Priority: P2)

**Goal**: Render Screen 29 with search field showing active query, inline `✕` clear icon, gear icon (`⚙`) reopening the filter modal (reusing `FilterModalSheet` from `feature/shop`), and a 2-column product grid with regular prices and coral red strikethrough discounted prices (`#FF5790`).

- [x] T031 [P] [US2] Implement SearchResultsHeader widget in lib/features/search/presentation/widgets/search_results_header.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 10m
  - **Quality Gate**: Title "Search", rounded text input showing query with inline `✕` clear icon, and gear filter icon button (`⚙`).

- [x] T032 [US2] Implement SearchResultsPage (Screen 29) in lib/features/search/presentation/pages/search_results_page.dart
  - **Prerequisites**: T022, T031
  - **Estimated Effort**: 20m
  - **Quality Gate**: Renders 2-column grid reusing `ShopProductCard` for regular and discounted products (`$16,00` with strikethrough `$20,00` in `#FF5790`); gear button explicitly opens `FilterModalSheet` from `feature/shop` (do NOT create duplicate filter); inline `✕` clears query.

- [x] T033 [US2] Bind SearchResultsPage route in lib/config/routing/app_router.dart
  - **Prerequisites**: T004, T032
  - **Estimated Effort**: 5m
  - **Quality Gate**: `/search/results` route passes `query` parameter to `SearchResultsPage` and mounts cleanly.

---

## Phase 5: User Story 3 — Image Search Capture & Recognized (Priority: P3)

**Goal**: Render Screens 30 & 31: full-screen image capture viewport with 3 circular buttons (Gallery, Primary 400 blue Camera `#004BFE`, More options), transition to image recognized state displaying a black rounded selection frame overlay bounding the detected product, and a white pill "Retry" button.

- [x] T034 Implement ImageSearchState in lib/features/search/presentation/cubit/image_search_state.dart
  - **Prerequisites**: T008
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `Equatable`, defines `ImageSearchInitial`, `ImageSearchCapturing`, `ImageSearchRecognized`, `ImageSearchResultsSheetVisible`, and `ImageSearchError`.

- [x] T035 Implement ImageSearchCubit in lib/features/search/presentation/cubit/image_search_cubit.dart
  - **Prerequisites**: T012, T034
  - **Estimated Effort**: 15m
  - **Quality Gate**: Extends `Cubit<ImageSearchState>`, handles `captureImage()`, `pickFromGallery()`, `retry()`, `showResultsSheet()`, and `dismissResultsSheet()`. Explicitly uses static mock assets from `assets/images/` without adding camera or image_picker plugins.

- [x] T036 [P] [US3] Implement ImageSearchControls widget in lib/features/search/presentation/widgets/image_search_controls.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 10m
  - **Quality Gate**: Renders 3 circular buttons at bottom: Gallery (grey circle, left), Camera (Primary 400 blue circle `#004BFE`, center), More (grey circle with `...`, right).

- [x] T037 [P] [US3] Implement ImageSelectionFrame widget in lib/features/search/presentation/widgets/image_selection_frame.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 10m
  - **Quality Gate**: Black rounded-rectangle bounding outline around detected product region with white pill "Retry" button at bottom.

- [x] T038 [US3] Implement ImageSearchPage (Screens 30 & 31) in lib/features/search/presentation/pages/image_search_page.dart
  - **Prerequisites**: T035, T036, T037
  - **Estimated Effort**: 20m
  - **Quality Gate**: Full-screen view with mock background asset from `assets/images/`, top dismiss button, bottom controls in capture state, and animated switch to `ImageSelectionFrame` with Retry button in recognized state.

- [x] T039 [US3] Register ImageSearchCubit in search_injection.dart and wire ImageSearchPage in lib/config/routing/app_router.dart
  - **Prerequisites**: T020, T038
  - **Estimated Effort**: 5m
  - **Quality Gate**: `ImageSearchCubit` registered in GetIt; `/search/image` route registered as full-screen modal route in `app_router.dart`.

---

## Phase 6: User Story 4 — Image Search Results Modal Sheet (Priority: P4)

**Goal**: Render Screen 32: slide-up modal bottom sheet (`24.r` top radius) over dimmed capture screen, displaying "Image Search" header with circular `✕` dismiss button, detected category badge (`Shoes` in solid blue `#004BFE` with white text), "Is this what you meant?" prompt, 2-column visually similar product grid, and full navigation integration.

- [x] T040 [P] [US4] Implement ImageSearchResultsSheet widget in lib/features/search/presentation/widgets/image_search_results_sheet.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 15m
  - **Quality Gate**: Modal bottom sheet with `24.r` top border radius, "Image Search" header, circular `✕` button, blue category chip (`Shoes`), "Is this what you meant?" prompt, and 2-column grid reusing `ShopProductCard`.

- [x] T041 [US4] Integrate ImageSearchResultsSheet display into ImageSearchPage and ImageSearchCubit
  - **Prerequisites**: T038, T040
  - **Estimated Effort**: 10m
  - **Quality Gate**: Opening modal bottom sheet upon product recognition or frame tap; dismissing modal returns cleanly to capture state.

- [x] T042 [US4] Verify cross-screen navigation flows and product card tap routing
  - **Prerequisites**: T029, T032, T038, T041
  - **Estimated Effort**: 10m
  - **Quality Gate**: Tapping any product card across Discover carousel, Search Results grid, or Image Results modal routes cleanly; all back stack flows operate without orphan routes.

---

## Phase 7: Polish & Quality Gates (Final Phase Only)

**Purpose**: Design token verification, responsive ScreenUtil checks, and single-pass static analysis. Must run strictly ONCE at the end per Permanent Project Rule 1.

- [x] T043 Verify Figma design tokens and ScreenUtil responsive scaling across all search screens
  - **Prerequisites**: T029, T032, T038, T041
  - **Estimated Effort**: 15m
  - **Quality Gate**: Zero hardcoded colors or fonts; all sizes using `.w`, `.h`, `.r`, `.sp`; 100% token usage (`AppColors`, `AppSpacing`, `AppTypography`).

- [x] T044 Execute static analysis and verify zero errors or warnings
  - **Prerequisites**: T043
  - **Estimated Effort**: 10m
  - **Quality Gate**: `flutter analyze` runs once and reports 0 errors, 0 warnings.

---

## Dependencies & Completion Order

```text
Phase 1 (Setup: T001-T004)
       │
       ▼
Phase 2 (Foundational: T005-T020)
       │
       ├─────────────────────────────────────────┐
       ▼                                         ▼
Phase 3 (US1 - Screen 28: T021-T030)   Phase 5 (US3 - Screens 30/31: T034-T039)
       │                                         │
       ▼                                         ▼
Phase 4 (US2 - Screen 29: T031-T033)   Phase 6 (US4 - Screen 32: T040-T042)
       │                                         │
       └────────────────────┬────────────────────┘
                            │
                            ▼
               Phase 7 (Polish: T043-T044)
```

### Parallel Execution Opportunities
- **Setup**: `T002` (DI) and `T003` (Routes) in parallel after `T001`.
- **Foundational Entities & Models**: `T005`, `T006`, `T007`, `T008`, `T010`, `T011`, `T012`, `T013`, `T014`, `T015`, `T016` can be implemented in parallel.
- **US1 Widgets**: `T023`, `T024`, `T025`, `T026`, `T027`, `T028` in parallel.
- **US2 Widgets**: `T031` in parallel with page preparation.
- **US3 & US4 Widgets**: `T036`, `T037`, `T040` in parallel.

### Implementation Strategy
1. **MVP Scope**: Complete Phase 1, Phase 2, and Phase 3 (US1 - Screen 28). This delivers full text search discovery with history, recommendations, discover carousel, and bottom nav integration.
2. **Increment 2**: Complete Phase 4 (US2 - Screen 29) to add the 2-column search results grid with discount pricing and filter modal reuse.
3. **Increment 3**: Complete Phase 5 (US3 - Screens 30/31) and Phase 6 (US4 - Screen 32) to add the complete visual image search workflow.
4. **Final Gate**: Execute Phase 7 (Polish & `flutter analyze`).
