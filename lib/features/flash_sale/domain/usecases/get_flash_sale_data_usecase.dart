import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/flash_sale_data_entity.dart';
import '../repositories/flash_sale_repository.dart';

class GetFlashSaleDataUseCase implements UseCase<FlashSaleDataEntity, NoParam> {
  final FlashSaleRepository repository;

  GetFlashSaleDataUseCase(this.repository);

  @override
  Future<Either<Failure, FlashSaleDataEntity>> call([NoParam? param]) async {
    return await repository.getFlashSaleData();
  }
}
