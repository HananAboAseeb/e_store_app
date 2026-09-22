import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_mock_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductMockDataSource mockDataSource;

  ProductRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
    String id,
  ) async {
    return await safeCall(() => mockDataSource.getProductDetails(id));
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getProductReviews(
    String productId, {
    int page = 1,
    int limit = 10,
  }) async {
    return await safeCall(
      () => mockDataSource.getProductReviews(
        productId,
        page: page,
        limit: limit,
      ),
    );
  }

  @override
  Future<Either<Failure, ReviewEntity>> voteReview(
    String reviewId, {
    required bool isLike,
  }) async {
    return await safeCall(
      () => mockDataSource.voteReview(reviewId, isLike: isLike),
    );
  }
}
