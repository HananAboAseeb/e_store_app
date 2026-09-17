import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/search_history_entity.dart';
import 'search_chip.dart';

class SearchHistorySection extends StatelessWidget {
  final List<SearchHistoryEntity> history;
  final VoidCallback onClearHistory;
  final ValueChanged<String> onChipTap;

  const SearchHistorySection({
    super.key,
    required this.history,
    required this.onClearHistory,
    required this.onChipTap,
  });

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search History',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: onClearHistory,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Icon(
                  Icons.delete_outline,
                  color: const Color(0xFFFF4D4F),
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: history.map((item) {
            return SearchChip(
              label: item.query,
              onTap: () => onChipTap(item.query),
            );
          }).toList(),
        ),
      ],
    );
  }
}
