import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/recommendation_entity.dart';
import 'search_chip.dart';

class SearchRecommendationsSection extends StatelessWidget {
  final List<RecommendationEntity> recommendations;
  final ValueChanged<String> onChipTap;

  const SearchRecommendationsSection({
    super.key,
    required this.recommendations,
    required this.onChipTap,
  });

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendations',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: recommendations.map((item) {
            return SearchChip(
              label: item.label,
              onTap: () => onChipTap(item.label),
            );
          }).toList(),
        ),
      ],
    );
  }
}
