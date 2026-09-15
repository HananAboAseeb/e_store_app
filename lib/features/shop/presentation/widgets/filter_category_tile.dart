import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/shop_category_entity.dart';

class FilterCategoryTile extends StatelessWidget {
  final ShopCategoryEntity category;
  final bool isSelected;
  final VoidCallback? onTap;

  const FilterCategoryTile({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 58.w,
                height: 58.w,
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
                      size: 26.sp,
                      color: AppColors.gray600,
                    ),
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: -4.h,
                  right: -4.w,
                  child: Container(
                    width: 18.w,
                    height: 18.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: 60.w,
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
