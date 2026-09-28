# Phase 0 Research: Categories Feature (Screen 27 & Screen 43 Enhancement)

## 1. Context & Objectives
The Categories feature provides:
1. **Screen 27 (All Categories)**: Full-screen modal displaying product categories grouped by department (`All`, `Female`, `Male`) in an accordion layout with sub-categories (`Clothing` expanded by default with 10 sub-category pills in 2 columns; `Shoes`, `Bags`, `Accesories` collapsed), a dedicated "Just for you" row, and catalog navigation.
2. **Screen 43 ("Categories Just for you") Enhancement**: A dedicated recommendations screen accessible by tapping the blue arrow button (`→`) inside the "Just for you" row of Screen 27. It presents a bold "Categories" title, a prominent "★ Just for you" section header, and a vertically scrollable 2-column grid of curated product recommendation cards with sale/strikethrough pricing, smooth shimmer loading, and direct navigation to product details.

This document resolves technical decisions, component patterns, and architectural alignments under the E-Store Constitution v1.2.0 and Permanent Project Rules.

---

## 2. Technical Decisions & Research

### Decision 1: Feature Extension vs New Feature
- **Decision**: Extend existing `lib/features/categories/` and `specs/005-categories/`. Do NOT create a new feature module.
- **Rationale**: User explicit requirement. Screen 43 is a direct child/enhancement of Categories (Screen 27). Clean architecture boundary is preserved by extending existing domain, data, and presentation layers.

### Decision 2: Product Card & Grid Pattern Reuse (Strict DRY)
- **Decision**: Directly reuse `ShopProductCard` from `lib/features/shop/presentation/widgets/shop_product_card.dart` and `ShopProductEntity` from `lib/features/shop/domain/entities/shop_product_entity.dart`. Replicate the shop 2-column grid layout (`crossAxisCount: 2`, `childAspectRatio: 0.58`, `mainAxisSpacing: 16.h`, `crossAxisSpacing: 14.w`).
- **Rationale**: The visual card in Figma Screen 43 (`assets/design_references/43 CATEGORIES JUST FOR YOU.png`) is 100% identical in geometry, image container radius (`16.r`), typography, price formatting, and discount strikethrough (`#FF5790`) to `ShopProductCard`. Reusing it avoids code duplication and enforces project Rule 6.

### Decision 3: CategoriesRepository & UseCase Extension
- **Decision**:
  - Extend `CategoriesRepository` with `Future<Either<Failure, List<ShopProductEntity>>> getJustForYouProducts()`.
  - Add single-purpose use case `GetJustForYouProductsUseCase extends UseCase<List<ShopProductEntity>, NoParam>`.
  - Extend `CategoriesRepositoryImpl` to call `mockDataSource.getJustForYouProducts()` wrapped with `safeCall`.
- **Rationale**: Complies with Feature-First Clean Architecture and Constitution Principle II. Each operation is isolated into its own usecase.

### Decision 4: CategoriesCubit & State Extension
- **Decision**:
  - Extend existing `CategoriesCubit` by injecting `GetJustForYouProductsUseCase` alongside `GetCategoriesUseCase`.
  - Add method `Future<void> loadJustForYouProducts()` to `CategoriesCubit`.
  - Add dedicated states: `JustForYouLoading`, `JustForYouLoaded(List<ShopProductEntity> products)`, and `JustForYouError(String message)` to `categories_state.dart`.
  - In `categories_injection.dart`, `CategoriesCubit` is registered as a factory (`registerFactory`), ensuring `CategoriesPage` and `JustForYouPage` receive independent Cubit instances.
- **Rationale**: Guarantees that opening or navigating `JustForYouPage` does not disrupt or reload `CategoriesPage`'s category accordion or department tab state, while keeping all categories-related logic unified under one Cubit.

### Decision 5: Routing & "Just for You" Arrow Wiring
- **Decision**:
  - Add `kCategoriesJustForYouPage = '/categories/just-for-you'` in `RouteNames`.
  - Register as a sub-route under `/categories` (or sibling route) in `app_router.dart`.
  - In `categories_page.dart`, update `JustForYouCard(onTap: ...)` to call `context.push(RouteNames.kCategoriesJustForYouPage)`.
  - In `just_for_you_page.dart`, tapping any product card calls `context.push('/product/${product.id}')`, and back navigation uses standard AppBar/system pop.
- **Rationale**: Ensures standard `go_router` stack behavior where pressing back naturally returns to Screen 27 with intact state.

### Decision 6: Token Enforcement (Rule #11) & Phase 1 Mock Data
- **Decision**: All colors reference `AppColors`, spacing references `AppSpacing`, typography references `AppTypography`. Use local mock product data referencing existing image assets (`assets/images/cat_cloth_1.png`, `prod_20_1.png`, etc.) without creating new assets.
- **Rationale**: Fulfills Constitution Principle III, Rule 2 (no new assets), and Rule 11 (strict token compliance).
