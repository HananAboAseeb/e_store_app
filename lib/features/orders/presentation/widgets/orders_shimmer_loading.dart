import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_shimmer.dart';

class OrdersShimmerLoading extends StatelessWidget {
  const OrdersShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomShimmer(
                        width: 52.w,
                        height: 52.w,
                        borderRadius: 10.r,
                      ),
                      SizedBox(width: 8.w),
                      CustomShimmer(
                        width: 52.w,
                        height: 52.w,
                        borderRadius: 10.r,
                      ),
                      SizedBox(width: 8.w),
                      CustomShimmer(
                        width: 52.w,
                        height: 52.w,
                        borderRadius: 10.r,
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomShimmer(
                    width: 88.w,
                    height: 36.h,
                    borderRadius: 20.r,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                color: AppColors.divider,
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomShimmer(
                        width: 140.w,
                        height: 16.h,
                        borderRadius: 4.r,
                      ),
                      SizedBox(height: 6.h),
                      CustomShimmer(
                        width: 90.w,
                        height: 12.h,
                        borderRadius: 4.r,
                      ),
                      SizedBox(height: 8.h),
                      CustomShimmer(
                        width: 60.w,
                        height: 22.h,
                        borderRadius: 8.r,
                      ),
                    ],
                  ),
                  CustomShimmer(
                    width: 70.w,
                    height: 16.h,
                    borderRadius: 4.r,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
