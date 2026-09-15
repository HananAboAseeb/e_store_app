# Implementation Plan: Shop Feature (Screens 25, 26, 33)

**Branch**: `feature/shop` | **Date**: 2026-09-10 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/004-shop-screen/spec.md`

## Summary
Implement the dedicated **Shop** browsing experience (Screens 25, 26, 33) providing a 2-row category grid for apparel (Dresses, Pants, Skirts, Tunics, Jackets, Hoodies, Shirts, Polo, T-shirts), an "All Items" section header with filter shortcut, a responsive 2-column product grid with both regular (`$16,00`) and strike-through discounted prices (`$16,00` + `$20,00` in coral red), a sticky App Bar on scroll, and a comprehensive Filter modal (Screen 33) with multi-select category tiles, Clothes/Shoes size switcher with custom size indicators, selectable color swatches, dual-thumb price range slider ($10 - $150), and sort options.

The implementation strictly respects Feature-First Clean Architecture (`lib/features/shop/`), Cubit state management, GetIt DI, go_router routing under `/catalog`, and pixel-perfect fidelity with the Figma screenshots.

---

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x  
**Primary Dependencies**: `flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`  
**Storage**: Mock Data with realistic network latency (Phase 1 UI-only)  
**Testing**: `flutter test`, `flutter analyze`  
**Target Platform**: iOS & Android  
**Project Type**: Mobile e-commerce application feature  
**Performance Goals**: 60 FPS smooth scrolling, 0 overflow errors, instant (<16ms) in-memory filter and category switching  
**Constraints**: Follow existing `home` and `flash_sale` feature architecture; no business logic in UI widgets; all responsive dimensions use `flutter_screenutil`.

---

## Constitution Check

| Principle | Requirement | Compliance Status |
|-----------|-------------|-------------------|
| **I. Existing Architecture Preservation** | Follow `lib/features/`, `lib/core/`, `lib/config/` structure | ✅ PASS: Creating `lib/features/shop/` matching `lib/features/home/` and `lib/features/flash_sale/` |
| **II. Feature-First Clean Architecture** | Layers: presentation → domain ← data; `Either<Failure, T>`; `safeCall` error wrapper; DI via GetIt | ✅ PASS: Domain decoupled, UseCases use dartz Either, GetIt registration in `shop_injection.dart` |
| **III. Design Token & Figma Pixel-Perfection** | Figma tokens from `AppColors`, `AppTypography`, `AppSpacing`, all dimensions via `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`) | ✅ PASS: 100% token adherence and responsive ScreenUtil sizing |
| **IV. Strict UI & State Separation** | Cubit (`flutter_bloc`), Equatable states, no business logic in widgets, shimmer loading | ✅ PASS: `ShopCubit` & `FilterCubit`, Equatable states, Shimmer loading |
| **V. Router & Shell Navigation** | go_router integration; mounted within ShellRoute under `/catalog` | ✅ PASS: Replaces placeholder `CatalogPage` under `RouteNames.kCatalogPage` |
| **VI. Scaffolding & Quality Gates** | Clean code, flutter analyze pass, Phase 1 UI mock backed | ✅ PASS: Clean mock data source, 0 analyzer warnings |

---

## 1. Folder Structure

Exact file tree for `lib/features/shop/`:

```text
lib/features/shop/
├── shop_injection.dart
├── data/
│   ├── datasources/
│   │   ├── shop_mock_datasource.dart
│   │   └── shop_mock_datasource_impl.dart
│   ├── models/
│   │   ├── shop_product_model.dart
│   │   └── shop_category_model.dart
│   └── repositories/
│       └── shop_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── shop_product_entity.dart
│   │   ├── shop_category_entity.dart
│   │   └── filter_criteria_entity.dart
│   ├── repositories/
│   │   └── shop_repository.dart
│   └── usecases/
│       ├── get_shop_products_usecase.dart
│       └── get_shop_categories_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── shop_cubit.dart
    │   ├── shop_state.dart
    │   ├── filter_cubit.dart
    │   └── filter_state.dart
    ├── pages/
    │   ├── shop_page.dart
    │   └── filter_modal_sheet.dart
    └── widgets/
        ├── shop_app_bar.dart
        ├── shop_category_grid.dart
        ├── shop_category_tile.dart
        ├── shop_product_card.dart
        ├── shop_product_grid.dart
        ├── filter_category_tile.dart
        ├── filter_size_section.dart
        ├── filter_color_section.dart
        ├── filter_price_range_section.dart
        ├── filter_sort_section.dart
        └── shop_shimmer_loading.dart
```

---

## 2. Implementation Steps

1. **Domain Layer**:
   - Define `ShopProductEntity`, `ShopCategoryEntity`, and `FilterCriteriaEntity`.
   - Define abstract `ShopRepository` contract.
   - Implement `GetShopProductsUseCase` and `GetShopCategoriesUseCase`.

2. **Data Layer**:
   - Create `ShopProductModel` and `ShopCategoryModel`.
   - Implement `ShopMockDataSource` and `ShopMockDataSourceImpl` with products and categories extracted from Figma references.
   - Implement `ShopRepositoryImpl` using `safeCall` and in-memory filtering.

3. **Presentation Layer**:
   - Implement `ShopCubit` (states: `ShopInitial`, `ShopLoading`, `ShopLoaded`, `ShopError`).
   - Implement `FilterCubit` (state: `FilterState` with copyWith for draft modal selections).
   - Build atomic widgets: `ShopCategoryTile`, `ShopProductCard`, `ShopAppBar`.
   - Assemble `ShopPage` (Screen 25 & 26).
   - Assemble `FilterModalSheet` (Screen 33).

4. **Integration & DI**:
   - Register dependencies in `shop_injection.dart`.
   - Call `initShop()` in `lib/core/di/injection_container.dart`.
   - Wire `ShopPage` in `lib/config/routing/app_router.dart` for `/catalog`.
