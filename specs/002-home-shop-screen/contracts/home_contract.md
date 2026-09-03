# Interface Contracts & Repository API: Home (Shop Screen)

**Feature**: `002-home-shop-screen`  
**Date**: 2026-08-29  

---

## 1. Domain Repository Contract (`lib/features/home/domain/repositories/home_repository.dart`)

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/home_data_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeDataEntity>> getHomeData();
}
```

---

## 2. UseCase Contract (`lib/features/home/domain/usecases/get_home_data_usecase.dart`)

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/home_data_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUseCase implements UseCase<HomeDataEntity, NoParams> {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  @override
  Future<Either<Failure, HomeDataEntity>> call(NoParams params) async {
    return await repository.getHomeData();
  }
}
```

---

## 3. Data Source Contract (`lib/features/home/data/datasources/home_mock_datasource.dart`)

```dart
import '../models/home_data_model.dart';

abstract class HomeMockDataSource {
  Future<HomeDataModel> getHomeData();
}
```
