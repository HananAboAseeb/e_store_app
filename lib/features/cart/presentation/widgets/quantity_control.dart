import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityControl({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCircleButton(
          icon: Icons.remove,
          onTap: quantity > 1 ? onDecrement : null,
          isDisabled: quantity <= 1,
        ),
        SizedBox(width: 8.w),
        Container(
          constraints: BoxConstraints(minWidth: 32.w),
          height: 28.w,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary400.withOpacity(0.10),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            '$quantity',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        _buildCircleButton(
          icon: Icons.add,
          onTap: onIncrement,
          isDisabled: false,
        ),
      ],
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback? onTap,
    required bool isDisabled,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isDisabled ? AppColors.gray300 : AppColors.primary400,
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: 14.sp,
          color: isDisabled ? AppColors.gray400 : AppColors.primary400,
        ),
      ),
    );
  }
}
