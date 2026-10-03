import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/modal_close_button.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/submit_review_usecase.dart';
import 'review_done_dialog.dart';

class ReviewSheet extends StatefulWidget {
  final OrderItemEntity item;
  final VoidCallback? onReviewSubmitted;

  const ReviewSheet({
    super.key,
    required this.item,
    this.onReviewSubmitted,
  });

  static Future<void> show(
    BuildContext context, {
    required OrderItemEntity item,
    VoidCallback? onReviewSubmitted,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      barrierColor: AppColors.black.withOpacity(0.15),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: const SizedBox.expand(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24.r)),
                ),
                child: ReviewSheet(
                  item: item,
                  onReviewSubmitted: onReviewSubmitted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  int _rating = 5;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    setState(() => _isSubmitting = true);

    final review = OrderReviewEntity(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      orderId: widget.item.orderId,
      itemId: widget.item.id,
      rating: _rating,
      comment: _commentController.text.trim(),
      submittedAt: DateTime.now(),
    );

    final useCase = sl<SubmitReviewUseCase>();
    await useCase(review);

    if (mounted) {
      Navigator.of(context).pop(); // Close ReviewSheet
      widget.onReviewSubmitted?.call();
      ReviewDoneDialog.show(context); // Open ReviewDoneDialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Review + Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Review',
                style: AppTypography.h2.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              const ModalCloseButton(),
            ],
          ),

          SizedBox(height: 16.h),

          // Product Summary Row
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.surfaceCardImage,
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: AssetImage(widget.item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.title,
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        fontSize: 13.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.item.orderId.isNotEmpty
                          ? 'Order #${widget.item.orderId}'
                          : 'Order #92287157',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // 5 Tappable Rating Stars (reusing star pattern)
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final isFilled = index < _rating;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Icon(
                      isFilled
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 34.sp,
                      color: AppColors.starGold,
                    ),
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: 20.h),

          // Comment Input Field
          Text(
            'Your comment',
            style: AppTypography.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _commentController,
            maxLines: 4,
            style: AppTypography.body.copyWith(
              fontSize: 14.sp,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Write your review here...',
              hintStyle: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: EdgeInsets.all(12.r),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Send Review Button (reusing PrimaryButton)
          PrimaryButton(
            text: 'Send Review',
            isLoading: _isSubmitting,
            onPressed: _submitReview,
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
