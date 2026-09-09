# Implementation Plan: Flash Sale Screen

**Branch**: `feature/flash-sale` | **Date**: 2026-09-04 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/003-flash-sale-screen/spec.md`

## Summary
Implement the dedicated **Flash Sale Screen** displaying discounted products with live countdown timer, interactive discount percentage filters (`All`, `10%`, `20%`, `30%`, `40%`, `50%`), live stream showcase card ("ARTICALE REIMAGINED" / "LIVE"), 2-column product grid with corner discount badges and strikethrough original prices, "Big Sale Up to 50%" promotional split banner, and "Most Popular" trending carousel.

The implementation strictly respects Feature-First Clean Architecture (`lib/features/flash_sale/`), Cubit state management, GetIt DI, go_router routing, and pixel-perfect fidelity with the Figma screenshot.

---

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x  
**Primary Dependencies**: `flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`  
**Storage**: Mock Data with 1.2s realistic network latency (Phase 1 UI-only)  
**Testing**: `flutter test`, `flutter analyze`  
**Target Platform**: iOS & Android  
**Project Type**: Mobile e-commerce application feature  
**Performance Goals**: 60 FPS smooth scrolling, 0 overflow errors, instant (<16ms) in-memory filter tab switching  
**Constraints**: Follow existing `home` feature architecture; reuse existing components where possible without duplication; no business logic in UI widgets; all responsive dimensions use `flutter_screenutil`.

---

## Constitution Check

| Principle | Requirement | Compliance Status |
|-----------|-------------|-------------------|
| **I. Existing Architecture Preservation** | Follow `lib/features/`, `lib/core/`, `lib/config/` structure | ✅ PASS: Creating `lib/features/flash_sale/` matching `lib/features/home/` |
| **II. Feature-First Clean Architecture** | Layers: presentation → domain ← data; `Either<Failure, T>`; `safeCall` error wrapper; DI via GetIt | ✅ PASS: Domain decoupled, UseCase uses dartz Either, GetIt registration in `flash_sale_injection.dart` |
| **III. Design Token & Figma Pixel-Perfection** | Figma tokens from `AppColors`, `AppTypography`, `AppSpacing`, all dimensions via `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`) | ✅ PASS: 100% token adherence and responsive ScreenUtil sizing |
| **IV. Strict UI & State Separation** | Cubit (`flutter_bloc`), Equatable states, no business logic in widgets, shimmer loading | ✅ PASS: `FlashSaleCubit`, `FlashSaleState` with Equatable, Shimmer loading |
| **V. Router & Shell Navigation** | go_router integration; mounted within ShellRoute or linked from Home | ✅ PASS: Added `/flash-sale` route in `app_router.dart` and `route_names.dart` |
| **VI. Scaffolding & Quality Gates** | Clean code, flutter analyze pass, Phase 1 UI mock backed | ✅ PASS: Clean mock data source, 0 analyzer warnings |

---

## 1. Folder Structure

Exact file tree for `lib/features/flash_sale/`:

```text
lib/features/flash_sale/
├── flash_sale_injection.dart
├── data/
│   ├── datasources/
│   │   ├── flash_sale_mock_datasource.dart
│   │   └── flash_sale_mock_datasource_impl.dart
│   ├── models/
│   │   ├── flash_sale_data_model.dart
│   │   ├── flash_sale_product_model.dart
│   │   └── live_stream_model.dart
│   └── repositories/
│       └── flash_sale_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── flash_sale_data_entity.dart
│   │   ├── flash_sale_product_entity.dart
│   │   └── live_stream_entity.dart
│   ├── repositories/
│   │   └── flash_sale_repository.dart
│   └── usecases/
│       └── get_flash_sale_data_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── flash_sale_cubit.dart
    │   └── flash_sale_state.dart
    ├── pages/
    │   └── flash_sale_page.dart
    └── widgets/
        ├── discount_filter_bar.dart          [NEW]
        ├── flash_sale_app_bar.dart           [NEW]
        ├── flash_sale_live_banner.dart       [NEW]
        ├── flash_sale_product_card.dart      [NEW]
        ├── flash_sale_promo_banner.dart      [NEW]
        └── flash_sale_shimmer_loading.dart   [NEW]
```

---

## 2. Reuse Strategy (CRITICAL)

Every widget is classified as **REUSE**, **MODIFY**, or **NEW**:

| Widget | Classification | Location | Rationale |
|--------|----------------|----------|-----------|
| `HomeSectionHeader` | **REUSE** | `lib/features/home/presentation/widgets/home_section_header.dart` | Reused for section titles. For "Most Popular": uses `title: 'Most Popular'`, `showSeeAll: true`. For "20% Discount": uses `title: '${state.selectedDiscount}% Discount'`, `trailing: Icon(Icons.settings_outlined)`. |
| `FlashSaleTimer` | **REUSE** | `lib/features/home/presentation/widgets/flash_sale_timer.dart` | Already implements the 3 white box countdown timer (`[00] [36] [58]`) with stopwatch icon. Reused in the Flash Sale AppBar. |
| `PopularProductCard` | **REUSE** | `lib/features/home/presentation/widgets/popular_product_card.dart` | Used directly in the "Most Popular" horizontal carousel with views/likes (`1780 ❤️`) and tags (`New`, `Sale`, `Hot`). |
| `ProductCardStandard` | **MODIFY** | `lib/features/home/presentation/widgets/product_card_standard.dart` | Extend `ProductCardStandard` with optional `originalPrice` (strikethrough), `discountPercentage` (corner badge), and configurable width so it can be reused across both features, OR pair with dedicated `FlashSaleProductCard` to guarantee pixel-perfection without affecting home screen. |
| `FlashSaleAppBar` | **NEW** | `lib/features/flash_sale/presentation/widgets/flash_sale_app_bar.dart` | Custom header with soft blue aura gradient backdrop, back button, "Flash Sale" title, embedded `FlashSaleTimer`, and "Choose Your Discount" subtitle. |
| `DiscountFilterBar` | **NEW** | `lib/features/flash_sale/presentation/widgets/discount_filter_bar.dart` | Horizontal selectable chips (`All`, `10%`, `20%`, `30%`, `40%`, `50%`) with custom active pill notch border indicator. |
| `FlashSaleLiveBanner` | **NEW** | `lib/features/flash_sale/presentation/widgets/flash_sale_live_banner.dart` | Multi-model collage, translucent play button, "ARTICALE REIMAGINED" title, and bright green `LIVE` pill badge. |
| `FlashSaleProductCard` | **NEW** | `lib/features/flash_sale/presentation/widgets/flash_sale_product_card.dart` | Specialized 2-column card matching Figma screenshot: grey image container with darken blend mode, top-right gradient `-20%` badge, 2-line title, bold current price (`$16,00`), and strikethrough original price (`$20,00`). |
| `FlashSalePromoBanner` | **NEW** | `lib/features/flash_sale/presentation/widgets/flash_sale_promo_banner.dart` | Static promotional banner ("Big Sale Up to 50% - Happening Now" split mustard gold and curved blue splash). |
| `FlashSaleShimmerLoading` | **NEW** | `lib/features/flash_sale/presentation/widgets/flash_sale_shimmer_loading.dart` | Shimmer placeholder matching screen layout during 1.2s loading state. |

---

## 3. Implementation Order (Priority)

1. **Step 1: Domain Layer**:
   - Create entities: `FlashSaleProductEntity`, `LiveStreamEntity`, `FlashSaleDataEntity`.
   - Create repository contract: `FlashSaleRepository`.
   - Create use case: `GetFlashSaleDataUseCase`.
2. **Step 2: Data Layer**:
   - Create models: `FlashSaleProductModel`, `LiveStreamModel`, `FlashSaleDataModel` with `fromJson` & `toJson`.
   - Create mock data source interface & implementation `FlashSaleMockDataSourceImpl` (1.2s delay, realistic mock products with discount tiers 10%, 20%, 30%, 40%, 50%).
   - Create repository implementation: `FlashSaleRepositoryImpl`.
3. **Step 3: Dependency Injection & Routing Setup**:
   - Create `lib/features/flash_sale/flash_sale_injection.dart` (`initFlashSale()`).
   - Register in `lib/core/di/injection_container.dart`.
   - Add `kFlashSalePage` in `lib/config/routing/route_names.dart`.
   - Add GoRoute in `lib/config/routing/app_router.dart`.
   - Wire tap on Home screen Flash Sale header / See All to navigate to `/flash-sale`.
4. **Step 4: Presentation Layer - Cubit & States**:
   - Create `FlashSaleState` (`Initial`, `Loading`, `Loaded`, `Error`).
   - Create `FlashSaleCubit`: `loadFlashSaleData()`, `selectDiscountFilter(int? discountPercentage)`, `refresh()`.
5. **Step 5: Presentation Layer - Specialized UI Widgets**:
   - `FlashSaleAppBar` (blue gradient backdrop, title, countdown, subtitle).
   - `DiscountFilterBar` (pill tabs with active border/notch styling).
   - `FlashSaleLiveBanner` (collage image, play icon, "ARTICALE REIMAGINED", "LIVE" badge).
   - `FlashSaleProductCard` (strikethrough price, `-20%` badge, image container).
   - `FlashSalePromoBanner` (split banner).
   - `FlashSaleShimmerLoading` (shimmer skeleton).
6. **Step 6: Screen Assembly (`FlashSalePage`)**:
   - Assemble `CustomScrollView` / `SingleChildScrollView` integrating all 6 sections.
   - Connect with `BlocBuilder<FlashSaleCubit, FlashSaleState>`.
7. **Step 7: Verification & Quality Audit**:
   - Run `flutter analyze` and resolve any warnings.
   - Test interaction: tab switching, countdown timer, navigation back and forth.

---

## 4. Data Layer Plan

- **Models**:
  - `FlashSaleProductModel`: Extends `FlashSaleProductEntity`. Includes `fromJson`/`toJson` handling price formatting, discounts, and image assets.
  - `LiveStreamModel`: Extends `LiveStreamEntity`.
  - `FlashSaleDataModel`: Extends `FlashSaleDataEntity`.
- **MockDataSource**:
  - `FlashSaleMockDataSourceImpl` returns pre-populated `FlashSaleDataModel`.
  - Artificial delay: `await Future.delayed(const Duration(milliseconds: 1200));`.
  - Realistic data includes items with 10%, 20%, 30%, 40%, 50% discounts matching Figma screenshot items (t-shirts, blouses, caps, hoodies).
- **Data Mapping**:
  - Models subclass entities directly (Clean Architecture standard pattern in this repo).
- **Repository Implementation**:
  - `FlashSaleRepositoryImpl` implements `FlashSaleRepository`.
  - Executes mock data source call wrapped in `safeCall` error handler returning `Right(data)` or `Left(Failure)`.

---

## 5. Domain Layer Plan

- **Entities**:
  - `FlashSaleProductEntity`: `id`, `title`, `currentPrice`, `originalPrice`, `imageUrl`, `discountPercentage`, `likeCount`, `tag`.
  - `LiveStreamEntity`: `id`, `title`, `bannerUrl`, `isLive`, `viewerCount`.
  - `FlashSaleDataEntity`: `products`, `liveStream`, `popularProducts`, `countdownDuration`.
- **Repository Contract**:
  - `abstract class FlashSaleRepository { Future<Either<Failure, FlashSaleDataEntity>> getFlashSaleData(); }`
- **UseCase**:
  - `class GetFlashSaleDataUseCase implements UseCase<FlashSaleDataEntity, NoParams>` returning `Future<Either<Failure, FlashSaleDataEntity>>`.

---

## 6. Presentation Layer Plan

### States (`FlashSaleState` with Equatable)
- `FlashSaleInitial`: Initial state.
- `FlashSaleLoading`: Emitted during data loading. Triggers `FlashSaleShimmerLoading`.
- `FlashSaleLoaded`:
  - `allProducts`: Full product list.
  - `filteredProducts`: Products filtered by selected discount.
  - `selectedDiscount`: Active discount integer (e.g. `20` by default as shown in Figma, or `null` for "All").
  - `liveStream`: Live stream info.
  - `popularProducts`: Products for carousel.
  - `countdownDuration`: Initial timer duration.
- `FlashSaleError`: Contains `message`.

### Cubit Methods
- `Future<void> loadFlashSaleData()`: Calls `GetFlashSaleDataUseCase`, sets initial discount filter to `20` (matching Figma), emits `FlashSaleLoaded`.
- `void selectDiscountFilter(int? discountPercentage)`: Synchronously filters `allProducts` by `discountPercentage` (or all if `null`), updates `selectedDiscount` and `filteredProducts`, emits new `FlashSaleLoaded`.
- `Future<void> refresh()`: Re-executes `loadFlashSaleData()` without crashing the view.

### Page Composition
`FlashSalePage` builds a `Scaffold` containing:
1. `FlashSaleAppBar` (Top area with blue aura gradient)
2. `DiscountFilterBar` (Horizontal chip bar)
3. `FlashSaleLiveBanner` ("ARTICALE REIMAGINED" + "LIVE" badge)
4. `HomeSectionHeader` (`[X]% Discount` + settings gear icon)
5. 2-column `GridView.builder` rendering `FlashSaleProductCard`s
6. `FlashSalePromoBanner` ("Big Sale Up to 50%")
7. `HomeSectionHeader` (`Most Popular` + "See All" blue circular arrow)
8. Horizontal `ListView` rendering `PopularProductCard`s

---

## 7. DI & Routing Plan

### DI Registration (`lib/features/flash_sale/flash_sale_injection.dart`)
```dart
import '../../core/di/injection_container.dart';
import 'data/datasources/flash_sale_mock_datasource.dart';
import 'data/datasources/flash_sale_mock_datasource_impl.dart';
import 'data/repositories/flash_sale_repository_impl.dart';
import 'domain/repositories/flash_sale_repository.dart';
import 'domain/usecases/get_flash_sale_data_usecase.dart';
import 'presentation/cubit/flash_sale_cubit.dart';

void initFlashSale() {
  // Cubit
  sl.registerFactory(() => FlashSaleCubit(getFlashSaleDataUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetFlashSaleDataUseCase(sl()));

  // Repository
  sl.registerLazySingleton<FlashSaleRepository>(
    () => FlashSaleRepositoryImpl(mockDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<FlashSaleMockDataSource>(
    () => FlashSaleMockDataSourceImpl(),
  );
}
```
Called inside `lib/core/di/injection_container.dart`: `initFlashSale();`.

### Routing Entry (`lib/config/routing/`)
- In `route_names.dart`:
  ```dart
  static const kFlashSalePage = '/flash-sale';
  ```
- In `app_router.dart`:
  ```dart
  GoRoute(
    path: RouteNames.kFlashSalePage,
    name: 'flash-sale',
    builder: (context, state) => const FlashSalePage(),
  ),
  ```
- In `HomePage`:
  Add tap handler on Flash Sale section header and "See All" button:
  `context.push(RouteNames.kFlashSalePage);`.

---

## 8. New Dependencies
**Zero new dependencies**. All required packages (`flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`) are already installed and verified in `pubspec.yaml`.

---

## 9. Git Commit Strategy
- Commit 1: `feat(flash-sale): add domain entities, repository contract, and use case`
- Commit 2: `feat(flash-sale): add data models, mock data source, and repository implementation`
- Commit 3: `feat(flash-sale): setup DI registration and routing for flash sale screen`
- Commit 4: `feat(flash-sale): implement FlashSaleCubit and FlashSaleState`
- Commit 5: `feat(flash-sale): implement custom UI widgets (app bar, filters, live banner, product card, promo)`
- Commit 6: `feat(flash-sale): assemble FlashSalePage and connect with Home navigation`

---

## 10. Quality Gates
- Every step checked with `flutter analyze` (0 errors, 0 warnings).
- 100% pixel fidelity with Figma screenshot.
- Zero business logic in widgets (purely declarative).
- All sizing strictly via `flutter_screenutil` extensions (`.w`, `.h`, `.r`, `.sp`).
