# Data Model: Categories Feature (Screen 27)

## 1. Domain Entities (`lib/features/categories/domain/entities/`)

### CategoryGroupEntity
Represents a top-level category group in the accordion list.
- `id` (String): Unique identifier (e.g. `'clothing'`, `'shoes'`, `'bags'`, `'accesories'`)
- `name` (String): Display title (e.g. `'Clothing'`, `'Shoes'`, `'Bags'`, `'Accesories'`)
- `icon` (dynamic / IconData / String): Category icon reference
- `gender` (GenderFilter): Associated department (`all`, `female`, `male`)
- `subCategories` (List<SubCategoryEntity>): Child sub-categories (empty if collapsed or none)
- `isExpanded` (bool): Transient expansion flag
- Extends: `Equatable`

### SubCategoryEntity
Represents an individual sub-category pill inside an expanded category.
- `id` (String): Unique identifier (e.g. `'dresses'`, `'pants'`, `'t_shirts'`)
- `name` (String): Display label (e.g. `'Dresses'`, `'Pants'`, `'T-Shirts'`)
- `parentGroupId` (String): Parent category group ID (e.g. `'clothing'`)
- Extends: `Equatable`

### GenderFilter (Enum)
- `all`: All categories
- `female`: Female department categories
- `male`: Male department categories

---

## 2. Data Models (`lib/features/categories/data/models/`)

### CategoryGroupModel
- Subclasses `CategoryGroupEntity`
- `factory CategoryGroupModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`
- `factory CategoryGroupModel.fromEntity(CategoryGroupEntity entity)`

### SubCategoryModel
- Subclasses `SubCategoryEntity`
- `factory SubCategoryModel.fromJson(Map<String, dynamic> json)`
- `Map<String, dynamic> toJson()`
- `factory SubCategoryModel.fromEntity(SubCategoryEntity entity)`

---

## 3. UI State Models (`lib/features/categories/presentation/cubit/`)

### CategoriesState (Equatable)
- **CategoriesInitial**: Initial baseline state.
- **CategoriesLoading**: Emitted while loading category groups.
- **CategoriesLoaded**:
  - `groups` (List<CategoryGroupEntity>): All category groups for the active department.
  - `activeGender` (GenderFilter): Currently selected gender tab (`all`, `female`, `male`).
  - `expandedGroupId` (String?): ID of the currently expanded category group (default: `'clothing'`).
  - Helper getter `List<CategoryGroupEntity> get displayGroups` reflecting current expansion.
- **CategoriesError**:
  - `failure` (Failure): Error failure model.
