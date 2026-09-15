# Implementation Plan: Categories Feature (Screen 27)

**Branch**: `feature/categories` | **Date**: 2026-09-16 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/005-categories/spec.md` and Figma reference `assets/design_references/27_CATEGORIES_FILTER.png`.

---

## Summary
Implement the **All Categories** full-screen modal screen (Screen 27) featuring a top App Bar with a circular close button (`✕`), three department tabs (`All`, `Female`, `Male`), an accordion list of category groups with single-expansion behavior (`Clothing` expanded by default with 10 sub-category pills in 2 columns; `Shoes`, `Bags`, `Accesories` collapsed), a dedicated "Just for you" card with action trigger, and navigation to the filtered catalog.

The implementation follows Feature-First Clean Architecture (`lib/features/categories/`), Cubit state management, GetIt DI, and `go_router` under `/categories`.

---

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x  
**Primary Dependencies**: `flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`  
**Storage**: Mock Data with simulated latency (Phase 1 UI-only)  
**Testing & Verification**: Static analysis strictly deferred to final phase per Permanent Rule 1  
**Target Platform**: iOS & Android  
**Design Reference**: `assets/design_references/27_CATEGORIES_FILTER.png`  
**Performance Goals**: 60 FPS smooth accordion transitions (<250ms), zero layout overflow across viewports (`375.w`–`412.w`), instantaneous tab updates

---

## Constitution Check

| Principle / Rule | Requirement | Compliance Status |
|---|---|---|
| **I. Existing Architecture Preservation** | Follow `lib/features/`, `lib/core/`, `lib/config/` structure | ✅ PASS: Creates `lib/features/categories/` following canonical repository architecture |
| **II. Clean Architecture & Data Safety** | Domain decoupled, UseCases return `Either<Failure, T>`, `safeCall` in repo impl | ✅ PASS: Uses `dartz`, `safeCall`, clean layer boundaries |
| **III. Design Tokens & Pixel Perfection** | `AppColors`, `AppSpacing`, `AppTypography`, all dimensions with `flutter_screenutil` | ✅ PASS: 100% token usage and `.w, .h, .r, .sp` scaling matching Screen 27 |
| **IV. Strict UI & State Separation** | Cubit state management, Equatable states, shimmer loading | ✅ PASS: `CategoriesCubit`, immutable states, shimmer placeholder |
| **V. Router & Shell Navigation** | Registered in `go_router`, clean pop/push navigation | ✅ PASS: Registered at `/categories` with `context.pop()` and catalog routing |
| **Permanent Rules 1–10** | Deferred analysis, no new asset generation, mock data only, widget extraction | ✅ PASS: Strictly respected across all layers |

---

## Project Structure

### Documentation Artifacts
```text
specs/005-categories/
├── spec.md              # Feature specification
├── plan.md              # Implementation plan (this file)
├── research.md          # Phase 0 architectural & technical decisions
├── data-model.md        # Phase 1 entities, data models, and Cubit states
├── quickstart.md        # Phase 1 validation scenarios
├── contracts/
│   └── categories_contracts.md # Repository, UseCase, DataSource, Cubit contracts
└── checklists/
    └── requirements.md  # Specification quality checklist
```

### Source Code (`lib/`)
```text
lib/features/categories/
├── categories_injection.dart
├── data/
│   ├── datasources/
│   │   ├── categories_mock_datasource.dart
│   │   └── categories_mock_datasource_impl.dart
│   ├── models/
│   │   ├── category_group_model.dart
│   │   └── sub_category_model.dart
│   └── repositories/
│       └── categories_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── category_group_entity.dart
│   │   ├── sub_category_entity.dart
│   │   └── gender_filter.dart
│   ├── repositories/
│   │   └── categories_repository.dart
│   └── usecases/
│       └── get_categories_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── categories_cubit.dart
    │   └── categories_state.dart
    ├── pages/
    │   └── categories_page.dart
    └── widgets/
        ├── categories_app_bar.dart
        ├── gender_tab_bar.dart
        ├── category_accordion_tile.dart
        ├── sub_category_pill.dart
        ├── just_for_you_card.dart
        └── categories_shimmer_loading.dart

# Modified Core & Config Files:
lib/config/routing/route_names.dart        # Add kCategoriesPage = '/categories'
lib/config/routing/app_router.dart         # Register GoRoute for CategoriesPage
lib/core/di/injection_container.dart       # Call initCategories()
```

---

## Implementation Steps

### 1. Domain Layer (`lib/features/categories/domain/`)
- Define `GenderFilter` enum (`all`, `female`, `male`).
- Define `SubCategoryEntity` and `CategoryGroupEntity` extending `Equatable`.
- Define abstract `CategoriesRepository` contract returning `Either<Failure, List<CategoryGroupEntity>>`.
- Implement `GetCategoriesUseCase`.

### 2. Data Layer (`lib/features/categories/data/`)
- Implement `CategoryGroupModel` and `SubCategoryModel` with JSON serialization and entity conversion.
- Implement `CategoriesMockDataSource` and `CategoriesMockDataSourceImpl` supplying mock category groups for `all`, `female`, and `male` departments matching Screen 27.
- Implement `CategoriesRepositoryImpl` wrapping data calls with `safeCall`.

### 3. Presentation Layer (`lib/features/categories/presentation/`)
- Implement `CategoriesState` (Initial, Loading, Loaded, Error) extending `Equatable`.
- Implement `CategoriesCubit` handling:
  - `loadCategories({GenderFilter gender = GenderFilter.all})`
  - `selectGender(GenderFilter gender)`
  - `toggleCategoryExpansion(String groupId)`
- Implement UI components:
  - `CategoriesAppBar`: "All Categories" title + circular dismiss button (`✕`).
  - `GenderTabBar`: 3 segmented tabs with blue active border & text vs inactive grey fill.
  - `CategoryAccordionTile`: Animated expandable card with category icon, title, chevron, and sub-category grid.
  - `SubCategoryPill`: Rounded pill button (`12.r`) with tap handler navigating to `/catalog?subCategory=<name>`.
  - `JustForYouCard`: Star icon + blue circular arrow button navigating to `/catalog?filter=just_for_you`.
  - `CategoriesShimmerLoading`: Placeholder shimmer skeleton.
  - `CategoriesPage`: Main page assembling all components with `BlocBuilder`.

### 4. Dependency Injection & Routing
- Create `categories_injection.dart` registering DataSource, Repository, UseCase, and Cubit in GetIt.
- Register `initCategories()` in `lib/core/di/injection_container.dart`.
- Add `kCategoriesPage` in `lib/config/routing/route_names.dart`.
- Register `/categories` in `lib/config/routing/app_router.dart`.

---

## Permanent Project Rules Reference

All tasks and implementations MUST strictly adhere to the Permanent Project Rules from `.specify/instructions/permanent-project-rules.md`:
1. **Verification Timing**: Do NOT run `flutter analyze` or `flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PrimaryButton, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
