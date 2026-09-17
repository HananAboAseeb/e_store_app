import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class SearchHeader extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onCameraTap;
  final VoidCallback? onCloseTap;
  final VoidCallback? onSearchTap;
  final bool readOnly;

  const SearchHeader({
    super.key,
    this.controller,
    this.onSubmitted,
    this.onCameraTap,
    this.onCloseTap,
    this.onSearchTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // "Search" Title - Beside the search bar, smaller and darker as per Figma
        Text(
          'Search',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(width: 10.w),
        // Search Input Pill
        Expanded(
          child: Container(
            height: 38.h,
            decoration: BoxDecoration(
              color: const Color(0x12000000),
              borderRadius: BorderRadius.circular(19.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 18.sp,
                  color: AppColors.gray400,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: TextField(
                    controller: controller,
                    readOnly: readOnly,
                    onTap: onSearchTap,
                    onSubmitted: onSubmitted,
                    textInputAction: TextInputAction.search,
                    cursorColor: AppColors.textPrimary,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray400,
                      ),
                      // Eliminate any blue outline border when focused
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                if (onCameraTap != null)
                  GestureDetector(
                    onTap: onCameraTap,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 18.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (onCloseTap != null) ...[
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onCloseTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: const BoxDecoration(
                color: Color(0x12000000),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 18.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
