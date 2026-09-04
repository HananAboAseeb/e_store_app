import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class DiscountFilterOption {
  final String label;
  final int? value;

  const DiscountFilterOption({
    required this.label,
    required this.value,
  });
}

class DiscountFilterBar extends StatelessWidget {
  final int? selectedDiscount;
  final ValueChanged<int?> onDiscountSelected;

  static const List<DiscountFilterOption> options = [
    DiscountFilterOption(label: 'All', value: null),
    DiscountFilterOption(label: '10%', value: 10),
    DiscountFilterOption(label: '20%', value: 20),
    DiscountFilterOption(label: '30%', value: 30),
    DiscountFilterOption(label: '40%', value: 40),
    DiscountFilterOption(label: '50%', value: 50),
  ];

  const DiscountFilterBar({
    super.key,
    required this.selectedDiscount,
    required this.onDiscountSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = option.value == selectedDiscount;

          return GestureDetector(
            onTap: () => onDiscountSelected(option.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFFF3F4F7),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary400
                      : const Color(0xFFE5E7EB),
                  width: isSelected ? 1.8.w : 1.w,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary400.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                option.label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                  color: isSelected
                      ? AppColors.primary400
                      : const Color(0xFF4B5563),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
