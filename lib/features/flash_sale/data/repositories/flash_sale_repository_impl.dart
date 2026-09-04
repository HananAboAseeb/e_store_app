import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/flash_sale_data_entity.dart';
import '../../domain/repositories/flash_sale_repository.dart';
import '../datasources/flash_sale_mock_datasource.dart';

class FlashSaleRepositoryImpl implements FlashSaleRepository {
  final FlashSaleMockDataSource mockDataSource;

  FlashSaleRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, FlashSaleDataEntity>> getFlashSaleData() async {
    return await safeCall(() => mockDataSource.getFlashSaleData());
  }
}
