import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/review_entity.dart';
import '../repositories/product_repository.dart';

class GetProductReviewsParams extends Equatable {
  final String productId;
  final int page;
  final int limit;

  const GetProductReviewsParams({
    required this.productId,
    this.page = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [productId, page, limit];
}

class GetProductReviewsUseCase
    extends UseCase<List<ReviewEntity>, GetProductReviewsParams> {
  final ProductRepository repository;

  GetProductReviewsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ReviewEntity>>> call([
    GetProductReviewsParams? param,
  ]) {
    final params = param ?? const GetProductReviewsParams(productId: '');
    return repository.getProductReviews(
      params.productId,
      page: params.page,
      limit: params.limit,
    );
  }
}
