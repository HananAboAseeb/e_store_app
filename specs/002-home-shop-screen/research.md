# Research & Technical Decisions: Home (Shop Screen)

**Feature**: `002-home-shop-screen`  
**Date**: 2026-08-29  
**Status**: Resolved  

---

## 1. Architectural Strategy & Layer Boundaries

### Decision
Adhere strictly to Feature-First Clean Architecture (`lib/features/home/`) matching the canonical pattern established in `lib/features/auth/`:
- **Presentation**: `HomeView`, `HomeCubit`, `HomeState`, and 10 modular section widgets under `widgets/`
- **Domain**: `HomeBannerEntity`, `CategoryEntity`, `ProductEntity`, `GetHomeDataUseCase`, `HomeRepository` contract
- **Data**: `HomeBannerModel`, `CategoryModel`, `ProductModel`, `HomeMockDataSource`, `HomeRepositoryImpl`

### Rationale
- Complies with **Constitution Core Principles I & II** (Existing Architecture Preservation & Feature-First Clean Architecture).
- Fully decouples domain entities from external frameworks.
- Allows UseCases to return `Either<Failure, HomeDataEntity>` using `dartz`.

---

## 2. State Management & Mock Data Strategy

### Decision
- **State Management**: `HomeCubit` (`flutter_bloc`) emitting immutable states extending `Equatable`:
  - `HomeInitial`
  - `HomeLoading`
  - `HomeLoaded(banners, categories, topProducts, newItems, flashSaleProducts, popularProducts, stuffForYouProducts)`
  - `HomeError(message)`
- **Mock Data**: `HomeMockDataSource` returning complete e-commerce dataset after a 1.2s artificial latency.

### Rationale
- Enforces **Constitution Core Principle IV** (Strict UI & State Separation).
- Allows presentation layer to show shimmer placeholders during `HomeLoading` and render 100% pixel-perfect UI upon `HomeLoaded`.

---

## 3. Modular UI Component Separation

### Decision
Extract all 9 sections into distinct, self-contained widget files under `lib/features/home/presentation/widgets/`:
1. `home_app_bar.dart`
2. `home_hero_banner.dart`
3. `home_section_header.dart`
4. `category_card.dart`
5. `top_products_bar.dart`
6. `product_card_standard.dart`
7. `flash_sale_card.dart`
8. `flash_sale_timer.dart`
9. `popular_product_card.dart`
10. `home_shimmer_loading.dart`

### Rationale
- Enforces **Constitution Core Principle IV** (No inline widgets in Page files, zero business logic in UI widgets).
- Guarantees `HomeView` remains under 80 lines of clean declarative composition.
