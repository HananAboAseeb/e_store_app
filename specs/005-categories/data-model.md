# Data Model: Categories Feature (Screen 27 & Screen 43 Enhancement)

## 1. Domain Entities

### CategoryGroupEntity (`lib/features/categories/domain/entities/`)
Represents a top-level category group in the accordion list (Screen 27).
- `id` (String): Unique identifier (e.g. `'clothing'`, `'shoes'`, `'bags'`, `'accesories'`)
- `name` (String): Display title (e.g. `'Clothing'`, `'Shoes'`, `'Bags'`, `'Accesories'`)
- `icon` (dynamic / IconData / String): Category icon reference
- `gender` (GenderFilter): Associated department (`all`, `female`, `male`)
- `subCategories` (List<SubCategoryEntity>): Child sub-categories
- `isExpanded` (bool): Transient expansion flag
- Extends: `Equatable`

### SubCategoryEntity (`lib/features/categories/domain/entities/`)
Represents an individual sub-category pill inside an expanded category (Screen 27).
- `id` (String): Unique identifier (e.g. `'dresses'`, `'pants'`, `'t_shirts'`)
- `name` (String): Display label (e.g. `'Dresses'`, `'Pants'`, `'T-Shirts'`)
- `parentGroupId` (String): Parent category group ID (e.g. `'clothing'`)
- Extends: `Equatable`

### GenderFilter (Enum) (`lib/features/categories/domain/entities/`)
- `all`: All categories
- `female`: Female department categories
- `male`: Male department categories

### ShopProductEntity (`lib/features/shop/domain/entities/shop_product_entity.dart`)
*Reused directly from `feature/shop` for Screen 43 product recommendations (DRY).*
- `id` (String): Unique product ID (e.g. `'jfy-1'`)
- `title` (String): Product title (e.g. `'Lorem ipsum dolor sit amet consectetur'`)
- `imageUrl` (String): Asset path (e.g. `'assets/images/cat_cloth_1.png'`)
- `price` (double): Current display price (e.g. `17.00`)
- `originalPrice` (double?): Original strikethrough price if discounted (e.g. `24.00`)
- `isDiscounted` (bool): Flag indicating active discount
- `category` (String): Category association
- `subCategory` (String): Sub-category association
- `sizes` (List<String>): Available sizes
- `colors` (List<String>): Available colors
- `isPopular` (bool): Popular flag
- `createdAt` (DateTime): Creation timestamp
- Extends: `Equatable`

---

## 2. Data Models

### CategoryGroupModel (`lib/features/categories/data/models/`)
- Subclasses `CategoryGroupEntity`
- `factory CategoryGroupModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`

### SubCategoryModel (`lib/features/categories/data/models/`)
- Subclasses `SubCategoryEntity`
- `factory SubCategoryModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`

### ShopProductModel (`lib/features/shop/data/models/shop_product_model.dart`)
*Reused directly from `feature/shop` for mock data generation.*
- Subclasses `ShopProductEntity`
- `factory ShopProductModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`

---

## 3. UI State Models (`lib/features/categories/presentation/cubit/categories_state.dart`)

### CategoriesState (Equatable)
Base abstract state extended by all Category and Just For You states.

#### Screen 27 States
- **CategoriesInitial**: Initial baseline state.
- **CategoriesLoading**: Emitted while loading category groups.
- **CategoriesLoaded**:
  - `groups` (List<CategoryGroupEntity>): All category groups for active department.
  - `activeGender` (GenderFilter): Currently selected gender tab (`all`, `female`, `male`).
  - `expandedGroupId` (String?): ID of expanded category group (default: `'clothing'`).
- **CategoriesError**:
  - `message` (String): User-friendly error message.

#### Screen 43 States (Just For You Feed)
- **JustForYouLoading**: Emitted while fetching personalized product recommendations.
- **JustForYouLoaded**:
  - `products` (List<ShopProductEntity>): Curated list of recommended products.
- **JustForYouError**:
  - `message` (String): Error message with retry capability.
