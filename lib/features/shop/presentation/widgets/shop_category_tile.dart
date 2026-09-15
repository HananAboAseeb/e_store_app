import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/shop_category_entity.dart';

class ShopCategoryTile extends StatelessWidget {
  final ShopCategoryEntity category;
  final bool isSelected;
  final VoidCallback? onTap;

  const ShopCategoryTile({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFEBF1FF)
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16.r),
              border: isSelected
                  ? Border.all(color: AppColors.primary, width: 1.5.w)
                  : null,
            ),
            padding: EdgeInsets.all(10.w),
            child: Center(
              child: Image.asset(
                category.assetPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.checkroom_outlined,
                  size: 28.sp,
                  color: AppColors.gray600,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: 64.w,
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
