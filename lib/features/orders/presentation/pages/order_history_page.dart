import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/no_data_found_widget.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import '../widgets/history_item_tile.dart';
import '../widgets/orders_header.dart';
import '../widgets/orders_shimmer_loading.dart';
import '../widgets/review_option_sheet.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late final OrdersCubit _ordersCubit;

  @override
  void initState() {
    super.initState();
    _ordersCubit = sl<OrdersCubit>()..loadHistory();
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
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            // Top Header (Title "History", 3 icons, Back button)
            OrdersHeader(
              title: 'History',
              subtitle: 'Past Orders',
              showBackButton: true,
            ),

            // Orders List
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
                            onPressed: () => _ordersCubit.loadHistory(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is OrdersLoaded) {
                    final orders = state.historyOrders;

                    if (orders.isEmpty) {
                      return const NoDataFoundWidget(
                        title: 'No History Found',
                        message: 'You have not completed any orders yet.',
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => _ordersCubit.loadHistory(),
                      color: AppColors.primary,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 24),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return HistoryItemTile(
                            order: order,
                            onReviewTap: () {
                              ReviewOptionSheet.show(
                                context,
                                orderId: order.id,
                              );
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
