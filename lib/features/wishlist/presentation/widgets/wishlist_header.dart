import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';

class WishlistHeader extends StatelessWidget {
  final VoidCallback? onClose;

  const WishlistHeader({
    super.key,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Wishlist',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => context.push(RouteNames.kRecentlyViewedPage),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  margin: EdgeInsets.only(right: 8.w),
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceOption,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.history,
                      size: 18.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (onClose != null) {
                    onClose!();
                  } else if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(RouteNames.kHomePage);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceOption,
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
          ),
        ],
      ),
    );
  }
}
