import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onSeeAllTap;
  final bool showSeeAll;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onSeeAllTap,
    this.showSeeAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Optional Leading Icon + Dark Bold Title
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: 8.w),
                ],
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF000000),
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right: Custom Trailing or "See All" Blue Circular Arrow
          if (trailing != null)
            trailing!
          else if (showSeeAll)
            GestureDetector(
              onTap: onSeeAllTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primary400,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
