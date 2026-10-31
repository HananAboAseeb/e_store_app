import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/modal_close_button.dart';
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
      barrierColor: AppColors.black.withOpacity(0.18),
      builder: (context) {
        final keyboardInset = MediaQuery.of(context).viewInsets.bottom;
        final isKeyboardOpen = keyboardInset > 0;
        // Float above bottom nav bar when keyboard is closed, or sit right above keyboard
        final bottomOffset = isKeyboardOpen ? keyboardInset : 88.h;

        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: const SizedBox.expand(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomOffset),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        (isKeyboardOpen ? 0.65 : 0.82),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(26.r),
                      bottom: Radius.circular(isKeyboardOpen ? 0 : 26.r),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 20,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    bottom: !isKeyboardOpen,
                    child: ReviewSheet(
                      item: item,
                      onReviewSubmitted: onReviewSubmitted,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  int _rating = 0;
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
      rating: _rating > 0 ? _rating : 5,
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
    final displayOrderId = widget.item.orderId.isNotEmpty &&
            !widget.item.orderId.startsWith('order-')
        ? 'Order #${widget.item.orderId}'
        : 'Order #92287157';

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
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
                  fontWeight: FontWeight.w900,
                  fontSize: 22.sp,
                  color: Colors.black,
                ),
              ),
              const ModalCloseButton(),
            ],
          ),

          SizedBox(height: 16.h),

          // User Profile & Order Summary matching Figma Screen 66
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primarySoft,
                    width: 1.5.w,
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile_picture.png'),
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
                      widget.item.title.isNotEmpty
                          ? widget.item.title
                          : 'Lorem ipsum dolor sit amet consectetur.',
                      style: AppTypography.caption.copyWith(
                        color: const Color(0xFF4B5563),
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      displayOrderId,
                      style: AppTypography.body.copyWith(
                        color: const Color(0xFF111827),
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),

          // 5 Amber Rating Stars (Default outline matching Figma Screen 66)
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
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Icon(
                      isFilled
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 36.sp,
                      color: const Color(0xFFFFA800),
                    ),
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: 18.h),

          // Borderless Light-Blue Comment Box matching Figma Screen 66
          Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF5FF),
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.all(12.r),
            child: TextField(
              controller: _commentController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: AppTypography.body.copyWith(
                fontSize: 14.sp,
                color: const Color(0xFF1F2937),
              ),
              decoration: InputDecoration(
                hintText: 'Your comment',
                hintStyle: AppTypography.body.copyWith(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          SizedBox(height: 18.h),

          // Send Review Button
          GestureDetector(
            onTap: _isSubmitting ? null : _submitReview,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF004BFE),
                borderRadius: BorderRadius.circular(24.r),
              ),
              alignment: Alignment.center,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Send Review',
                      style: AppTypography.buttonText.copyWith(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
