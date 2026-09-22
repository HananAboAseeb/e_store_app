import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product_details_entity.dart';
import '../entities/review_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(String id);

  Future<Either<Failure, List<ReviewEntity>>> getProductReviews(
    String productId, {
    int page = 1,
    int limit = 10,
  });

  Future<Either<Failure, ReviewEntity>> voteReview(
    String reviewId, {
    required bool isLike,
  });
}
