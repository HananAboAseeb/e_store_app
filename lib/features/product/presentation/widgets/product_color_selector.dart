import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/product_variant_entity.dart';

class ProductColorSelector extends StatelessWidget {
  final List<ProductVariantEntity> variants;
  final int selectedIndex;
  final ValueChanged<int> onVariantSelected;

  const ProductColorSelector({
    super.key,
    required this.variants,
    required this.selectedIndex,
    required this.onVariantSelected,
  });

  Color _parseColor(String hex) {
    try {
      final clean = hex.replaceAll('#', '');
      return Color(int.parse('FF$clean', radix: 16));
    } catch (_) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (variants.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF000000),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: List.generate(variants.length, (index) {
              final variant = variants[index];
              final isSelected = index == selectedIndex;
              final variantColor = _parseColor(variant.colorHex);

              return GestureDetector(
                onTap: () => onVariantSelected(index),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 68.w,
                  height: 68.w,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF004BFE)
                          : Colors.transparent,
                      width: 2.w,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Thumbnail Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          variant.thumbnailUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 24.sp,
                              color: AppColors.gray400,
                            ),
                          ),
                        ),
                      ),

                      // Color Circle Badge at bottom-left (Figma spec)
                      Positioned(
                        bottom: 6.h,
                        left: 6.w,
                        child: Container(
                          width: 22.r,
                          height: 22.r,
                          decoration: BoxDecoration(
                            color: variantColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
