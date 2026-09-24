import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/shipping_option_entity.dart';

class ShippingOptionsSection extends StatelessWidget {
  final List<ShippingOptionEntity> options;
  final String selectedOptionId;
  final ValueChanged<String> onSelectOption;

  const ShippingOptionsSection({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.onSelectOption,
  });

  @override
  Widget build(BuildContext context) {
    final selectedOption = options.firstWhere(
      (o) => o.id == selectedOptionId,
      orElse: () => options.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping Options',
          style: AppTypography.h2.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.sm),

        // List of options
        ...options.map((option) {
          final isSelected = option.id == selectedOptionId;

          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: GestureDetector(
              onTap: () => onSelectOption(option.id),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 14.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primarySoft
                      : AppColors.surfaceOption,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    // Checkbox / Radio indicator
                    Container(
                      width: 22.h,
                      height: 22.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.transparent,
                        border: isSelected
                            ? null
                            : Border.all(
                                color: AppColors.gray400,
                                width: 1.5.w,
                              ),
                      ),
                      alignment: Alignment.center,
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              size: 14.sp,
                              color: AppColors.white,
                            )
                          : null,
                    ),
                    SizedBox(width: 12.w),

                    // Option Name & duration pill
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8.w,
                        runSpacing: 4.h,
                        children: [
                          Text(
                            option.name,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.primarySoft,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              option.duration,
                              style: AppTypography.caption.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // Price
                    Text(
                      '\$${option.price.toStringAsFixed(2)}',
                      style: AppTypography.body.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

        SizedBox(height: 2.h),
        Text(
          selectedOption.estimatedDate,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
