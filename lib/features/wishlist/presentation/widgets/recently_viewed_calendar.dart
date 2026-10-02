import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class RecentlyViewedCalendar extends StatelessWidget {
  final DateTime displayedMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<int> onMonthChanged;
  final VoidCallback onCollapse;

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  const RecentlyViewedCalendar({
    super.key,
    required this.displayedMonth,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onMonthChanged,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth =
        DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
    final monthName = _monthNames[displayedMonth.month - 1];

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // White Calendar Card with soft drop shadow (Figma Screen 40)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            padding: EdgeInsets.fromLTRB(14.w, 18.h, 14.w, 28.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 24.r,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Month navigation bar (< April >) with light blue accent styling (Figma)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Chevron Button
                    GestureDetector(
                      onTap: () => onMonthChanged(-1),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primarySoft,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.chevron_left,
                            size: 20.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),

                    // Month Pill
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Text(
                        monthName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    // Right Chevron Button
                    GestureDetector(
                      onTap: () => onMonthChanged(1),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primarySoft,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.chevron_right,
                            size: 20.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // 7-column day pills grid (01 - 31) - Figma inspect: 40x32, r48
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: daysInMonth,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 6.w,
                    childAspectRatio: 40 / 32,
                  ),
                  itemBuilder: (context, index) {
                    final dayNumber = index + 1;
                    final date = DateTime(
                      displayedMonth.year,
                      displayedMonth.month,
                      dayNumber,
                    );
                    final isSelected = date.year == selectedDate.year &&
                        date.month == selectedDate.month &&
                        date.day == selectedDate.day;

                    return GestureDetector(
                      onTap: () => onDateSelected(date),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 40.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primarySoft
                              : AppColors.surfaceOption,
                          borderRadius: BorderRadius.circular(48.r),
                        ),
                        child: Center(
                          child: Text(
                            dayNumber.toString().padLeft(2, '0'),
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Collapse button (^) overlapping bottom edge of card (Figma Screen 40)
          Positioned(
            bottom: -6.h,
            child: GestureDetector(
              onTap: onCollapse,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white,
                    width: 2.5.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 6.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
