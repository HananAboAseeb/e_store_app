# Implementation Plan: Search Feature (Screens 28, 29, 30, 31, 32)

**Branch**: `feature/search` | **Date**: 2026-09-16 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/006-search/spec.md` and Figma reference screenshots `28_SEARCH.png` (Search Main), `29_SEARCH_RESULTS.png` (Search Results), `30_IMAGE_SEARCH.png` (Image Search Capture), `31_IMAGE_RECOGNIZED.png` (Image Recognized Frame), and `32_IMAGE_SEARCH_RESULTS.png` (Image Search Results Modal Sheet).

---

## Summary

Implement the comprehensive **Search** feature encompassing:
1. **Screen 28 (Search Main)**: Header with inline camera trigger and dismiss button, Search History chips with red trash clear trigger, curated Recommendations chips, horizontal Discover product carousel, and bottom navigation integration.
2. **Screen 29 (Search Results - Text)**: Query input with inline clear (`✕`), filter modal trigger (`⚙`) reusing `FilterModalSheet` from `feature/shop`, and a 2-column results grid supporting regular and discounted pricing (`#FF5790` strikethrough).
3. **Screen 30 (Image Search - Capture)**: Full-screen image capture viewport with Gallery, Primary 400 blue Camera (`#004BFE`), and More controls.
4. **Screen 31 (Image Recognized)**: Bounding selection frame overlay surrounding detected merchandise with a white pill "Retry" button.
5. **Screen 32 (Image Search Results - Modal)**: Slide-up modal bottom sheet (`24.r` top radius) with detected category pill (`Shoes`), "Is this what you meant?" prompt, and 2-column visually similar product grid.

The implementation strictly follows Feature-First Clean Architecture (`lib/features/search/`), Cubit state management with Equatable, GetIt DI, and `go_router`.

---

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x  
**Primary Dependencies**: `flutter_bloc`, `get_it`, `dartz`, `equatable`, `flutter_screenutil`, `go_router`, `shimmer`  
**Storage**: Mock Data with in-memory state and simulated latency (Phase 1 UI-only)  
**Testing & Verification**: Static analysis and tests strictly deferred to final phase per Permanent Rule 1  
**Target Platform**: iOS & Android  
**Design Reference**: Figma screenshots 28, 29, 30, 31, 32 in `assets/design_references/`  
**Performance Goals**: 60 FPS smooth animations (frame overlay, sheet transition), <300ms query results rendering, zero layout overflows across `375.w`–`412.w`  

---

## Constitution Check

| Principle / Rule | Requirement | Compliance Status |
|---|---|---|
| **I. Architecture Preservation** | Follow `lib/features/`, `lib/core/`, `lib/config/` structure | ✅ PASS: Creates `lib/features/search/` matching canonical architecture |
| **II. Clean Architecture & Safety** | Decoupled domain, `Either<Failure, T>` via `dartz`, `safeCall` in repo impl | ✅ PASS: Complete layer separation and error wrapping |
| **III. Design Tokens & Pixel Perfection** | `AppColors`, `AppSpacing`, `AppTypography`, `flutter_screenutil` dimensions | ✅ PASS: 100% token usage and `.w, .h, .r, .sp` scaling |
| **IV. Strict UI & State Separation** | Cubit state management, Equatable states, shimmer loading | ✅ PASS: `SearchCubit` and `ImageSearchCubit`, immutable states, shimmer loading |
| **V. Router & Shell Navigation** | Registered in `go_router`, clean push/pop, bottom nav preserved | ✅ PASS: `/search` mounted in shell branch 0, `/search/image` full-screen route |
| **Permanent Rules 1–10** | Deferred verification, no new assets, mock data only, widget reuse (`ShopProductCard`, `FilterModalSheet`) | ✅ PASS: Reuses existing assets and components without duplication |

---

## Project Structure

### Documentation Artifacts
```text
specs/006-search/
├── spec.md              # Feature specification
├── plan.md              # Implementation plan (this file)
├── research.md          # Phase 0 technical decisions
├── data-model.md        # Phase 1 domain entities, models, and UI states
├── quickstart.md        # Phase 1 validation guide
├── contracts/
│   └── search_contracts.md # Repository, UseCase, DataSource, and Cubit contracts
└── checklists/
    └── requirements.md  # Specification quality checklist
```

### Source Code (`lib/`)
```text
lib/features/search/
├── search_injection.dart
├── data/
│   ├── datasources/
│   │   ├── search_mock_datasource.dart
│   │   └── search_mock_datasource_impl.dart
│   ├── models/
│   │   ├── search_history_model.dart
│   │   ├── recommendation_model.dart
│   │   └── image_search_result_model.dart
│   └── repositories/
│       └── search_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── search_history_entity.dart
│   │   ├── recommendation_entity.dart
│   │   ├── search_data_entity.dart
│   │   └── image_search_result_entity.dart
│   ├── repositories/
│   │   └── search_repository.dart
│   └── usecases/
│       ├── get_search_data_usecase.dart
│       ├── search_by_text_usecase.dart
│       ├── search_by_image_usecase.dart
│       └── clear_search_history_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── search_cubit.dart
    │   ├── search_state.dart
    │   ├── image_search_cubit.dart
    │   └── image_search_state.dart
    ├── pages/
    │   ├── search_page.dart                 # Screen 28 (Main Search)
    │   ├── search_results_page.dart         # Screen 29 (Results Grid)
    │   └── image_search_page.dart           # Screens 30 & 31 (Capture & Recognized Frame)
    └── widgets/
        ├── search_header.dart               # Search bar with camera & dismiss cross
        ├── search_chip.dart                 # Rounded chip for history & recommendations
        ├── search_history_section.dart      # History header + red trash icon + chips
        ├── search_recommendations_section.dart # Recommendations header + chips
        ├── search_discover_carousel.dart    # Horizontal discover carousel
        ├── search_results_header.dart       # Query field with inline X + filter gear icon
        ├── search_shimmer_loading.dart      # Shimmer loading for main & results
        ├── image_search_controls.dart       # 3 circular buttons (Gallery, Camera, More)
        ├── image_selection_frame.dart       # Black rounded rectangle bounding overlay
        └── image_search_results_sheet.dart  # Screen 32 modal bottom sheet
```

### Modified Core & Config Files
- `lib/config/routing/route_names.dart`: Add `kSearchPage`, `kSearchResultsPage`, `kImageSearchPage`.
- `lib/config/routing/app_router.dart`: Register routes for `SearchPage`, `SearchResultsPage`, and `ImageSearchPage`.
- `lib/core/di/injection_container.dart`: Call `initSearch()`.

---

## Implementation Steps

### 1. Domain Layer (`lib/features/search/domain/`)
- Create `SearchHistoryEntity`, `RecommendationEntity`, `SearchDataEntity`, and `ImageSearchResultEntity` extending `Equatable`.
- Define abstract `SearchRepository` contract returning `Either<Failure, T>`.
- Implement Use Cases:
  - `GetSearchDataUseCase`
  - `SearchByTextUseCase`
  - `SearchByImageUseCase`
  - `ClearSearchHistoryUseCase`

### 2. Data Layer (`lib/features/search/data/`)
- Implement `SearchHistoryModel`, `RecommendationModel`, and `ImageSearchResultModel` with JSON mapping and entity conversion.
- Implement `SearchMockDataSource` and `SearchMockDataSourceImpl` providing:
  - 5 search history items (`Socks`, `Red Dress`, `Sunglasses`, `Mustard Pants`, `80's Skirt`)
  - 5 recommendation items (`Skirt`, `Accessories`, `Black T-Shirt`, `Jeans`, `White Shoes`)
  - Curated Discover products with `$17,00` pricing
  - Text search query filtering returning `ShopProductModel` items (with regular and `$16,00` / `$20,00` discounted pricing)
  - Visual image recognition mock result detecting category `Shoes` (or apparel) with matched items
- Implement `SearchRepositoryImpl` wrapping remote mock calls with `safeCall`.

### 3. Presentation Layer (`lib/features/search/presentation/`)
- **State Management**:
  - Implement `SearchState` and `SearchCubit` managing initial data loading, query submission, history clearing, and query text clearing.
  - Implement `ImageSearchState` and `ImageSearchCubit` managing capture trigger, object recognition frame, retry reset, and modal sheet presentation.
- **Widgets**:
  - `SearchHeader`: Rounded `#F5F5F5` field with camera icon and dismiss cross (`✕`).
  - `SearchChip`: Rounded grey pill button with label and onTap handler.
  - `SearchHistorySection`: Header with red trash icon (`#FF3B30`) and history chips.
  - `SearchRecommendationsSection`: Header and recommendation chips.
  - `SearchDiscoverCarousel`: Horizontal carousel reusing `ShopProductCard`.
  - `SearchResultsHeader`: Query field with inline clear cross (`✕`) and filter gear button (`⚙`).
  - `ImageSearchControls`: 3 bottom circular buttons (Gallery, Primary 400 blue Camera `#004BFE`, More).
  - `ImageSelectionFrame`: Black rounded bounding box overlay with "Retry" button.
  - `ImageSearchResultsSheet`: Modal bottom sheet with detected category chip, "Is this what you meant?", and 2-column product grid.
  - `SearchShimmerLoading`: Shimmer skeleton for smooth loading states.
- **Pages**:
  - `SearchPage` (Screen 28): Assembles header, history, recommendations, discover, and shimmer states.
  - `SearchResultsPage` (Screen 29): Search field, gear filter button opening `FilterModalSheet`, and 2-column product grid.
  - `ImageSearchPage` (Screens 30 & 31): Immersive capture viewport switching dynamically to the recognized selection frame state, with `ImageSearchResultsSheet` (Screen 32) presented as a modal bottom sheet.

### 4. Dependency Injection & Routing
- Create `search_injection.dart` registering DataSource, Repository, UseCases, and Cubits in GetIt.
- Register `initSearch()` in `lib/core/di/injection_container.dart`.
- Add routes in `lib/config/routing/route_names.dart` and `lib/config/routing/app_router.dart`.

---

## Permanent Project Rules Reference

All implementations for this feature MUST strictly adhere to the Permanent Project Rules from `.specify/instructions/permanent-project-rules.md`:
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
