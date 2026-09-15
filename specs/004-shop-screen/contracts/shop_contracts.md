# Interface Contracts: Shop Feature

## 1. Domain Repository Contract
Location: `lib/features/shop/domain/repositories/shop_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/filter_criteria_entity.dart';
import '../entities/shop_category_entity.dart';
import '../entities/shop_product_entity.dart';

abstract class ShopRepository {
  Future<Either<Failure, List<ShopProductEntity>>> getProducts({FilterCriteriaEntity? criteria});
  Future<Either<Failure, List<ShopCategoryEntity>>> getCategories();
}
```

---

## 2. Use Case Contracts
Location: `lib/features/shop/domain/usecases/`

```dart
// get_shop_products_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/filter_criteria_entity.dart';
import '../entities/shop_product_entity.dart';
import '../repositories/shop_repository.dart';

class GetShopProductsUseCase implements UseCase<List<ShopProductEntity>, FilterCriteriaEntity?> {
  final ShopRepository repository;
  GetShopProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShopProductEntity>>> call(FilterCriteriaEntity? params) {
    return repository.getProducts(criteria: params);
  }
}

// get_shop_categories_usecase.dart
class GetShopCategoriesUseCase implements UseCase<List<ShopCategoryEntity>, NoParams> {
  final ShopRepository repository;
  GetShopCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShopCategoryEntity>>> call(NoParams params) {
    return repository.getCategories();
  }
}
```

---

## 3. Data Source Contract
Location: `lib/features/shop/data/datasources/shop_mock_datasource.dart`

```dart
import '../models/shop_category_model.dart';
import '../models/shop_product_model.dart';

abstract class ShopMockDataSource {
  Future<List<ShopProductModel>> getProducts();
  Future<List<ShopCategoryModel>> getCategories();
}
```

---

## 4. Cubit Contract
Location: `lib/features/shop/presentation/cubit/`

```dart
abstract class ShopCubitContract {
  Future<void> loadShopData();
  void selectSubCategory(String? subCategory);
  void applyFilter(FilterCriteriaEntity criteria);
  void clearFilter();
}

abstract class FilterCubitContract {
  void toggleCategory(String categoryName);
  void setSizeType(String type);
  void selectSize(String? size);
  void selectColor(String? color);
  void updatePriceRange(double min, double max);
  void setSortOption(ShopSortOption option);
  void clearAll();
}
```
