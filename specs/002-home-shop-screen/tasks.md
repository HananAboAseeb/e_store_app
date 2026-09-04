# Tasks: Home (Shop Screen)

**Feature Branch**: `feature/home` | **Spec Directory**: `specs/002-home-shop-screen`  
**Input**: Design documents from `specs/002-home-shop-screen/` (`plan.md`, `spec.md`, `data-model.md`, `contracts/`, `quickstart.md`)  
**Prerequisites**: Auth flow complete, Core tokens and DI infrastructure ready  

---

## Phase 1: Domain Layer

- [x] T001 [P] Create domain entities (`HomeBannerEntity`, `CategoryEntity`, `ProductEntity`, `HomeDataEntity`) in `lib/features/home/domain/entities/home_data_entity.dart`
- [x] T002 [P] Create domain repository interface `HomeRepository` in `lib/features/home/domain/repositories/home_repository.dart`
- [x] T003 Create use case `GetHomeDataUseCase` in `lib/features/home/domain/usecases/get_home_data_usecase.dart` (depends on T001, T002)

---

## Phase 2: Data Layer + DI

- [x] T004 [P] Create data models (`HomeBannerModel`, `CategoryModel`, `ProductModel`, `HomeDataModel`) in `lib/features/home/data/models/home_data_model.dart`
- [x] T005 [P] Create mock datasource interface and implementation with realistic dataset in `lib/features/home/data/datasources/home_mock_datasource.dart` and `lib/features/home/data/datasources/home_mock_datasource_impl.dart`
- [x] T006 Create `HomeRepositoryImpl` in `lib/features/home/data/repositories/home_repository_impl.dart` wrapping datasource calls with `safeCall` error handling (depends on T004, T005)
- [x] T007 Create `HomeState` variants (`HomeInitial`, `HomeLoading`, `HomeLoaded`, `HomeError`) and `HomeCubit` in `lib/features/home/presentation/cubit/home_cubit.dart` and `lib/features/home/presentation/cubit/home_state.dart` (depends on T003)
- [x] T008 Register Home dependencies in `lib/features/home/home_injection.dart` and wire into `lib/core/di/injection_container.dart` (depends on T006, T007)

---

## Phase 3: Presentation Layer (MVP — ALL 9 Sections)

- [x] T009 [P] [US1] Implement `HomeAppBar` widget ("Shop" title `28.sp` bold + pill search bar `42.h` with blue camera icon) in `lib/features/home/presentation/widgets/home_app_bar.dart`
- [x] T010 [P] [US1] Implement `HomeHeroBanner` widget (Vibrant royal blue gradient card `180.h`, `24.r` radius + "Big Sale" + 6-dot carousel indicator with `24.w` active pill) in `lib/features/home/presentation/widgets/home_hero_banner.dart`
- [x] T011 [P] [US1] Implement `HomeSectionHeader` widget (Reusable section title + optional leading star icon + "See All" with blue circular arrow `28.w`) in `lib/features/home/presentation/widgets/home_section_header.dart`
- [x] T012 [P] [US1] Implement `CategoryCard` widget (2-column card `166.w` with dual image boxes `71.w × 72.h` + category name + count pill badge e.g. `"109"`) in `lib/features/home/presentation/widgets/category_card.dart`
- [x] T013 [P] [US1] Implement `TopProductsBar` widget (Horizontal scroll list of outfit thumbnails `68.w × 68.h`, `borderRadius: 16.r`) in `lib/features/home/presentation/widgets/top_products_bar.dart`
- [x] T014 [P] [US1] Implement `ProductCardStandard` widget (Product card with `borderRadius: 16.r`, 2-line title, bold price `"$17,00"`) in `lib/features/home/presentation/widgets/product_card_standard.dart`
- [x] T015 [P] [US1] Implement `PopularProductCard` widget (Horizontal card `120.w` with blue heart like count `"1780 💙"` + tag `"New"`/`"Sale"`/`"Hot"`) in `lib/features/home/presentation/widgets/popular_product_card.dart`
- [x] T016 [P] [US1] Implement `HomeShimmerLoading` widget (Shimmer placeholder mirroring exact section dimensions during loading) in `lib/features/home/presentation/widgets/home_shimmer_loading.dart`
- [x] T019 [P] [US1] Implement `FlashSaleTimer` widget (Stopwatch icon in blue `#004BFE` + 3 time boxes `[00] [36] [58]`) in `lib/features/home/presentation/widgets/flash_sale_timer.dart`
- [x] T020 [P] [US1] Implement `FlashSaleCard` widget (Square card `106.w × 106.h` with coral red `"-20 %"` discount badge overlay) in `lib/features/home/presentation/widgets/flash_sale_card.dart`
- [x] T021 [P] [US1] Implement `NewItemsSection` widget (Horizontal list with "See All" and ProductCardStandard items) in `lib/features/home/presentation/widgets/new_items_section.dart`
- [x] T022 [P] [US1] Implement `StuffForYouSection` widget (2-column vertical grid with star header and ProductCardStandard items) in `lib/features/home/presentation/widgets/stuff_for_you_section.dart`
- [x] T017 [US1] Implement `HomePage` in `lib/features/home/presentation/pages/home_page.dart` assembling ALL sections inside `SingleChildScrollView` (depends on T009-T022)
- [x] T018 [US1] Register `/home` route in `lib/config/routing/app_router.dart` inside the `ShellRoute` (depends on T017)

---

## Phase 4: Polish & Quality

- [x] T023 Implement Pull-to-Refresh & Scroll-to-Top feature in `lib/features/home/presentation/pages/home_page.dart`
- [x] T024 Execute `fvm flutter analyze` and ensure 0 errors and 0 warnings
- [x] T025 Perform manual pixel-by-pixel audit against Figma references (`home_screen.png` and `home_screen13.png`)
