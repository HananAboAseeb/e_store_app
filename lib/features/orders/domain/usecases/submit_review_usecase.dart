import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class SubmitReviewUseCase implements UseCase<void, OrderReviewEntity> {
  final OrdersRepository repository;

  SubmitReviewUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call([OrderReviewEntity? review]) {
    if (review == null) {
      return Future.value(
        const Left(ValidationFailure('Review entity cannot be null')),
      );
    }
    return repository.submitReview(review);
  }
}
