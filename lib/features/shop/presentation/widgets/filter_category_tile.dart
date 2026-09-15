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
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(18.r),
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
                  top: -3.h,
                  right: -3.w,
                  child: Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF004BFE),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: 13.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: 62.w,
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
