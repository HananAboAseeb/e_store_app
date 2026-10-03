import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/meta_pill.dart';
import '../../domain/entities/order_entity.dart';
import '../cubit/order_tracking_cubit.dart';
import '../cubit/order_tracking_state.dart';
import '../widgets/delivery_failed_sheet.dart';
import '../widgets/order_tracking_timeline.dart';
import '../widgets/orders_header.dart';
import '../widgets/orders_shimmer_loading.dart';

class OrderTrackingPage extends StatefulWidget {
  final String orderId;

  const OrderTrackingPage({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  late final OrderTrackingCubit _trackingCubit;

  @override
  void initState() {
    super.initState();
    _trackingCubit = sl<OrderTrackingCubit>()..loadTracking(widget.orderId);
  }

  @override
  void dispose() {
    _trackingCubit.close();
    super.dispose();
  }

  void _copyTrackingNumber(String trackingNumber) {
    Clipboard.setData(ClipboardData(text: trackingNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tracking number copied to clipboard'),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _trackingCubit,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            // Top Header with Back Button
            OrdersHeader(
              title: 'To Receive',
              subtitle: 'My Orders',
              showBackButton: true,
            ),

            Expanded(
              child: BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
                builder: (context, state) {
                  if (state is TrackingLoading) {
                    return const OrdersShimmerLoading();
                  }

                  if (state is TrackingError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () =>
                                _trackingCubit.loadTracking(widget.orderId),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is TrackingLoaded) {
                    final order = state.order;
                    final steps = state.steps;

                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Order Summary Card
                          _buildOrderSummaryCard(order),

                          SizedBox(height: 12.h),

                          // Vertical Tracking Timeline
                          OrderTrackingTimeline(
                            steps: steps,
                            onLearnMoreTap: () {
                              DeliveryFailedSheet.show(context);
                            },
                          ),

                          SizedBox(height: 24.h),
                        ],
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

  Widget _buildOrderSummaryCard(OrderEntity order) {
    final trackingCode = order.trackingNumber ?? 'LGS-92287157';
    final displayItems = order.items.take(3).toList();
    final remainingCount = order.itemCount - displayItems.length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row of Thumbnails + Basic Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnails
              Row(
                children: [
                  for (final item in displayItems) ...[
                    Container(
                      width: 48.w,
                      height: 48.w,
                      margin: EdgeInsets.only(right: 6.w),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceCardImage,
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  if (remainingCount > 0)
                    Container(
                      width: 40.w,
                      height: 48.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceOption,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '+$remainingCount',
                        style: AppTypography.caption.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(width: 12.w),

              // Order Number & Pills
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderNumber,
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      order.deliveryType,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    MetaPill(
                      text: '${order.itemCount} items',
                      backgroundColor: AppColors.primarySoft,
                      textColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),
          Container(height: 1.h, color: AppColors.divider),
          SizedBox(height: 12.h),

          // LGS Tracking Row with Copy Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.orderNumber,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    trackingCode,
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _copyTrackingNumber(trackingCode),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceOption,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.copy_rounded,
                    size: 18.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
