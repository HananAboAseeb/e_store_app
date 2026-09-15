import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/category_group_entity.dart';
import 'sub_category_pill.dart';

class CategoryAccordionTile extends StatelessWidget {
  final CategoryGroupEntity group;
  final bool isExpanded;
  final VoidCallback onToggle;
  final void Function(String subCategoryName)? onSubCategoryTap;

  const CategoryAccordionTile({
    super.key,
    required this.group,
    required this.isExpanded,
    required this.onToggle,
    this.onSubCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.5.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Header row ──
            SizedBox(
              height: 48.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Icon(
                      group.icon,
                      color: const Color(0xFF004BFE),
                      size: 22.r,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        group.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                    isExpanded
                        ? Container(
                            width: 28.r,
                            height: 28.r,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE5EBFC),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_up_rounded,
                              size: 18,
                              color: Color(0xFF004BFE),
                            ),
                          )
                        : const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 22,
                            color: Color(0xFF004BFE),
                          ),
                  ],
                ),
              ),
            ),

            // ── Expanded sub-categories ──
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: _buildSubCategoryGrid(),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubCategoryGrid() {
    if (group.subCategories.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(
        left: 14.w,
        right: 14.w,
        bottom: 12.h,
        top: 2.h,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: group.subCategories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 6.h,
          childAspectRatio: 4.4,
        ),
        itemBuilder: (context, index) {
          final sub = group.subCategories[index];
          return SubCategoryPill(
            name: sub.name,
            onTap: onSubCategoryTap != null
                ? () => onSubCategoryTap!(sub.name)
                : null,
          );
        },
      ),
    );
  }
}
