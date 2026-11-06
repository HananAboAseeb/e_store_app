import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_typography.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback? onSearchTap;
  final VoidCallback? onCameraTap;
  final VoidCallback? onTitleTap;

  const HomeAppBar({
    super.key,
    this.onSearchTap,
    this.onCameraTap,
    this.onTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // "Shop" Title (Tappable to scroll to top)
          GestureDetector(
            onTap: onTitleTap,
            child: Text(
              'Shop',
              style: AppTypography.h1,
            ),
          ),

          // Pill Search Container
          Expanded(
            child: GestureDetector(
              onTap: onSearchTap,
              child: Container(
                height: 44.h,
                margin: EdgeInsets.only(left: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      size: 20.sp,
                      color: const Color(0xFF8E8E93),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Search',
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 14.sp,
                          color: const Color(0xFF8E8E93),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onCameraTap,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 22.sp,
                        color: const Color(0xFF004BFE),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
