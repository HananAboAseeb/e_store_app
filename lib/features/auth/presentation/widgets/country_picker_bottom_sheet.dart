import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../models/country_code.dart';

class CountryPickerBottomSheet extends StatelessWidget {
  final ValueChanged<CountryCode> onCountrySelected;
  final List<CountryCode> countries;

  const CountryPickerBottomSheet({
    super.key,
    required this.onCountrySelected,
    this.countries = CountryCode.defaultCountries,
  });

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<CountryCode> onCountrySelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => CountryPickerBottomSheet(
        onCountrySelected: onCountrySelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'Select Country',
              style: AppTypography.h2.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ...countries.map(
            (c) => ListTile(
              leading: Text(c.flag, style: TextStyle(fontSize: 24.sp)),
              title: Text(c.name, style: AppTypography.body),
              trailing: Text(
                c.dialCode,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                onCountrySelected(c);
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
