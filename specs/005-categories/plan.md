# Implementation Plan: Categories — Just for you (Screen 43 Enhancement)

**Branch**: `feature/categories` | **Date**: 2026-09-28 | **Spec**: [spec.md](./spec.md)

**Design Reference**: `assets/design_references/43 CATEGORIES JUST FOR YOU.png` (Screen 43) & `27_CATEGORIES_FILTER.png` (Screen 27).

---

## Summary
Enhance the existing `categories` feature by adding **Screen 43 ("Categories Just for you")**, accessible via the blue arrow button (`→`) inside the "Just for you" row of Screen 27. The screen renders a bold "Categories" page title, a prominent "★ Just for you" section header, and a vertically scrollable 2-column grid of personalized product recommendation cards.

In strict adherence to DRY principles, Screen 43 reuses `ShopProductCard` and the 2-column grid layout pattern from `feature/shop`. All colors, spacing, and typography strictly reference project tokens (Rule #11). The existing `CategoriesCubit`, `CategoriesRepository`, and `CategoriesMockDataSource` are extended with new methods.

---

## Technical Context

- **Language/Version**: Dart 3.x / Flutter 3.x
- **Primary Dependencies**: `flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`
- **Architecture**: Feature-First Clean Architecture (`lib/features/categories/`)
- **State Management**: `CategoriesCubit` with Equatable states (`JustForYouLoading`, `JustForYouLoaded`, `JustForYouError`)
- **Data Source**: Local mock dataset in `CategoriesMockDataSourceImpl` reusing existing image assets (`assets/images/`)
- **Routing**: `RouteNames.kCategoriesJustForYouPage` (`/categories/just-for-you`) registered under `/categories`
- **Reused Components**: `ShopProductCard` (`lib/features/shop/presentation/widgets/shop_product_card.dart`), `ShopProductEntity` (`lib/features/shop/domain/entities/shop_product_entity.dart`)

---

## Constitution & Permanent Rules Check

| Principle / Rule | Requirement | Compliance Strategy |
|---|---|---|
| **I. Existing Architecture Preservation** | Extend existing feature without re-architecting | ✅ PASS: Extends `lib/features/categories/` and `specs/005-categories/` |
| **II. Clean Architecture & Data Safety** | Domain decoupled, UseCase returns `Either<Failure, T>`, `safeCall` in repo | ✅ PASS: `GetJustForYouProductsUseCase`, `safeCall` in `CategoriesRepositoryImpl` |
| **III. Design Tokens & Pixel-Perfection** | Strictly use `AppColors`, `AppSpacing`, `AppTypography`, `ScreenUtil` | ✅ PASS: Matches `43 CATEGORIES JUST FOR YOU.png` using design tokens only |
| **IV. Strict UI & State Separation** | Cubit state management, Equatable states, shimmer loading | ✅ PASS: Extends `CategoriesCubit`, new immutable states, shimmer grid |
| **V. Router & Navigation Discipline** | `go_router` path/named routing, clean back navigation | ✅ PASS: `/categories/just-for-you` sub-route; pops back to Screen 27 |
| **Rule 1: Verification Timing** | Do NOT run `flutter analyze`/`test` until final phase | ✅ PASS: Verification strictly deferred to implementation finale |
| **Rule 2: Asset Policy** | Reuse existing assets only, no new image files | ✅ PASS: Reuses `assets/images/` product images and standard icons |
| **Rule 6: DRY Component Reuse** | Reuse existing widgets, entities, and patterns | ✅ PASS: Reuses `ShopProductCard`, `ShopProductEntity`, and 2-col shop grid |
| **Rule 8: Phase 1 Data Scope** | Mock data only | ✅ PASS: Mock products in `CategoriesMockDataSourceImpl` |
| **Rule 11: Token Enforcement** | Strict token usage from `AppColors`, `AppSpacing`, `AppTypography` | ✅ PASS: Zero hardcoded colors/radii/typography |

---

## Project Structure Changes

### Documentation Artifacts (`specs/005-categories/`)
- `spec.md`: Enhanced with Screen 43 stories (User Story 4) and functional requirements (FR-023 to FR-035).
- `plan.md`: This implementation plan.
- `research.md`: Architectural decisions resolving DRY reuse, Cubit extension, and sub-routing.
- `data-model.md`: Data contracts and state models for Screen 43.
- `contracts/categories_contracts.md`: Interface contracts for Repository, UseCase, DataSource, and Cubit.
- `quickstart.md`: Validation guide for Screen 27 & Screen 43.
- `checklists/requirements.md`: Specification quality validation.

### Source Code Changes (`lib/`)

```text
lib/
├── config/routing/
│   ├── route_names.dart                              # [MODIFIED] Add kCategoriesJustForYouPage
│   └── app_router.dart                               # [MODIFIED] Register JustForYouPage route
├── features/categories/
│   ├── categories_injection.dart                     # [MODIFIED] Register GetJustForYouProductsUseCase & update Cubit
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── categories_mock_datasource.dart       # [MODIFIED] Add getJustForYouProducts()
│   │   │   └── categories_mock_datasource_impl.dart  # [MODIFIED] Add mock Just For You products list
│   │   └── repositories/
│   │       └── categories_repository_impl.dart       # [MODIFIED] Implement getJustForYouProducts() with safeCall
│   ├── domain/
│   │   ├── repositories/
│   │   │   └── categories_repository.dart            # [MODIFIED] Add getJustForYouProducts() contract
│   │   └── usecases/
│   │       └── get_just_for_you_products_usecase.dart# [NEW] Single-purpose use case
│   └── presentation/
│       ├── cubit/
│       │   ├── categories_cubit.dart                 # [MODIFIED] Add loadJustForYouProducts()
│       │   └── categories_state.dart                 # [MODIFIED] Add JustForYouLoading, JustForYouLoaded, JustForYouError
│       ├── pages/
│       │   ├── categories_page.dart                  # [MODIFIED] Wire JustForYouCard onTap -> push kCategoriesJustForYouPage
│       │   └── just_for_you_page.dart                # [NEW] Screen 43 page widget
│       └── widgets/
│           ├── just_for_you_header.dart              # [NEW] Header with "Categories" & "★ Just for you"
│           └── just_for_you_shimmer_loading.dart     # [NEW] 2-column product grid shimmer placeholder
```

---

## Technical Design & Implementation Steps

### 1. Domain Layer Extension
- **Repository Contract** (`categories_repository.dart`):
  ```dart
  Future<Either<Failure, List<ShopProductEntity>>> getJustForYouProducts();
  ```
- **UseCase** (`get_just_for_you_products_usecase.dart`):
  Extends `UseCase<List<ShopProductEntity>, NoParam>`, delegating to `repository.getJustForYouProducts()`.

### 2. Data Layer Extension
- **Mock DataSource** (`categories_mock_datasource.dart` & `categories_mock_datasource_impl.dart`):
  Add `getJustForYouProducts()` returning 6+ mock `ShopProductModel` instances with realistic prices (`$17.00`), titles, discounts, and image asset paths (`assets/images/prod_20_1.png`, `cat_cloth_1.png`, etc.).
- **Repository Implementation** (`categories_repository_impl.dart`):
  Implement `getJustForYouProducts()` using `safeCall(() => mockDataSource.getJustForYouProducts())`.

### 3. Presentation Layer Extension
- **Cubit & States** (`categories_cubit.dart` & `categories_state.dart`):
  - Inject `GetJustForYouProductsUseCase` into `CategoriesCubit`.
  - Add `loadJustForYouProducts()` emitting `JustForYouLoading`, then `JustForYouLoaded` or `JustForYouError`.
  - Add `JustForYouLoading`, `JustForYouLoaded(products: List<ShopProductEntity>)`, and `JustForYouError(message: String)` to `categories_state.dart`.
- **UI Components**:
  - `just_for_you_header.dart`:
    - Top bar with back arrow button + bold title "Categories" (`Raleway`, bold, `AppColors.textPrimary`).
    - Section title row: Blue star icon (`AppColors.primary`) + "Just for you" (`18.sp`, bold, `AppColors.textPrimary`).
  - `just_for_you_shimmer_loading.dart`:
    - 2-column grid shimmer placeholder matching card dimensions (`childAspectRatio: 0.58`, `mainAxisSpacing: 16.h`, `crossAxisSpacing: 14.w`).
  - `just_for_you_page.dart` (Screen 43):
    - Scaffold with `AppColors.background`.
    - `BlocProvider<CategoriesCubit>` creating a fresh factory instance calling `..loadJustForYouProducts()`.
    - `BlocBuilder<CategoriesCubit, CategoriesState>` rendering loading shimmer, error retry, or 2-column `GridView.builder` of `ShopProductCard` widgets.
    - Card tap navigates to `context.push('/product/${product.id}')`.
  - `categories_page.dart` (Screen 27):
    - Update `JustForYouCard` `onTap` callback to `context.push(RouteNames.kCategoriesJustForYouPage)`.

### 4. Routing & Dependency Injection
- `route_names.dart`: Add `static const kCategoriesJustForYouPage = '/categories/just-for-you';`.
- `app_router.dart`: Register `kCategoriesJustForYouPage` to render `const JustForYouPage()`.
- `categories_injection.dart`:
  - Register `GetJustForYouProductsUseCase`.
  - Update `CategoriesCubit` factory: `CategoriesCubit(getCategoriesUseCase: sl(), getJustForYouProductsUseCase: sl())`.

---

## Acceptance & Quality Verification
- **Pixel Perfection**: Screen 43 matches `43 CATEGORIES JUST FOR YOU.png` in typography, padding, and layout.
- **Independence**: Opening Screen 43 and popping back retains Screen 27's accordion expansion and gender selection without re-fetching.
- **Zero Duplication**: `ShopProductCard` and grid layout parameters reused directly from `feature/shop`.
- **Static Analysis**: `flutter analyze` passes with 0 errors and 0 warnings (executed strictly during final implementation phase).
