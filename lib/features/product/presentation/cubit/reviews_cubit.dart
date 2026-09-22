import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_product_reviews_usecase.dart';
import '../../domain/usecases/vote_review_usecase.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final GetProductReviewsUseCase getProductReviewsUseCase;
  final VoteReviewUseCase voteReviewUseCase;
  String _currentProductId = '';

  ReviewsCubit({
    required this.getProductReviewsUseCase,
    required this.voteReviewUseCase,
  }) : super(const ReviewsInitial());

  Future<void> loadReviews(String productId) async {
    _currentProductId = productId;
    emit(const ReviewsLoading());

    final result = await getProductReviewsUseCase(
      GetProductReviewsParams(productId: productId, page: 1, limit: 10),
    );

    result.fold(
      (failure) => emit(ReviewsError(failure)),
      (reviews) => emit(ReviewsLoaded(
        reviews: reviews,
        hasMore: reviews.length >= 10,
        page: 1,
      )),
    );
  }

  Future<void> loadMoreReviews() async {
    final current = state;
    if (current is! ReviewsLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));

    final nextPage = current.page + 1;
    final result = await getProductReviewsUseCase(
      GetProductReviewsParams(
        productId: _currentProductId,
        page: nextPage,
        limit: 10,
      ),
    );

    result.fold(
      (failure) => emit(current.copyWith(isLoadingMore: false)),
      (newReviews) {
        emit(current.copyWith(
          reviews: [...current.reviews, ...newReviews],
          hasMore: newReviews.length >= 10,
          page: nextPage,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> toggleLike(String reviewId) async {
    _optimisticVote(reviewId, isLike: true);
    await voteReviewUseCase(VoteReviewParams(reviewId: reviewId, isLike: true));
  }

  Future<void> toggleDislike(String reviewId) async {
    _optimisticVote(reviewId, isLike: false);
    await voteReviewUseCase(
        VoteReviewParams(reviewId: reviewId, isLike: false));
  }

  void _optimisticVote(String reviewId, {required bool isLike}) {
    final current = state;
    if (current is! ReviewsLoaded) return;

    final updated = current.reviews.map((r) {
      if (r.id != reviewId) return r;

      int likes = r.likes;
      int dislikes = r.dislikes;
      bool? newVote;

      if (r.userVote == isLike) {
        // Toggle off
        newVote = null;
        if (isLike) likes--;
        if (!isLike) dislikes--;
      } else {
        // New or flipped vote
        if (r.userVote == true) likes--;
        if (r.userVote == false) dislikes--;

        newVote = isLike;
        if (isLike) likes++;
        if (!isLike) dislikes++;
      }

      return r.copyWith(
        likes: likes,
        dislikes: dislikes,
        userVote: () => newVote,
      );
    }).toList();

    emit(current.copyWith(reviews: updated));
  }
}
