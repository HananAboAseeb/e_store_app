import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/order_entity.dart';

class OrdersTabs extends StatelessWidget {
  final OrderTab activeTab;
  final ValueChanged<OrderTab> onTabSelected;

  const OrdersTabs({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: AppColors.surfaceOption,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          children: [
            _buildTabItem(
              tab: OrderTab.toPay,
              label: 'To Pay',
            ),
            _buildTabItem(
              tab: OrderTab.toReceive,
              label: 'To Receive',
            ),
            _buildTabItem(
              tab: OrderTab.toReview,
              label: 'To Review',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required OrderTab tab,
    required String label,
  }) {
    final isActive = activeTab == tab;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(tab),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.transparent,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 13.sp,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? AppColors.textWhite : AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
