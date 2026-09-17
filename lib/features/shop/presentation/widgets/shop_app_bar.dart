import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? activeCategory;
  final VoidCallback? onDismissCategory;
  final VoidCallback? onCameraTap;
  final VoidCallback? onFilterTap;
  final bool showFilterIcon;

  const ShopAppBar({
    super.key,
    this.activeCategory,
    this.onDismissCategory,
    this.onCameraTap,
    this.onFilterTap,
    this.showFilterIcon = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    final hasCategory =
        activeCategory != null && activeCategory!.trim().isNotEmpty;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Row(
        children: [
          // 1. "Shop" Title
          Text(
            'Shop',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(width: 10.w),

          // 2. Search Container (Capsule with Active Category Chip & Camera)
          Expanded(
            child: Container(
              height: 42.h,
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: const Color(0xFFEEEEEE),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (hasCategory)
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10.w, 4.h, 6.w, 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCAD8FF),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  activeCategory!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF004BFE),
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              GestureDetector(
                                onTap: onDismissCategory,
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    Icons.close,
                                    size: 14.sp,
                                    color: const Color(0xFF004BFE),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          'Search...',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 13.sp,
                            color: AppColors.gray400,
                          ),
                        ),
                      ),
                    ),
                  // Blue Camera Icon inside the capsule
                  GestureDetector(
                    onTap: onCameraTap,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 22.sp,
                        color: const Color(0xFF004BFE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // 3. Settings in a separate circular white container
          if (showFilterIcon)
            Container(
              width: 42.h,
              height: 42.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFEEEEEE),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onFilterTap,
                  child: Center(
                    child: Icon(
                      Icons.settings_outlined,
                      size: 22.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
