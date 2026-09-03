import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../../../shared/models/pagination/pagination_params.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/product/product_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_mock_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeMockDataSource mockDataSource;

  HomeRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, HomeDataEntity>> getHomeData() async {
    return await safeCall(() => mockDataSource.getHomeData());
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct(
    PaginationParams params,
  ) async {
    return const Right([]);
  }
}
