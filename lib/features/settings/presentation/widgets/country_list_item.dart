import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/country_entity.dart';

class CountryListItem extends StatelessWidget {
  final CountryEntity country;
  final VoidCallback onTap;

  const CountryListItem({
    super.key,
    required this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 46.h,
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        alignment: Alignment.centerLeft,
        child: AppText(
          country.name,
          style: AppTypography.body.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
