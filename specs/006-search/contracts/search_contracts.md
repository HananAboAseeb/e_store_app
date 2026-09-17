# Interface Contracts: Search Feature

## 1. Domain Repository Contract
Location: `lib/features/search/domain/repositories/search_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../entities/image_search_result_entity.dart';
import '../entities/search_data_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchDataEntity>> getSearchData();
  Future<Either<Failure, List<ShopProductEntity>>> searchByText(
    String query, {
    FilterCriteriaEntity? filter,
  });
  Future<Either<Failure, ImageSearchResultEntity>> searchByImage(
    String imagePath,
  );
  Future<Either<Failure, Unit>> clearSearchHistory();
}
```

---

## 2. Use Case Contracts
Location: `lib/features/search/domain/usecases/`

### `get_search_data_usecase.dart`
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/search_data_entity.dart';
import '../repositories/search_repository.dart';

class GetSearchDataUseCase implements UseCase<SearchDataEntity, NoParams> {
  final SearchRepository repository;
  GetSearchDataUseCase(this.repository);

  @override
  Future<Either<Failure, SearchDataEntity>> call(NoParams params) {
    return repository.getSearchData();
  }
}
```

### `search_by_text_usecase.dart`
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../../../shop/domain/entities/shop_product_entity.dart';
import '../repositories/search_repository.dart';

class SearchByTextParams {
  final String query;
  final FilterCriteriaEntity? filter;
  SearchByTextParams({required this.query, this.filter});
}

class SearchByTextUseCase implements UseCase<List<ShopProductEntity>, SearchByTextParams> {
  final SearchRepository repository;
  SearchByTextUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShopProductEntity>>> call(SearchByTextParams params) {
    return repository.searchByText(params.query, filter: params.filter);
  }
}
```

### `search_by_image_usecase.dart`
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/image_search_result_entity.dart';
import '../repositories/search_repository.dart';

class SearchByImageUseCase implements UseCase<ImageSearchResultEntity, String> {
  final SearchRepository repository;
  SearchByImageUseCase(this.repository);

  @override
  Future<Either<Failure, ImageSearchResultEntity>> call(String imagePath) {
    return repository.searchByImage(imagePath);
  }
}
```

### `clear_search_history_usecase.dart`
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/search_repository.dart';

class ClearSearchHistoryUseCase implements UseCase<Unit, NoParams> {
  final SearchRepository repository;
  ClearSearchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.clearSearchHistory();
  }
}
```

---

## 3. Data Source Contract
Location: `lib/features/search/data/datasources/search_mock_datasource.dart`

```dart
import '../../../shop/data/models/shop_product_model.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../models/image_search_result_model.dart';
import '../models/search_history_model.dart';
import '../models/recommendation_model.dart';

abstract class SearchMockDataSource {
  Future<List<SearchHistoryModel>> getSearchHistory();
  Future<List<RecommendationModel>> getRecommendations();
  Future<List<ShopProductModel>> getDiscoverProducts();
  Future<List<ShopProductModel>> searchByText(
    String query, {
    FilterCriteriaEntity? filter,
  });
  Future<ImageSearchResultModel> searchByImage(String imagePath);
  Future<void> clearSearchHistory();
}
```

---

## 4. Presentation Cubit Contracts

### `SearchCubitContract`
```dart
abstract class SearchCubitContract {
  Future<void> loadSearchData();
  Future<void> submitQuery(String query);
  Future<void> clearHistory();
  void clearQuery();
  Future<void> applyFilter(FilterCriteriaEntity filter);
}
```

### `ImageSearchCubitContract`
```dart
abstract class ImageSearchCubitContract {
  Future<void> captureImage();
  Future<void> pickFromGallery();
  void retry();
  void showResultsSheet();
  void dismissResultsSheet();
}
```
