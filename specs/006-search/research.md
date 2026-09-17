# Phase 0 Research: Search Feature (Screens 28, 29, 30, 31, 32)

## 1. Context & Objectives
The Search feature provides comprehensive text-based and visual/image-based search capabilities for the E-Store mobile app:
- **Text-based Search (Screens 28, 29)**: Recent search history chips with a clear-all red trash trigger, recommendation chips, a horizontal Discover product carousel, and a 2-column search results grid with discount pricing and filter modal access.
- **Image-based Search (Screens 30, 31, 32)**: Simulated camera/gallery capture, an object recognition state with a black selection frame and Retry button, and a slide-up modal bottom sheet showing detected category verification ("Is this what you meant?") and visually similar product results.

This document records the architectural and technical decisions resolving all implementation choices under the project Constitution v1.1.0 and Permanent Project Rules.

---

## 2. Technical Decisions & Research

### Decision 1: Feature Modular Structure
- **Decision**: Scaffold `lib/features/search/` using Feature-First Clean Architecture (`domain/` ← `presentation/` and `domain/` ← `data/`), with a dedicated service locator configuration `search_injection.dart`.
- **Rationale**: Strictly complies with Constitution Principle II and replicates patterns established in `lib/features/categories/` and `lib/features/shop/`.
- **Alternatives Considered**: Merging search into `feature/shop` was rejected because Search is a major independent subsystem with its own lifecycle, history persistence, and visual recognition flows.

### Decision 2: State Management Partitioning (SearchCubit & ImageSearchCubit)
- **Decision**: Split presentation logic into two focused Cubits:
  1. `SearchCubit`: Manages main search state (initial data load, recent history mutation, recommendation selection, query submission, and results filtering).
  2. `ImageSearchCubit`: Manages visual search lifecycle (idle capture, capture triggering, object recognition frame, modal sheet results display, and retry reset).
- **Rationale**: Adheres to Single Responsibility Principle. Image search has a distinct modal/capture lifecycle separate from text query execution, keeping states clean, testable, and strictly immutable via `Equatable`.

### Decision 3: Mock Image Search Without Hardware Plugins (Phase 1)
- **Decision**: Simulate camera capture and gallery picking using static mock assets from `assets/images/` (e.g. `cat_cloth_1.png` or `girl_image.png`) with simulated asynchronous delay (300–500ms) to model recognition.
- **Rationale**: Complies with Phase 1 constraints and Permanent Rule 2 (no external camera/gallery plugins required in Phase 1, no new placeholder asset files generated). Allows 100% pixel-perfect verification of Screens 30, 31, and 32 UI and state flows.

### Decision 4: Reuse Filter Modal from `feature/shop` (Screen 33)
- **Decision**: Directly invoke `FilterModalSheet.show(context, categories: ..., initialCriteria: ...)` from `lib/features/shop/presentation/pages/filter_modal_sheet.dart` when the gear icon (`⚙`) is tapped on Screen 29.
- **Rationale**: Satisfies explicit user requirement ("Reuse the Filter modal from feature/shop for Screen 29's gear icon... Do NOT create a duplicate filter") and Permanent Rule 6 (Component Reuse).

### Decision 5: Shared Product Entity & Card Reuse
- **Decision**: Reuse `ShopProductEntity` from `lib/features/shop/domain/entities/` and `ShopProductCard` from `lib/features/shop/presentation/widgets/`.
- **Rationale**: `ShopProductCard` already provides the exact 16.r image container, two-line title styling, Raleway bold price typography, and coral red (`#FF5790`) strikethrough discount layout required by Screens 28, 29, and 32. Eliminates duplication and guarantees visual consistency.

### Decision 6: Routing & Shell Placement
- **Decision**:
  - `/search` (Screen 28): Mounted within the primary app navigation shell (Branch 0 / Home) so that the persistent bottom navigation bar remains visible with Home active.
  - `/search/results` (Screen 29): Mounted with query parameter `q` within shell navigation.
  - `/search/image` (Screen 30): Mounted as a full-screen route outside the bottom navigation shell (camera viewports require unobstructed screen estate).
  - Screen 31 (Recognized) and Screen 32 (Results): Managed within `ImageSearchPage` / `ImageSearchCubit` via animated view switching and `showModalBottomSheet`.
- **Rationale**: Cleanly matches the visual requirements of Screen 28 (bottom nav bar present) vs Screens 30–32 (full-screen immersive camera experience).
