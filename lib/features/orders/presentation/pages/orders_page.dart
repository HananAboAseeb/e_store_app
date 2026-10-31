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
  OrderStatus? _selectedStatusFilter;

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

  Widget _buildStatusChip(String label, OrderStatus? status) {
    final isSelected = _selectedStatusFilter == status;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatusFilter = status;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFFE5E7EB), width: 1.w),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF4B5563),
          ),
        ),
      ),
    );
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

            // Horizontal status navigation selector for direct access to all tracking milestones
            Container(
              height: 40.h,
              margin: EdgeInsets.symmetric(vertical: 4.h),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  _buildStatusChip('All', null),
                  SizedBox(width: 8.w),
                  _buildStatusChip('Packed Orders', OrderStatus.packed),
                  SizedBox(width: 8.w),
                  _buildStatusChip('Shipped Orders', OrderStatus.shipped),
                  SizedBox(width: 8.w),
                  _buildStatusChip('Delivered Orders', OrderStatus.delivered),
                  SizedBox(width: 8.w),
                  _buildStatusChip(
                      'Failed Attempts', OrderStatus.failedAttempt),
                  SizedBox(width: 8.w),
                  _buildStatusChip('To Pay', OrderStatus.toPay),
                ],
              ),
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
                    final allOrders = state.filteredOrders;
                    final orders = _selectedStatusFilter == null
                        ? allOrders
                        : allOrders
                            .where((o) => o.status == _selectedStatusFilter)
                            .toList();
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
                        padding: EdgeInsets.only(top: 4.h, bottom: 96.h),
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
                            onTap: () {
                              context.push('/orders/${order.id}/tracking');
                            },
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
