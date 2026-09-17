import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class SearchResultsHeader extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;
  final VoidCallback onFilterTap;
  final VoidCallback? onBackTap;

  const SearchResultsHeader({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onClear,
    required this.onFilterTap,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onBackTap != null) ...[
          GestureDetector(
            onTap: onBackTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18.sp,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
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
                GestureDetector(
                  onTap: onClear,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Icon(
                      Icons.close,
                      size: 16.sp,
                      color: AppColors.gray500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: onFilterTap,
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
                Icons.settings_outlined,
                size: 18.sp,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
