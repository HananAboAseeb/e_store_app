# Data Model & Domain Entities: Home (Shop Screen)

**Feature**: `002-home-shop-screen`  
**Date**: 2026-08-29  

---

## 1. Domain Entities (`lib/features/home/domain/entities/`)

### 1.1 `HomeBannerEntity`
Represents promotional campaign banners displayed in the hero carousel.
- `id` (`String`): Unique banner identifier
- `title` (`String`): Headline text e.g. `"Big Sale"`
- `subtitle` (`String`): Sub-headline text e.g. `"Up to 50%"`
- `imageUrl` (`String`): Asset image path e.g. `'assets/images/image1.png'`
- `discountPercentage` (`int`): Discount amount e.g. `50`
- `backgroundColor` (`String`): Hex background color token

### 1.2 `CategoryEntity`
Represents top-level shopping categories.
- `id` (`String`): Category ID e.g. `'cat_clothings'`
- `name` (`String`): Category display name e.g. `"Clothings"`, `"Shoes"`, `"Bags"`
- `itemCount` (`int`): Total available items e.g. `109`, `530`, `87`
- `previewImageUrls` (`List<String>`): List of exactly 2 preview image asset paths

### 1.3 `ProductEntity`
Represents individual products across various home sections (New Items, Flash Sale, Most Popular, Stuff For You).
- `id` (`String`): Product ID
- `title` (`String`): Product title (e.g. `"Lorem ipsum dolor sit amet consectetur"`)
- `price` (`double`): Numerical price value e.g. `17.00`
- `imageUrl` (`String`): Asset image path
- `discountPercentage` (`int?`): Optional discount e.g. `20` (for Flash Sale)
- `likeCount` (`int?`): Optional blue heart like count e.g. `1780` (for Most Popular)
- `tag` (`String?`): Optional status tag e.g. `"New"`, `"Sale"`, `"Hot"`
- `isFavorite` (`bool`): User wishlist status

### 1.4 `HomeDataEntity`
Aggregate entity containing all catalog collections for the Home viewport.
- `banners` (`List<HomeBannerEntity>`)
- `categories` (`List<CategoryEntity>`)
- `topProducts` (`List<ProductEntity>`)
- `newItems` (`List<ProductEntity>`)
- `flashSaleProducts` (`List<ProductEntity>`)
- `popularProducts` (`List<ProductEntity>`)
- `stuffForYouProducts` (`List<ProductEntity>`)

---

## 2. Data Models (`lib/features/home/data/models/`)

Data models extend domain entities and provide serialization logic (`fromJson`, `toJson`, `toEntity`):
- `HomeBannerModel extends HomeBannerEntity`
- `CategoryModel extends CategoryEntity`
- `ProductModel extends ProductEntity`
- `HomeDataModel extends HomeDataEntity`
