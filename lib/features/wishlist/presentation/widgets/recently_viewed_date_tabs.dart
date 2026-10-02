import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/date_tab_entity.dart';

class RecentlyViewedDateTabs extends StatelessWidget {
  final List<DateTabEntity> tabs;
  final String activeTabId;
  final ValueChanged<String> onTabSelected;
  final VoidCallback onToggleCalendar;
  final bool isCalendarExpanded;

  const RecentlyViewedDateTabs({
    super.key,
    required this.tabs,
    required this.activeTabId,
    required this.onTabSelected,
    required this.onToggleCalendar,
    this.isCalendarExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          // Equal-width date tabs expanding to fill all available width
          ...tabs.map((tab) {
            final isSelected = tab.id == activeTabId;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: GestureDetector(
                  onTap: () => onTabSelected(tab.id),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primarySoft
                          : AppColors.surfaceOption,
                      borderRadius: BorderRadius.circular(38.r),
                    ),
                    child: isSelected
                        ? Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 8.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    tab.label,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Container(
                                  width: 20.w,
                                  height: 20.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      size: 13.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                tab.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            );
          }),

          // Chevron collapse/expand button aligned to the far right
          GestureDetector(
            onTap: onToggleCalendar,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isCalendarExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
