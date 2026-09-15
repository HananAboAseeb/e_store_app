import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/gender_filter.dart';

class GenderTabBar extends StatelessWidget {
  final GenderFilter activeGender;
  final ValueChanged<GenderFilter> onGenderSelected;

  const GenderTabBar({
    super.key,
    required this.activeGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.5.w, vertical: 8.h),
      child: Row(
        children: GenderFilter.values.map((gender) {
          final isActive = gender == activeGender;
          return Expanded(
            child: GestureDetector(
              onTap: () => onGenderSelected(gender),
              child: Container(
                height: 36.h,
                margin: EdgeInsets.only(
                  right: gender != GenderFilter.male ? 8.w : 0,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFE5EBFC)
                      : const Color(0x1A000000),
                  borderRadius: BorderRadius.circular(18.r),
                  border: isActive
                      ? Border.all(
                          color: const Color(0xFF004CFF),
                          width: 1.5,
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  gender.label,
                  style: TextStyle(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? const Color(0xFF004BFE)
                        : const Color(0xFF000000),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
