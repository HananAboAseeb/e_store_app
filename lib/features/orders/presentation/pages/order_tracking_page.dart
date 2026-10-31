import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
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
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            // Top Header: Matching Figma Screens 59, 60, 63
            OrdersHeader(
              title: 'To Receive',
              subtitle: 'My Orders',
              onBackTap: () => Navigator.of(context).maybePop(),
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
                      padding: EdgeInsets.only(top: 4.h, bottom: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Order Summary Card matching Figma
                          _buildOrderSummaryCard(order),

                          SizedBox(height: 12.h),

                          // 2. Tracking Milestones without vertical lines
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

  /// Top Order Summary Card matching Figma Screens 59, 60, 63 layout
  Widget _buildOrderSummaryCard(OrderEntity order) {
    final trackingCode = order.trackingNumber ?? 'LGS-i92927839300763731';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Dynamic Collage + Order Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dynamic Product Collage directly on card background (no white container)
              _buildOrderItemsCollage(order),

              SizedBox(width: 14.w),

              // Order Number & Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderNumber,
                      style: AppTypography.orderCardTitle,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      order.deliveryType,
                      style: AppTypography.orderCardSubtitle,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '${order.itemCount} Items',
                      style: AppTypography.orderCardCount,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Container(
              height: 1.h,
              color: const Color(0xFFE2E8F0),
            ),
          ),

          // Bottom Row: Tracking Number + Exact Blue Ticket Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderNumber,
                      style: AppTypography.caption.copyWith(
                        color: const Color(0xFF6B7280),
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      trackingCode,
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                        fontSize: 13.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Blue rounded ticket icon button matching Figma exactly
              GestureDetector(
                onTap: () => _copyTrackingNumber(trackingCode),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.5.w,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 14.w,
                        height: 2.2.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Container(
                        width: 14.w,
                        height: 2.2.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Dynamic Product Collage: Renders exact items without outer white padding
  Widget _buildOrderItemsCollage(OrderEntity order) {
    final items = order.items;
    final count = items.length;

    if (count == 0) {
      return SizedBox(
        width: 68.w,
        height: 68.w,
        child: _buildThumbItem('assets/images/prod_20_1.png'),
      );
    }

    if (count == 1) {
      return SizedBox(
        width: 68.w,
        height: 68.w,
        child: _buildThumbItem(items[0].imageUrl),
      );
    }

    if (count == 2) {
      return SizedBox(
        width: 68.w,
        height: 68.w,
        child: Row(
          children: [
            Expanded(child: _buildThumbItem(items[0].imageUrl)),
            SizedBox(width: 4.w),
            Expanded(child: _buildThumbItem(items[1].imageUrl)),
          ],
        ),
      );
    }

    if (count == 3) {
      // 3 items matching Figma Screen 60: 2 on top row, 1 in bottom row
      return SizedBox(
        width: 68.w,
        height: 68.w,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: _buildThumbItem(items[0].imageUrl)),
                  SizedBox(width: 4.w),
                  Expanded(child: _buildThumbItem(items[1].imageUrl)),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 32.w,
                  child: _buildThumbItem(items[2].imageUrl),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // 4 items (2x2 grid matching 4 items count)
    return SizedBox(
      width: 68.w,
      height: 68.w,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildThumbItem(items[0].imageUrl)),
                SizedBox(width: 4.w),
                Expanded(child: _buildThumbItem(items[1].imageUrl)),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildThumbItem(items[2].imageUrl)),
                SizedBox(width: 4.w),
                Expanded(child: _buildThumbItem(items[3].imageUrl)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbItem(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        color: AppColors.thumbnailBg,
        child: Image.asset(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
