import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../shop/presentation/widgets/shop_product_card.dart';
import '../../domain/entities/image_search_result_entity.dart';

class ImageSearchResultsSheet extends StatelessWidget {
  final ImageSearchResultEntity result;
  final VoidCallback onClose;

  const ImageSearchResultsSheet({
    super.key,
    required this.result,
    required this.onClose,
  });

  static Future<void> show(
    BuildContext context, {
    required ImageSearchResultEntity result,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ImageSearchResultsSheet(
        result: result,
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.78.sh,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          // Top drag handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.gray300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Header Row: "Image Search" + close circle button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Image Search',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
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
            ),
          ),
          SizedBox(height: 16.h),

          // Category verification row: [Shoes] "Is this what you meant?"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  height: 36.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: const Color(0x12000000),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        result.detectedCategory,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Is this what you meant?',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF004BFE),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),

          // 2-Column Product Grid
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GridView.builder(
                itemCount: result.products.length,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 14.w,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = result.products[index];
                  return ShopProductCard(
                    product: product,
                    onTap: () {
                      // Navigate to product details
                    },
                  );
                },
              ),
            ),
          ),

          // Bottom small home bar indicator
          Center(
            child: Container(
              width: 134.w,
              height: 5.h,
              margin: EdgeInsets.only(bottom: 8.h, top: 4.h),
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2.5.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
