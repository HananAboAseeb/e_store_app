import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/no_data_found_widget.dart';
import '../../domain/entities/order_entity.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import '../widgets/order_card.dart';
import '../widgets/orders_header.dart';
import '../widgets/orders_shimmer_loading.dart';
import '../widgets/review_option_sheet.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late final OrdersCubit _ordersCubit;

  @override
  void initState() {
    super.initState();
    _ordersCubit = sl<OrdersCubit>()..loadOrders();
  }

  @override
  void dispose() {
    _ordersCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _ordersCubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            // Header (Avatar + Title + 3 action icons)
            OrdersHeader(
              title: 'To Recieve',
              subtitle: 'My Orders',
              onFilterTap: () {
                context.push('/orders/history');
              },
            ),

            // Orders List (Directly below header matching Figma Screen 57)
            Expanded(
              child: BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  if (state is OrdersLoading) {
                    return const OrdersShimmerLoading();
                  }

                  if (state is OrdersError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => _ordersCubit.loadOrders(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is OrdersLoaded) {
                    final orders = state.filteredOrders;
                    if (orders.isEmpty) {
                      return const NoDataFoundWidget(
                        title: 'No Orders Found',
                        message: 'You have no orders in this category yet.',
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () =>
                          _ordersCubit.loadOrders(initialTab: state.activeTab),
                      color: AppColors.primary,
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
                        itemCount: orders.length,
                        separatorBuilder: (context, index) {
                          final currentOrder = orders[index];
                          final nextOrder = index + 1 < orders.length
                              ? orders[index + 1]
                              : null;

                          // In Figma Screen 57, a clean heavier gray divider separates active from delivered orders
                          final isTransitionToDelivered =
                              currentOrder.status != OrderStatus.delivered &&
                                  nextOrder?.status == OrderStatus.delivered;

                          if (isTransitionToDelivered) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Container(
                                height: 1.2.h,
                                color: const Color(0xFFD1D5DB),
                              ),
                            );
                          }

                          return SizedBox(height: 4.h);
                        },
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return OrderCard(
                            order: order,
                            onTrackTap: () {
                              context.push('/orders/${order.id}/tracking');
                            },
                            onReviewTap: () {
                              ReviewOptionSheet.show(
                                context,
                                orderId: order.id,
                              );
                            },
                            onPayTap: () {
                              context.push('/payment');
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
