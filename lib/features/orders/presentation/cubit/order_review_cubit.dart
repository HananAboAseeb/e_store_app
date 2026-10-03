import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_items_to_review_usecase.dart';
import '../../domain/usecases/submit_review_usecase.dart';
import 'order_review_state.dart';

class OrderReviewCubit extends Cubit<OrderReviewState> {
  final GetItemsToReviewUseCase getItemsToReviewUseCase;
  final SubmitReviewUseCase submitReviewUseCase;

  OrderReviewCubit({
    required this.getItemsToReviewUseCase,
    required this.submitReviewUseCase,
  }) : super(const ReviewInitial());

  Future<void> loadItemsToReview(String orderId) async {
    final result = await getItemsToReviewUseCase(orderId);
    result.fold(
      (failure) => emit(ReviewError(failure.message)),
      (items) => emit(ReviewItemsLoaded(orderId: orderId, items: items)),
    );
  }

  void selectItem(OrderItemEntity item) {
    emit(ReviewEditing(item: item, rating: 5, comment: ''));
  }

  void setRating(int rating) {
    final currentState = state;
    if (currentState is ReviewEditing) {
      emit(currentState.copyWith(rating: rating));
    }
  }

  void setComment(String comment) {
    final currentState = state;
    if (currentState is ReviewEditing) {
      emit(currentState.copyWith(comment: comment));
    }
  }

  Future<void> submitReview() async {
    final currentState = state;
    if (currentState is! ReviewEditing) return;

    emit(currentState.copyWith(isSubmitting: true));

    final review = OrderReviewEntity(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      orderId: currentState.item.orderId,
      itemId: currentState.item.id,
      rating: currentState.rating,
      comment: currentState.comment,
      submittedAt: DateTime.now(),
    );

    final result = await submitReviewUseCase(review);
    result.fold(
      (failure) => emit(ReviewError(failure.message)),
      (_) => emit(ReviewSubmitted(review)),
    );
  }

  void reset() {
    emit(const ReviewInitial());
  }
}
