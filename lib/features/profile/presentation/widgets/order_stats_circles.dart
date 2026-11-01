import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/order_stats_entity.dart';

class OrderStatsCircles extends StatelessWidget {
  final OrderStatsEntity orderStats;

  const OrderStatsCircles({
    super.key,
    required this.orderStats,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCircleItem(
            count: orderStats.orderedCount,
            label: 'Ordered',
          ),
        ),
        Expanded(
          child: _StatCircleItem(
            count: orderStats.receivedCount,
            label: 'Recieved', // Matches Figma spelling
          ),
        ),
        Expanded(
          child: _StatCircleItem(
            count: orderStats.toReceiveCount,
            label: 'To Recieve', // Matches Figma spelling
          ),
        ),
      ],
    );
  }
}

class _StatCircleItem extends StatelessWidget {
  final int count;
  final String label;

  const _StatCircleItem({
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 48.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: AppColors.primary400,
            borderRadius: BorderRadius.circular(58.r),
          ),
          alignment: Alignment.center,
          child: AppText.body(
            '$count',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        AppText.caption(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
