import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/flash_sale_data_entity.dart';

abstract class FlashSaleRepository {
  Future<Either<Failure, FlashSaleDataEntity>> getFlashSaleData();
}
