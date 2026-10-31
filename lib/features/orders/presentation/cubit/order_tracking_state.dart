import 'package:equatable/equatable.dart';

import '../../domain/entities/order_entity.dart';

abstract class OrderTrackingState extends Equatable {
  const OrderTrackingState();

  @override
  List<Object?> get props => [];
}

class TrackingInitial extends OrderTrackingState {
  const TrackingInitial();
}

class TrackingLoading extends OrderTrackingState {
  const TrackingLoading();
}

class TrackingLoaded extends OrderTrackingState {
  final OrderEntity order;
  final List<TrackingStepEntity> steps;
  final bool hasFailedAttempt;
  final bool isDelivered;

  const TrackingLoaded({
    required this.order,
    required this.steps,
    this.hasFailedAttempt = false,
    this.isDelivered = false,
  });

  @override
  List<Object?> get props => [
        order,
        steps,
        hasFailedAttempt,
        isDelivered,
      ];
}

class TrackingError extends OrderTrackingState {
  final String message;

  const TrackingError(this.message);

  @override
  List<Object?> get props => [message];
}
