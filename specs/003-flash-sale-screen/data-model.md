# Data Model: Flash Sale Screen Feature

## 1. Domain Entities (`lib/features/flash_sale/domain/entities/`)

### FlashSaleProductEntity
Represents a product listed in the flash sale.
- `id` (String): Unique identifier (e.g. `flash_1`)
- `title` (String): Product description/title (e.g. `Lorem ipsum dolor sit amet consectetur`)
- `currentPrice` (double): Discounted purchase price (e.g. `16.0`)
- `originalPrice` (double): Pre-discount price (e.g. `20.0`)
- `imageUrl` (String): Asset path or network URL (e.g. `assets/images/jact.png`)
- `discountPercentage` (int): Percentage off (e.g. `20` for `-20%`)
- `likeCount` (int?): Optional like/view counter
- `tag` (String?): Optional badge label (e.g. `Sale`, `Hot`, `New`)
- Extends: `Equatable` (`props: [id, title, currentPrice, originalPrice, imageUrl, discountPercentage, likeCount, tag]`)

### LiveStreamEntity
Represents the live streaming shopping event banner.
- `id` (String): Identifier
- `title` (String): Title (e.g. `ARTICALE REIMAGINED`)
- `bannerUrl` (String): Collage background image asset path
- `isLive` (bool): Whether event is actively streaming (defaults to `true`)
- `viewerCount` (int): Optional count of concurrent viewers
- Extends: `Equatable`

### FlashSaleDataEntity
Aggregate container for all initial screen data.
- `products` (List<FlashSaleProductEntity>): All flash sale items
- `liveStream` (LiveStreamEntity): Featured live stream details
- `popularProducts` (List<FlashSaleProductEntity>): Items for Most Popular carousel
- `countdownDuration` (Duration): Remaining flash sale duration (default: 36 min 58 sec)
- Extends: `Equatable`

---

## 2. Data Models (`lib/features/flash_sale/data/models/`)

### FlashSaleProductModel
- Subclasses `FlashSaleProductEntity`
- Implements `factory FlashSaleProductModel.fromJson(Map<String, dynamic> json)`
- Implements `Map<String, dynamic> toJson()`

### LiveStreamModel
- Subclasses `LiveStreamEntity`
- Implements `factory LiveStreamModel.fromJson(Map<String, dynamic> json)`
- Implements `Map<String, dynamic> toJson()`

### FlashSaleDataModel
- Subclasses `FlashSaleDataEntity`
- Implements `factory FlashSaleDataModel.fromJson(Map<String, dynamic> json)`
- Implements `Map<String, dynamic> toJson()`

---

## 3. UI State Models (`lib/features/flash_sale/presentation/cubit/`)

### FlashSaleState (Equatable)
- **FlashSaleInitial**: Initial idle state
- **FlashSaleLoading**: Active during initial mock data fetch (displays shimmer loading)
- **FlashSaleLoaded**:
  - `allProducts`: List<FlashSaleProductEntity>
  - `filteredProducts`: List<FlashSaleProductEntity>
  - `selectedDiscount`: int? (e.g. `20`, or `null` for "All")
  - `liveStream`: LiveStreamEntity
  - `popularProducts`: List<FlashSaleProductEntity>
  - `countdownDuration`: Duration
- **FlashSaleError**:
  - `message`: String
