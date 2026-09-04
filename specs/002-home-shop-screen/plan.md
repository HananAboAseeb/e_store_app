# Implementation Plan: Home (Shop Screen)

**Branch**: `002-home-shop-screen` | **Date**: 2026-08-29 | **Spec**: [spec.md](./spec.md)

**Input**: Home (Shop Screen) specification for e-commerce storefront landing screen.

---

## 1. Summary

The Home (Shop Screen) feature provides a complete landing page with 9 distinct visual sections (AppBar/Search, Hero Banner & Carousel, Categories Grid, Top Products, New Items, Flash Sale with Timer, Most Popular, Stuff For You, and Persistent Bottom Nav Shell).

Implementation follows Feature-First Clean Architecture (`lib/features/home/`) with `HomeCubit` (`flutter_bloc`), `GetHomeDataUseCase`, `HomeRepositoryImpl`, and `HomeMockDataSource` (simulating 1.2s network latency). All UI components utilize design tokens (`AppColors`, `AppTypography`, `AppSpacing`) and responsive scaling (`flutter_screenutil`).

---

## 2. Technical Context & Constitution Check

- **Language/Version**: Dart 3.x / Flutter 3.x (managed via FVM)
- **Primary Dependencies**: `flutter_bloc`, `get_it`, `go_router`, `flutter_screenutil`, `shimmer`, `equatable`, `dartz`
- **Storage/Data**: Structured mock data via `HomeMockDataSourceImpl` with simulated 1.2s delay
- **Target Platform**: Mobile (Android & iOS)
- **Architecture**: Feature-First Clean Architecture (Presentation → Domain ← Data)

### Constitution Check Gates (PASS)
- ✅ **Principle I (Existing Architecture Preservation)**: Modules added under `lib/features/home/` extending standard structure.
- ✅ **Principle II (Clean Architecture & Data Safety)**: Domain entities decoupled; repository returns `Either<Failure, HomeDataEntity>`; DI registered in `GetIt`.
- ✅ **Principle III (Figma Pixel-Perfection)**: All sizing uses `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`); design tokens from `lib/core/theme/` strictly applied.
- ✅ **Principle IV (Strict UI & State Separation)**: Zero business logic in widgets; state management handled by `HomeCubit`; immutable states extending `Equatable`.
- ✅ **Principle V (Router & Shell Navigation)**: Home route mounted inside `ShellRoute` in `app_router.dart`.

---

## 3. Project Structure: `lib/features/home/`

```text
lib/features/home/
├── home_injection.dart                       # Dependency Injection registration
├── data/
│   ├── datasources/
│   │   ├── home_mock_datasource.dart          # Abstract datasource contract
│   │   └── home_mock_datasource_impl.dart     # Mock implementation with 1.2s latency
│   ├── models/
│   │   ├── home_banner_model.dart             # Banner JSON model
│   │   ├── category_model.dart                # Category JSON model
│   │   ├── product_model.dart                 # Product JSON model
│   │   └── home_data_model.dart               # Aggregate data model
│   └── repositories/
│       └── home_repository_impl.dart          # Repository implementation
├── domain/
│   ├── entities/
│   │   ├── home_banner_entity.dart            # Banner domain entity
│   │   ├── category_entity.dart               # Category domain entity
│   │   ├── product_entity.dart                # Product domain entity
│   │   └── home_data_entity.dart              # Aggregate domain entity
│   ├── repositories/
│   │   └── home_repository.dart               # Abstract repository interface
│   └── usecases/
│       └── get_home_data_usecase.dart         # UseCase fetching home catalog
└── presentation/
    ├── cubit/
    │   ├── home_cubit.dart                    # Home State Management Cubit
    │   └── home_state.dart                    # Home State variants (Equatable)
    ├── pages/
    │   └── home_page.dart                     # Home View composition (< 80 lines)
    └── widgets/
        ├── home_app_bar.dart                  # Section 1: Top AppBar & Search bar
        ├── home_hero_banner.dart              # Section 2: Big Sale Hero Banner & Dots
        ├── home_section_header.dart           # Section 3: Reusable Header + See All
        ├── category_card.dart                 # Section 3: Category dual-preview card
        ├── top_products_bar.dart              # Section 4: Horizontal Top Products bar
        ├── product_card_standard.dart         # Section 5 & 8: Standard Product card
        ├── flash_sale_timer.dart              # Section 6: Countdown timer widget
        ├── flash_sale_card.dart               # Section 6: Flash sale discount card
        ├── popular_product_card.dart          # Section 7: Most popular heart/tag card
        └── home_shimmer_loading.dart          # Shimmer loading placeholder
```

---

## 4. Implementation Order & Priority

1. **Domain Layer**: Define entities (`HomeBannerEntity`, `CategoryEntity`, `ProductEntity`, `HomeDataEntity`), abstract `HomeRepository` contract, and `GetHomeDataUseCase`.
2. **Data Layer**: Implement models (`HomeBannerModel`, `CategoryModel`, `ProductModel`, `HomeDataModel`), `HomeMockDataSourceImpl` with mock dataset, and `HomeRepositoryImpl`.
3. **Presentation Cubit**: Implement `HomeState` variants and `HomeCubit` triggering `getHomeData()`.
4. **Presentation Widgets**: Implement 10 modular section widgets under `lib/features/home/presentation/widgets/`.
5. **Presentation Page**: Assemble `HomePage` composing all 9 sections inside `CustomScrollView` / `SingleChildScrollView`.
6. **DI & Routing**: Register DI in `home_injection.dart` / `injection_container.dart` and wire `/home` in `app_router.dart` `ShellRoute`.

---

## 5. DI & Routing Plan

### 5.1 Dependency Injection (`home_injection.dart`)
```dart
final sl = GetIt.instance;

void initHomeInjections() {
  // Cubit
  sl.registerFactory(() => HomeCubit(getHomeDataUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(mockDataSource: sl()),
  );

  // DataSources
  sl.registerLazySingleton<HomeMockDataSource>(
    () => HomeMockDataSourceImpl(),
  );
}
```

### 5.2 Routing (`app_router.dart`)
Mounted inside `ShellRoute` at path `/home` returning `HomePage()`.

---

## 6. Git Commit Strategy & Quality Gates

### Commit Stages
1. `feat(home): add domain entities, repository contract, and usecases`
2. `feat(home): add data models, mock data source, and repository implementation`
3. `feat(home): add home cubit and states`
4. `feat(home): add modular presentation section widgets`
5. `feat(home): assemble home page, configure routing and di`

### Quality Gates
- **Static Analysis**: `fvm flutter analyze` must pass with 0 errors and 0 warnings.
- **Pixel-Perfection**: Visual check against Figma design tokens (`AppColors`, `AppTypography`, `flutter_screenutil`).
- **Clean Architecture**: Presentation layer must contain zero data calls or business logic.
