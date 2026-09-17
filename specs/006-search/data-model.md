# Data Model: Search Feature (Screens 28, 29, 30, 31, 32)

## 1. Domain Entities (`lib/features/search/domain/entities/`)

### SearchHistoryEntity
Represents an individual search query record in search history.
- `id` (String): Unique query entry identifier
- `query` (String): Search keyword (e.g. `'Socks'`, `'Red Dress'`, `'Sunglasses'`)
- `timestamp` (DateTime): Timestamp of search query execution
- Extends: `Equatable`

### RecommendationEntity
Represents a curated search query recommendation chip.
- `id` (String): Unique identifier
- `label` (String): Recommended keyword (e.g. `'Skirt'`, `'Accessories'`, `'Black T-Shirt'`)
- Extends: `Equatable`

### SearchDataEntity
Aggregated data model supplying Screen 28 (Search Main).
- `history` (List<SearchHistoryEntity>): Recent search queries (5 initial chips)
- `recommendations` (List<RecommendationEntity>): Curated recommendations (5 chips)
- `discoverProducts` (List<ShopProductEntity>): Curated products for the horizontal Discover carousel
- Extends: `Equatable`

### ImageSearchResultEntity
Represents the result of visual image recognition.
- `id` (String): Unique result identifier
- `imagePath` (String): Path to the captured or selected image asset
- `detectedCategory` (String): Recognized product category (e.g. `'Shoes'`)
- `confidence` (double): Recognition confidence rating (e.g. `0.94`)
- `products` (List<ShopProductEntity>): Visually similar matched products
- Extends: `Equatable`

### ShopProductEntity *(Reused)*
- Sourced from `lib/features/shop/domain/entities/shop_product_entity.dart`
- Attributes: `id`, `title`, `imageUrl`, `price`, `originalPrice`, `isDiscounted`, `category`, `subCategory`

---

## 2. Data Models (`lib/features/search/data/models/`)

### SearchHistoryModel
- Subclasses `SearchHistoryEntity`
- `factory SearchHistoryModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`
- `factory SearchHistoryModel.fromEntity(SearchHistoryEntity entity)`

### RecommendationModel
- Subclasses `RecommendationEntity`
- `factory RecommendationModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`
- `factory RecommendationModel.fromEntity(RecommendationEntity entity)`

### ImageSearchResultModel
- Subclasses `ImageSearchResultEntity`
- `factory ImageSearchResultModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`
- `factory ImageSearchResultModel.fromEntity(ImageSearchResultEntity entity)`

---

## 3. UI State Models (`lib/features/search/presentation/cubit/`)

### SearchState (`search_state.dart`)
- **SearchInitial**: Baseline initial state.
- **SearchLoading**: Emitted while loading initial history, recommendations, and discover items.
- **SearchLoaded**:
  - `history` (List<SearchHistoryEntity>): Current search history chips.
  - `recommendations` (List<RecommendationEntity>): Recommendation chips.
  - `discoverProducts` (List<ShopProductEntity>): Products for Discover carousel.
- **SearchResultsLoading**: Emitted while executing a text search query or applying filters.
- **SearchResultsLoaded**:
  - `query` (String): Active search query.
  - `results` (List<ShopProductEntity>): Matching products in 2-column grid.
  - `appliedFilter` (FilterCriteriaEntity?): Active filter criteria from `feature/shop`.
- **SearchError**:
  - `failure` (Failure): Error failure model.

### ImageSearchState (`image_search_state.dart`)
- **ImageSearchInitial**: Initial camera capture ready state (Screen 30).
- **ImageSearchCapturing**: Transient state while processing capture / picking photo.
- **ImageSearchRecognized**: Product detected, bounding frame active, Retry enabled (Screen 31).
  - `imagePath` (String): Asset path of the captured image.
  - `result` (ImageSearchResultEntity): Recognized category and visually similar products.
- **ImageSearchResultsSheetVisible**: Modal bottom sheet open showing results (Screen 32).
  - `imagePath` (String)
  - `result` (ImageSearchResultEntity)
- **ImageSearchError**:
  - `failure` (Failure): Error failure model.
