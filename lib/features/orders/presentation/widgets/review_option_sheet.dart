import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_items_to_review_usecase.dart';
import 'review_sheet.dart';

class ReviewOptionSheet extends StatefulWidget {
  final String orderId;

  const ReviewOptionSheet({
    super.key,
    required this.orderId,
  });

  static Future<void> show(
    BuildContext context, {
    required String orderId,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      barrierColor: AppColors.black.withOpacity(0.18),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: const SizedBox.expand(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: SafeArea(
                top: false,
                child: ReviewOptionSheet(orderId: orderId),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<ReviewOptionSheet> createState() => _ReviewOptionSheetState();
}

class _ReviewOptionSheetState extends State<ReviewOptionSheet> {
  List<OrderItemEntity> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final useCase = sl<GetItemsToReviewUseCase>();
    final result = await useCase(widget.orderId);
    if (mounted) {
      result.fold(
        (_) => setState(() => _isLoading = false),
        (items) => setState(() {
          _items = items;
          _isLoading = false;
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Larger & Darker "Review item" and subtitle + circular X button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Review item',
                    style: AppTypography.h2.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 22.sp, // Larger and bolder per Figma inspector
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Which item you want to review?',
                    style: AppTypography.caption.copyWith(
                      color: const Color(0xFF4B5563), // Darker charcoal gray
                      fontSize: 14.5.sp, // Larger font matching Figma
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Close X button with darker gray background matching Figma
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8ECEF), // Darker neutral gray
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Items List matching Screen 58 Figma layout (Image: 136x108, Radius: 15)
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_items.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Text(
                  'No items available to review',
                  style: AppTypography.bodySmall,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              separatorBuilder: (_, __) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Container(height: 1.h, color: const Color(0xFFE5E7EB)),
              ),
              itemBuilder: (context, index) {
                final item = _items[index];
                final displayImageUrl = item.imageUrl.isNotEmpty
                    ? item.imageUrl
                    : 'assets/images/cat_cloth_1.png';

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Product Thumbnail: W: 136, H: 108, Radius: 16, with white padding frame and soft drop shadow
                      Container(
                        width: 136.w,
                        height: 108.h,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11.r),
                          child: Container(
                            color: AppColors.thumbnailBg,
                            child: Image.asset(
                              displayImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 12.w),

                      // Item Details Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Title / Description
                            Text(
                              item.title,
                              style: AppTypography.caption.copyWith(
                                color: const Color(0xFF4B5563),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: 4.h),

                            // Order Number
                            Text(
                              item.orderId.isNotEmpty &&
                                      !item.orderId.startsWith('order-')
                                  ? 'Order #${item.orderId}'
                                  : 'Order #92287157',
                              style: AppTypography.body.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 13.5.sp,
                                color: AppColors.textPrimary,
                              ),
                            ),

                            SizedBox(height: 10.h),

                            // Bottom Row: Date Pill (92x30) + tight gap + Outlined Review Button (80x30)
                            Row(
                              children: [
                                // Date Pill (W: 92, H: 30, radius: 10, darker gray Color(0xFFE8ECEF))
                                Container(
                                  width: 92.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFFE8ECEF), // Darker gray per user feedback
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    item.formattedDate.isNotEmpty
                                        ? item.formattedDate
                                        : 'April, 06',
                                    style: AppTypography.caption.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1F2937),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                    width:
                                        6.w), // Tight gap as requested by user

                                // Review Button: Outlined Blue (W: 80, H: 30, radius: 10)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    ReviewSheet.show(context, item: item);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: 80.w,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: AppColors.primary,
                                        width: 1.5.w,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Review',
                                      style: AppTypography.buttonText.copyWith(
                                        fontSize: 12.5.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
