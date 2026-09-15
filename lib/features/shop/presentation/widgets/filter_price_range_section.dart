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
          children: [
            Expanded(
              child: Text(
                'Price Range',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              '\$${minPrice.round()} - \$${maxPrice.round()}',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: const Color(0xFFE5E7EB),
            thumbColor: Colors.white,
            trackHeight: 4.h,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 10,
              elevation: 4,
            ),
            overlayColor: AppColors.primary.withOpacity(0.15),
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
