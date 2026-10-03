import 'package:equatable/equatable.dart';

import '../../domain/entities/order_entity.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> allOrders;
  final OrderTab activeTab;
  final List<OrderEntity> filteredOrders;
  final List<OrderEntity> historyOrders;

  const OrdersLoaded({
    required this.allOrders,
    required this.activeTab,
    required this.filteredOrders,
    this.historyOrders = const [],
  });

  OrdersLoaded copyWith({
    List<OrderEntity>? allOrders,
    OrderTab? activeTab,
    List<OrderEntity>? filteredOrders,
    List<OrderEntity>? historyOrders,
  }) {
    return OrdersLoaded(
      allOrders: allOrders ?? this.allOrders,
      activeTab: activeTab ?? this.activeTab,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      historyOrders: historyOrders ?? this.historyOrders,
    );
  }

  @override
  List<Object?> get props => [
        allOrders,
        activeTab,
        filteredOrders,
        historyOrders,
      ];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object?> get props => [message];
}
