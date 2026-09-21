import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/review_entity.dart';
import '../repositories/product_repository.dart';

class VoteReviewParams extends Equatable {
  final String reviewId;
  final bool isLike;

  const VoteReviewParams({
    required this.reviewId,
    required this.isLike,
  });

  @override
  List<Object?> get props => [reviewId, isLike];
}

class VoteReviewUseCase extends UseCase<ReviewEntity, VoteReviewParams> {
  final ProductRepository repository;

  VoteReviewUseCase(this.repository);

  @override
  Future<Either<Failure, ReviewEntity>> call([VoteReviewParams? param]) {
    if (param == null) {
      throw ArgumentError('VoteReviewParams cannot be null');
    }
    return repository.voteReview(param.reviewId, isLike: param.isLike);
  }
}
