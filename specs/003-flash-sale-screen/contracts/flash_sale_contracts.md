# Interface Contracts: Flash Sale Screen

## 1. Domain Repository Contract
Location: `lib/features/flash_sale/domain/repositories/flash_sale_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/flash_sale_data_entity.dart';

abstract class FlashSaleRepository {
  Future<Either<Failure, FlashSaleDataEntity>> getFlashSaleData();
}
```

---

## 2. Use Case Contract
Location: `lib/features/flash_sale/domain/usecases/get_flash_sale_data_usecase.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/flash_sale_data_entity.dart';
import '../repositories/flash_sale_repository.dart';

class GetFlashSaleDataUseCase implements UseCase<FlashSaleDataEntity, NoParams> {
  final FlashSaleRepository repository;

  GetFlashSaleDataUseCase(this.repository);

  @override
  Future<Either<Failure, FlashSaleDataEntity>> call(NoParams params) async {
    return await repository.getFlashSaleData();
  }
}
```

---

## 3. Data Source Contract
Location: `lib/features/flash_sale/data/datasources/flash_sale_mock_datasource.dart`

```dart
import '../models/flash_sale_data_model.dart';

abstract class FlashSaleMockDataSource {
  Future<FlashSaleDataModel> getFlashSaleData();
}
```

---

## 4. Cubit Contract
Location: `lib/features/flash_sale/presentation/cubit/flash_sale_cubit.dart`

```dart
abstract class FlashSaleCubitContract {
  Future<void> loadFlashSaleData();
  void selectDiscountFilter(int? discountPercentage);
  Future<void> refresh();
}
```
