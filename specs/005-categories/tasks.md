# Tasks: Categories Feature — Screen 43 ("Just for you") Enhancement

**Input**: Design documents and specifications from `/specs/005-categories/`  
**Prerequisites**: [plan.md](./plan.md), [spec.md](./spec.md), [research.md](./research.md), [data-model.md](./data-model.md), [contracts/categories_contracts.md](./contracts/categories_contracts.md)  
**Branch**: `feature/categories`  
**Visual Reference**: `assets/design_references/43 CATEGORIES JUST FOR YOU.png`  
**Organization**: Tasks are grouped into Foundational Extensions, Presentation Extensions, JustForYouPage (Screen 43), Navigation Integration, and Polish & Quality Verification.

## Format: `- [ ] [TaskID] [P?] [Story?] Description with file path`

- **[P]**: Parallelizable (independent files, no blocking dependencies on incomplete tasks)
- **[Story]**: Belongs to a specific user story ([US4] for Screen 43)
- Every task includes Prerequisites, Estimated Effort, and Quality Gate.

---

## Phase 1: Foundational Extensions (Domain, Data, DI)

**Purpose**: Extend the existing Clean Architecture domain and data layers to support personalized "Just for you" product retrieval.

- [x] T001 Extend CategoriesRepository interface in lib/features/categories/domain/repositories/categories_repository.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Adds `Future<Either<Failure, List<ShopProductEntity>>> getJustForYouProducts();` reusing `ShopProductEntity` from `feature/shop`.

- [x] T002 [P] Implement GetJustForYouProductsUseCase in lib/features/categories/domain/usecases/get_just_for_you_products_usecase.dart
  - **Prerequisites**: T001
  - **Estimated Effort**: 5m
  - **Quality Gate**: Extends `UseCase<List<ShopProductEntity>, NoParam>` delegating to `repository.getJustForYouProducts()`.

- [x] T003 [P] Extend CategoriesMockDataSource interface in lib/features/categories/data/datasources/categories_mock_datasource.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Adds `Future<List<ShopProductModel>> getJustForYouProducts();` contract.

- [x] T004 Extend CategoriesMockDataSourceImpl with mock Just For You products in lib/features/categories/data/datasources/categories_mock_datasource_impl.dart
  - **Prerequisites**: T003
  - **Estimated Effort**: 10m
  - **Quality Gate**: Implements `getJustForYouProducts()` returning 6+ curated `ShopProductModel` items reusing existing images in `assets/images/` with realistic prices and discounts.

- [x] T005 Extend CategoriesRepositoryImpl with getJustForYouProducts implementation in lib/features/categories/data/repositories/categories_repository_impl.dart
  - **Prerequisites**: T001, T004
  - **Estimated Effort**: 5m
  - **Quality Gate**: Wraps `mockDataSource.getJustForYouProducts()` in `safeCall` returning `Either<Failure, List<ShopProductEntity>>`.

- [x] T006 Register GetJustForYouProductsUseCase and update CategoriesCubit in lib/features/categories/categories_injection.dart
  - **Prerequisites**: T002, T005
  - **Estimated Effort**: 5m
  - **Quality Gate**: Registers `GetJustForYouProductsUseCase` in `sl` and passes it to `CategoriesCubit` factory registration.

---

## Phase 2: Presentation Extensions (Cubit, States, Widgets)

**Purpose**: Extend state management and build reusable presentation widgets for Screen 43.

- [x] T007 [P] Extend CategoriesState with Just For You states in lib/features/categories/presentation/cubit/categories_state.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Adds `JustForYouLoading`, `JustForYouLoaded(products: List<ShopProductEntity>)`, and `JustForYouError(message: String)` extending `CategoriesState`.

- [x] T008 Extend CategoriesCubit with loadJustForYouProducts in lib/features/categories/presentation/cubit/categories_cubit.dart
  - **Prerequisites**: T002, T007
  - **Estimated Effort**: 10m
  - **Quality Gate**: Injects `GetJustForYouProductsUseCase` and implements `loadJustForYouProducts()` emitting loading, loaded, or error states.

- [x] T009 [P] Create JustForYouHeader widget in lib/features/categories/presentation/widgets/just_for_you_header.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 10m
  - **Quality Gate**: Renders top title "Categories" (`Raleway`, bold, `AppColors.textPrimary`), standard back arrow button, and section row with blue star icon (`AppColors.primary`) + "Just for you" (`18.sp`, bold).

- [x] T010 [P] Create JustForYouShimmerLoading widget in lib/features/categories/presentation/widgets/just_for_you_shimmer_loading.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 10m
  - **Quality Gate**: Reusable 2-column skeleton shimmer placeholder matching `ShopProductCard` aspect ratio (`0.58`) and spacings (`mainAxisSpacing: 16.h`, `crossAxisSpacing: 14.w`).

---

## Phase 3: User Story 4 — JustForYouPage (Screen 43) 🎯 MVP

**Purpose**: Build the dedicated Screen 43 page widget, displaying the header, shimmer loading, and 2-column recommendations grid strictly reusing `ShopProductCard`.

**Goal**: As a shopper, I want to browse a dedicated "Just for you" screen with a 2-column grid of curated products so that I can discover personalized merchandise.

**Independent Test**: Navigate to `/categories/just-for-you`. Verify header shows "Categories" and "★ Just for you", loading shimmer renders during fetch, 2-column product grid renders `ShopProductCard` items with images, titles, and formatted prices, tapping card navigates to `/product/:id`, and back button returns cleanly.

- [x] T011 [US4] Implement JustForYouPage in lib/features/categories/presentation/pages/just_for_you_page.dart
  - **Prerequisites**: T006, T008, T009, T010
  - **Estimated Effort**: 15m
  - **Quality Gate**: Provides `BlocProvider<CategoriesCubit>` calling `loadJustForYouProducts()`, renders `JustForYouHeader`, `JustForYouShimmerLoading` on loading, `JustForYouError` with retry on failure, and 2-column `GridView.builder` strictly reusing `ShopProductCard` from `feature/shop` with card navigation to `/product/:id`.

---

## Phase 4: Navigation Integration

**Purpose**: Register the new route in GoRouter and wire the Screen 27 "Just for you" row arrow to navigate to Screen 43.

- [x] T012 [P] Add kCategoriesJustForYouPage route constant in lib/config/routing/route_names.dart
  - **Prerequisites**: None
  - **Estimated Effort**: 5m
  - **Quality Gate**: Adds `static const kCategoriesJustForYouPage = '/categories/just-for-you';` to `RouteNames`.

- [x] T013 Register JustForYouPage route in lib/config/routing/app_router.dart
  - **Prerequisites**: T011, T012
  - **Estimated Effort**: 5m
  - **Quality Gate**: Registers route for `RouteNames.kCategoriesJustForYouPage` rendering `const JustForYouPage()`.

- [x] T014 Wire JustForYouCard onTap to push Screen 43 in lib/features/categories/presentation/pages/categories_page.dart
  - **Prerequisites**: T012
  - **Estimated Effort**: 5m
  - **Quality Gate**: Updates `JustForYouCard` `onTap` callback to invoke `context.push(RouteNames.kCategoriesJustForYouPage)`.

---

## Phase 5: Polish & Quality Verification

**Purpose**: Presentation widget tests, static analysis, and regression validation executed strictly once at the end.

- [x] T015 [P] Create widget test for JustForYouPage in test/features/categories/presentation/pages/just_for_you_page_test.dart
  - **Prerequisites**: T011
  - **Estimated Effort**: 15m
  - **Quality Gate**: Tests loading state shimmer, loaded state product grid, tap navigation, and error retry.

- [x] T016 Run static analysis verification via flutter analyze
  - **Prerequisites**: T001–T015
  - **Estimated Effort**: 5m
  - **Quality Gate**: `flutter analyze` reports 0 issues, 0 errors, and 0 warnings across the entire repository.

- [x] T017 Run test suite verification via flutter test
  - **Prerequisites**: T015, T016
  - **Estimated Effort**: 5m
  - **Quality Gate**: All existing and new tests pass with 100% green status.

---

## Dependencies & Execution Order

```text
Phase 1: Foundational Extensions (T001 → T002, T003 → T004 → T005 → T006)
   │
   ▼
Phase 2: Presentation Extensions (T007 → T008; [P] T009, T010)
   │
   ▼
Phase 3: Screen 43 Page (T011 [US4])
   │
   ▼
Phase 4: Navigation Integration (T012 → T013, T014)
   │
   ▼
Phase 5: Polish & Final Verification (T015 → T016 → T017)
```

---

## Parallel Execution Opportunities

- **Phase 1**: T002 (`GetJustForYouProductsUseCase`) and T003 (`CategoriesMockDataSource`) can run in parallel after T001.
- **Phase 2**: T007 (`CategoriesState`), T009 (`JustForYouHeader`), and T010 (`JustForYouShimmerLoading`) can be developed in parallel.
- **Phase 4**: T012 (`RouteNames`) can run in parallel with earlier UI tasks.
- **Phase 5**: T015 (`just_for_you_page_test.dart`) can be created in parallel with final reviews before running analysis.

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
