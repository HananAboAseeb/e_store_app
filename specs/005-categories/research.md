# Phase 0 Research: Categories Feature (Screen 27)

## 1. Context & Objectives
The Categories feature provides a full-screen modal/panel (Screen 27) displaying all product categories grouped by department (`All`, `Female`, `Male`). It incorporates an accordion layout enabling users to expand one category at a time to reveal its sub-categories, with `Clothing` expanded by default (10 sub-categories in 2 columns), collapsed category rows (`Shoes`, `Bags`, `Accesories`), a dedicated "Just for you" card, and seamless routing to the filtered catalog.

This document resolves technical decisions, component patterns, and architectural alignments under the E-Store Constitution v1.1.0.

---

## 2. Technical Decisions & Research

### Decision 1: Feature Modular Structure
- **Decision**: Create `lib/features/categories/` following Feature-First Clean Architecture (`presentation/` → `domain/` ← `data/`) with a dedicated DI file `categories_injection.dart`.
- **Rationale**: Complies strictly with Constitution Principle II. Replicates canonical patterns established in `lib/features/home/` and `lib/features/shop/`.

### Decision 2: Accordion Single-Expansion Management
- **Decision**: Manage category expansion strictly inside `CategoriesCubit` through state holding `expandedGroupId` (initialized to `'clothing'`).
- **Rationale**: Centralizing accordion state in the Cubit ensures single-expansion mutual exclusion (tapping group B closes group A) and enables smooth, predictable animations without widget-local state leaks. Expansion transitions will use `AnimatedCrossFade` or `AnimatedSize` (200–250ms with `Curves.easeInOut`).

### Decision 3: Department / Gender Tab Architecture
- **Decision**: Model departments using a strongly typed enum `GenderFilter { all, female, male }`. Active tab displays Primary 400 (`#004BFE`) border, white background, and blue text; inactive tabs use `#F5F5F5` surface fill with neutral text.
- **Rationale**: Matches Screen 27 visual reference (`27_CATEGORIES_FILTER.png`). Tapping a tab triggers `CategoriesCubit.selectGender(filter)` which filters/refreshes category groups.

### Decision 4: Sub-Category Grid & Touch Feedback
- **Decision**: Sub-categories under `Clothing` render in a 2-column grid (`SliverGrid` or `Wrap`/row layout) of 10 items (Dresses, Skirts, Jackets, Shirts, T-Shirts / Pants, Shorts, Hoodies, Polo, Tunics). Each pill uses `#F5F5F5` background, `12.r` radius, and 44dp minimum touch target.
- **Rationale**: Exactly mirrors the layout in Screen 27. Tapping navigates to `/catalog?subCategory=<name>`.

### Decision 5: "Just for you" Row Presentation
- **Decision**: Implement `JustForYouCard` as a distinct widget displaying a Primary 400 star icon on the left and a circular `#004BFE` button with a white forward arrow (`→`) on the right.
- **Rationale**: Exactly mirrors Screen 27. Tapping navigates to `/catalog?filter=just_for_you`.

### Decision 6: Navigation & Router Registration
- **Decision**: Register `/categories` in `RouteNames.kCategoriesPage` as a top-level route in `app_router.dart`, allowing push/pop modal transitions with `context.pop()` for the `✕` close button.
- **Rationale**: Keeps the modal distinct from shell tabs while enabling entry from home, shop, or search banners.
