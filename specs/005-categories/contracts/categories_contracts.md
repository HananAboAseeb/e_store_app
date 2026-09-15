# Interface Contracts: Categories Feature

## 1. Domain Repository Contract
Location: `lib/features/categories/domain/repositories/categories_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category_group_entity.dart';
import '../entities/gender_filter.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryGroupEntity>>> getCategories({
    GenderFilter gender = GenderFilter.all,
  });
}
```

---

## 2. Use Case Contract
Location: `lib/features/categories/domain/usecases/get_categories_usecase.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/category_group_entity.dart';
import '../entities/gender_filter.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesUseCase implements UseCase<List<CategoryGroupEntity>, GenderFilter> {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryGroupEntity>>> call(GenderFilter gender) {
    return repository.getCategories(gender: gender);
  }
}
```

---

## 3. Data Source Contract
Location: `lib/features/categories/data/datasources/categories_mock_datasource.dart`

```dart
import '../models/category_group_model.dart';
import '../../domain/entities/gender_filter.dart';

abstract class CategoriesMockDataSource {
  Future<List<CategoryGroupModel>> getCategories({
    GenderFilter gender = GenderFilter.all,
  });
}
```

---

## 4. Presentation Cubit Contract
Location: `lib/features/categories/presentation/cubit/categories_cubit.dart`

```dart
import '../../domain/entities/gender_filter.dart';

abstract class CategoriesCubitContract {
  Future<void> loadCategories({GenderFilter gender = GenderFilter.all});
  void selectGender(GenderFilter gender);
  void toggleCategoryExpansion(String groupId);
}
```
