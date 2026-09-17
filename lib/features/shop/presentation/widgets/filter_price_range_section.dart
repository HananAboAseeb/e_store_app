import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class FilterPriceRangeSection extends StatelessWidget {
  final double minPrice;
  final double maxPrice;
  final ValueChanged<RangeValues>? onPriceRangeChanged;

  const FilterPriceRangeSection({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    this.onPriceRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                'Price Range',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '\$${minPrice.round()} - \$${maxPrice.round()}',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: const Color(0xFF004BFE),
            inactiveTrackColor: const Color(0xFFD1D5DB),
            thumbColor: const Color(0xFFE5E7EB),
            trackHeight: 4.h,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 13,
              elevation: 3,
            ),
            overlayColor: const Color(0xFF004BFE).withOpacity(0.12),
          ),
          child: RangeSlider(
            values: RangeValues(minPrice, maxPrice),
            min: 10.0,
            max: 150.0,
            divisions: 28,
            onChanged: (values) => onPriceRangeChanged?.call(values),
          ),
        ),
      ],
    );
  }
}
