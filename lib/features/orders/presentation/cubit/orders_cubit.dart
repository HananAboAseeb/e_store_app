import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_order_history_usecase.dart';
import '../../domain/usecases/get_orders_usecase.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  final GetOrderHistoryUseCase getOrderHistoryUseCase;

  OrdersCubit({
    required this.getOrdersUseCase,
    required this.getOrderHistoryUseCase,
  }) : super(const OrdersInitial());

  Future<void> loadOrders({OrderTab initialTab = OrderTab.toReceive}) async {
    emit(const OrdersLoading());
    final result = await getOrdersUseCase(initialTab);
    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (orders) {
        emit(OrdersLoaded(
          allOrders: orders,
          activeTab: initialTab,
          filteredOrders: orders,
        ));
      },
    );
  }

  Future<void> selectTab(OrderTab tab) async {
    final currentState = state;
    if (currentState is OrdersLoaded) {
      emit(currentState.copyWith(activeTab: tab));
      final result = await getOrdersUseCase(tab);
      result.fold(
        (failure) => emit(OrdersError(failure.message)),
        (orders) {
          emit(currentState.copyWith(
            activeTab: tab,
            allOrders: orders,
            filteredOrders: orders,
          ));
        },
      );
    } else {
      loadOrders(initialTab: tab);
    }
  }

  Future<void> loadHistory() async {
    final currentState = state;
    if (currentState is OrdersLoaded && currentState.historyOrders.isNotEmpty) {
      return;
    }
    emit(const OrdersLoading());
    final result = await getOrderHistoryUseCase();
    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (historyOrders) {
        emit(OrdersLoaded(
          allOrders: const [],
          activeTab: OrderTab.toReceive,
          filteredOrders: const [],
          historyOrders: historyOrders,
        ));
      },
    );
  }
}
