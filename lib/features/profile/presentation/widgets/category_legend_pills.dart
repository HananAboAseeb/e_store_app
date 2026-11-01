import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/category_spending_entity.dart';

class CategoryLegendPills extends StatelessWidget {
  final List<CategorySpendingEntity> categories;

  const CategoryLegendPills({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.w,
        runSpacing: 8.h,
        children: categories.map((cat) {
          return _CategoryPill(category: cat);
        }).toList(),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  final CategorySpendingEntity category;

  const _CategoryPill({required this.category});

  Color _resolveColor(String key) {
    switch (key) {
      case 'chartBlue':
        return AppColors.chartBlue;
      case 'chartGreen':
        return AppColors.chartGreen;
      case 'chartOrange':
        return AppColors.chartOrange;
      case 'chartRed':
        return AppColors.chartRed;
      default:
        return AppColors.primary400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedAmount =
        '\$${category.amount.toStringAsFixed(2).replaceAll('.', ',')}';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: _resolveColor(category.colorTokenKey),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText.caption(
        '${category.name} $formattedAmount',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}
