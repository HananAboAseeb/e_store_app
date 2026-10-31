import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_order_tracking_usecase.dart';
import 'order_tracking_state.dart';

class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  final GetOrderTrackingUseCase getOrderTrackingUseCase;

  OrderTrackingCubit({
    required this.getOrderTrackingUseCase,
  }) : super(const TrackingInitial());

  Future<void> loadTracking(String orderId) async {
    emit(const TrackingLoading());
    final result = await getOrderTrackingUseCase(orderId);
    result.fold(
      (failure) => emit(TrackingError(failure.message)),
      (data) {
        final order = data.order;
        final steps = data.steps;
        final hasFailedAttempt = order.status == OrderStatus.failedAttempt ||
            steps.any((s) => s.isFailed);
        final isDelivered = order.status == OrderStatus.delivered ||
            (steps.isNotEmpty && steps.every((s) => s.isCompleted));

        emit(TrackingLoaded(
          order: order,
          steps: steps,
          hasFailedAttempt: hasFailedAttempt,
          isDelivered: isDelivered,
        ));
      },
    );
  }
}
