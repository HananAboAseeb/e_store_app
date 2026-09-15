import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String activeCategory;
  final VoidCallback? onDismissCategory;
  final VoidCallback? onCameraTap;
  final VoidCallback? onFilterTap;
  final bool showFilterIcon;

  const ShopAppBar({
    super.key,
    this.activeCategory = 'Clothing',
    this.onDismissCategory,
    this.onCameraTap,
    this.onFilterTap,
    this.showFilterIcon = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Title
            Text(
              'Shop',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: 12.w),
            // Active Category Pill [Clothing ✕]
            if (activeCategory.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      activeCategory,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: onDismissCategory,
                      child: Icon(
                        Icons.close,
                        size: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            // Camera Button
            IconButton(
              icon: Icon(
                Icons.camera_alt_outlined,
                size: 24.sp,
                color: AppColors.textPrimary,
              ),
              onPressed: onCameraTap,
              visualDensity: VisualDensity.compact,
            ),
            // Filter Gear Button
            if (showFilterIcon)
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  size: 24.sp,
                  color: AppColors.textPrimary,
                ),
                onPressed: onFilterTap,
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
      ),
    );
  }
}
