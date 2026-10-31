import 'package:equatable/equatable.dart';

import '../../domain/entities/order_entity.dart';

abstract class OrderReviewState extends Equatable {
  const OrderReviewState();

  @override
  List<Object?> get props => [];
}

class ReviewInitial extends OrderReviewState {
  const ReviewInitial();
}

class ReviewItemsLoaded extends OrderReviewState {
  final String orderId;
  final List<OrderItemEntity> items;

  const ReviewItemsLoaded({
    required this.orderId,
    required this.items,
  });

  @override
  List<Object?> get props => [orderId, items];
}

class ReviewEditing extends OrderReviewState {
  final OrderItemEntity item;
  final int rating;
  final String comment;
  final bool isSubmitting;

  const ReviewEditing({
    required this.item,
    this.rating = 5,
    this.comment = '',
    this.isSubmitting = false,
  });

  ReviewEditing copyWith({
    OrderItemEntity? item,
    int? rating,
    String? comment,
    bool? isSubmitting,
  }) {
    return ReviewEditing(
      item: item ?? this.item,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [item, rating, comment, isSubmitting];
}

class ReviewSubmitted extends OrderReviewState {
  final OrderReviewEntity review;

  const ReviewSubmitted(this.review);

  @override
  List<Object?> get props => [review];
}

class ReviewError extends OrderReviewState {
  final String message;

  const ReviewError(this.message);

  @override
  List<Object?> get props => [message];
}
