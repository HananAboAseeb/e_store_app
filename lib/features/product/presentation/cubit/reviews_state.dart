import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/review_entity.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object?> get props => [];
}

class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();
}

class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();
}

class ReviewsLoaded extends ReviewsState {
  final List<ReviewEntity> reviews;
  final bool hasMore;
  final int page;
  final bool isLoadingMore;

  const ReviewsLoaded({
    required this.reviews,
    required this.hasMore,
    required this.page,
    this.isLoadingMore = false,
  });

  ReviewsLoaded copyWith({
    List<ReviewEntity>? reviews,
    bool? hasMore,
    int? page,
    bool? isLoadingMore,
  }) {
    return ReviewsLoaded(
      reviews: reviews ?? this.reviews,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [reviews, hasMore, page, isLoadingMore];
}

class ReviewsError extends ReviewsState {
  final Failure failure;

  const ReviewsError(this.failure);

  @override
  List<Object?> get props => [failure];
}
