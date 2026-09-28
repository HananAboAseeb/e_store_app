# Interface Contracts: Categories Feature (Screen 27 & Screen 43)

## 1. Domain Repository Contract
Location: `lib/features/categories/domain/repositories/categories_repository.dart`

```dart
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../entities/category_group_entity.dart';
import '../entities/gender_filter.dart';

abstract class CategoriesRepository {
  /// Screen 27: Fetches category groups filtered by department.
  Future<Either<Failure, List<CategoryGroupEntity>>> getCategories({
    GenderFilter gender = GenderFilter.all,
  });

  /// Screen 43: Fetches personalized "Just for you" product recommendations.
  Future<Either<Failure, List<ShopProductEntity>>> getJustForYouProducts();
}
```

---

## 2. Use Case Contracts

### Screen 27: GetCategoriesUseCase
Location: `lib/features/categories/domain/usecases/get_categories_usecase.dart`

```dart
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/category_group_entity.dart';
import '../entities/gender_filter.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesUseCase
    extends UseCase<List<CategoryGroupEntity>, GenderFilter> {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryGroupEntity>>> call([
    GenderFilter? param,
  ]) {
    return repository.getCategories(gender: param ?? GenderFilter.all);
  }
}
```

### Screen 43: GetJustForYouProductsUseCase
Location: `lib/features/categories/domain/usecases/get_just_for_you_products_usecase.dart`

```dart
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../repositories/categories_repository.dart';

class GetJustForYouProductsUseCase
    extends UseCase<List<ShopProductEntity>, NoParam> {
  final CategoriesRepository repository;

  GetJustForYouProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShopProductEntity>>> call([NoParam? param]) {
    return repository.getJustForYouProducts();
  }
}
```

---

## 3. Data Source Contract
Location: `lib/features/categories/data/datasources/categories_mock_datasource.dart`

```dart
import '../../../shop/data/models/shop_product_model.dart';
import '../../domain/entities/gender_filter.dart';
import '../models/category_group_model.dart';

abstract class CategoriesMockDataSource {
  Future<List<CategoryGroupModel>> getCategories({
    GenderFilter gender = GenderFilter.all,
  });

  Future<List<ShopProductModel>> getJustForYouProducts();
}
```

---

## 4. Presentation Cubit Contract
Location: `lib/features/categories/presentation/cubit/categories_cubit.dart`

```dart
import '../../domain/entities/gender_filter.dart';

abstract class CategoriesCubitContract {
  // Screen 27 methods
  Future<void> loadCategories({GenderFilter gender = GenderFilter.all});
  void selectGender(GenderFilter gender);
  void toggleCategoryExpansion(String groupId);

  // Screen 43 methods
  Future<void> loadJustForYouProducts();
}
```
