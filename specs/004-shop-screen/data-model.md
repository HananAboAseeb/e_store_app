# Data Model: Shop Feature (Screens 25, 26, 33)

## 1. Domain Entities (`lib/features/shop/domain/entities/`)

### ShopProductEntity
Represents a catalog product in the Shop screen.
- `id` (String): Unique identifier
- `title` (String): Product display title (e.g. `Lorem ipsum dolor sit amet consectetur`)
- `price` (double): Current price (e.g. `16.0`)
- `originalPrice` (double?): Original pre-discount price if on sale (e.g. `20.0`)
- `imageUrl` (String): Asset path or image URL
- `isDiscounted` (bool): Whether item is on sale
- `category` (String): Department (e.g. `Clothing`)
- `subCategory` (String): Sub-category (e.g. `Dresses`, `Pants`, `T-shirts`)
- `sizes` (List<String>): Available sizes (e.g. `['XS', 'S', 'M', 'L']`)
- `colors` (List<String>): Available hex/color keys
- `isPopular` (bool): Flag for sorting by popular
- `createdAt` (DateTime): Timestamp for sorting by newest
- Extends: `Equatable`

### ShopCategoryEntity
Represents an apparel sub-category tile.
- `id` (String): Identifier
- `name` (String): Sub-category name (`Dresses`, `Pants`, `Skirts`, `Tunics`, `Jackets`, `Hoodies`, `Shirts`, `Polo`, `T-shirts`)
- `assetPath` (String): Image illustration path
- `isSelected` (bool): Active selection status in Filter
- Extends: `Equatable`

### FilterCriteriaEntity
Represents the active or draft filter configuration.
- `selectedSubCategories` (List<String>): Multi-select sub-category names
- `sizeType` (String): Active size segment (`Clothes` or `Shoes`)
- `selectedSize` (String?): Active size code (e.g. `M`)
- `selectedColor` (String?): Active color key
- `minPrice` (double): Min price bound (default `10.0`)
- `maxPrice` (double): Max price bound (default `150.0`)
- `sortOption` (ShopSortOption): `popular`, `newest`, `priceHighToLow`
- Extends: `Equatable`

---

## 2. Data Models (`lib/features/shop/data/models/`)

### ShopProductModel
- Subclasses `ShopProductEntity`
- `factory ShopProductModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`

### ShopCategoryModel
- Subclasses `ShopCategoryEntity`
- `factory ShopCategoryModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`

---

## 3. UI State Models (`lib/features/shop/presentation/cubit/`)

### ShopState (Equatable)
- **ShopInitial**: Idle baseline
- **ShopLoading**: Active while loading initial products/categories
- **ShopLoaded**:
  - `products`: List<ShopProductEntity> (filtered)
  - `allProducts`: List<ShopProductEntity>
  - `categories`: List<ShopCategoryEntity>
  - `activeFilter`: FilterCriteriaEntity
  - `activeSubCategory`: String?
- **ShopError**:
  - `message`: String

### FilterState (Equatable)
- `selectedSubCategories`: List<String>
- `sizeType`: String ('Clothes' / 'Shoes')
- `selectedSize`: String?
- `selectedColor`: String?
- `minPrice`: double
- `maxPrice`: double
- `sortOption`: ShopSortOption
- Includes `copyWith(...)` and `factory FilterState.fromCriteria(...)`
