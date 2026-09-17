import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/filter_criteria_entity.dart';
import '../../domain/entities/shop_category_entity.dart';
import '../cubit/filter_cubit.dart';
import '../cubit/filter_state.dart';
import '../widgets/filter_category_tile.dart';
import '../widgets/filter_color_section.dart';
import '../widgets/filter_price_range_section.dart';
import '../widgets/filter_size_section.dart';
import '../widgets/filter_sort_section.dart';

class FilterModalSheet extends StatelessWidget {
  final List<ShopCategoryEntity> categories;
  final FilterCriteriaEntity initialCriteria;

  const FilterModalSheet({
    super.key,
    required this.categories,
    required this.initialCriteria,
  });

  static Future<FilterCriteriaEntity?> show(
    BuildContext context, {
    required List<ShopCategoryEntity> categories,
    required FilterCriteriaEntity initialCriteria,
  }) {
    return Navigator.of(context).push<FilterCriteriaEntity>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => FilterModalSheet(
          categories: categories,
          initialCriteria: initialCriteria,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(initialCriteria),
      child: _FilterModalContent(categories: categories),
    );
  }
}

class _FilterModalContent extends StatelessWidget {
  final List<ShopCategoryEntity> categories;

  const _FilterModalContent({required this.categories});

  @override
  Widget build(BuildContext context) {
    final row1Count = (categories.length > 5) ? 5 : categories.length;
    final row1 = categories.sublist(0, row1Count);
    final row2 =
        categories.length > 5 ? categories.sublist(5) : <ShopCategoryEntity>[];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Bar
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFEFF1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 20.sp,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Filter Sections
            Expanded(
              child: BlocBuilder<FilterCubit, FilterState>(
                builder: (context, state) {
                  final cubit = context.read<FilterCubit>();

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sub-Categories Section (NO 'Category' title per Figma 33)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: row1.map((category) {
                                  final isSelected = state.selectedSubCategories
                                      .any((c) =>
                                          c.toLowerCase() ==
                                          category.name.toLowerCase());
                                  return Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: FilterCategoryTile(
                                      category: category,
                                      isSelected: isSelected,
                                      onTap: () =>
                                          cubit.toggleCategory(category.name),
                                    ),
                                  );
                                }).toList(),
                              ),
                              if (row2.isNotEmpty) ...[
                                SizedBox(height: 12.h),
                                Row(
                                  children: row2.map((category) {
                                    final isSelected =
                                        state.selectedSubCategories.any((c) =>
                                            c.toLowerCase() ==
                                            category.name.toLowerCase());
                                    return Padding(
                                      padding: EdgeInsets.only(right: 12.w),
                                      child: FilterCategoryTile(
                                        category: category,
                                        isSelected: isSelected,
                                        onTap: () =>
                                            cubit.toggleCategory(category.name),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Size Section
                        FilterSizeSection(
                          sizeType: state.sizeType,
                          selectedSize: state.selectedSize,
                          onSizeTypeChanged: (type) => cubit.setSizeType(type),
                          onSizeSelected: (size) => cubit.selectSize(size),
                        ),
                        SizedBox(height: 24.h),

                        // Color Section
                        FilterColorSection(
                          selectedColor: state.selectedColor,
                          onColorSelected: (color) => cubit.selectColor(color),
                        ),
                        SizedBox(height: 24.h),

                        // Price Range Section
                        FilterPriceRangeSection(
                          minPrice: state.minPrice,
                          maxPrice: state.maxPrice,
                          onPriceRangeChanged: (values) =>
                              cubit.updatePriceRange(values.start, values.end),
                        ),
                        SizedBox(height: 20.h),

                        // Sort Section (NO 'Sort by' title per Figma 33)
                        FilterSortSection(
                          selectedOption: state.sortOption,
                          onSortOptionSelected: (option) =>
                              cubit.setSortOption(option),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Fixed Bottom Action Buttons (Clear & Apply)
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
              child: BlocBuilder<FilterCubit, FilterState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      // Clear Button (Filled light gray per Figma)
                      Expanded(
                        child: SizedBox(
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: () =>
                                context.read<FilterCubit>().clearAll(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE5E5EA),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26.r),
                              ),
                            ),
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      // Apply Button (Filled royal blue per Figma)
                      Expanded(
                        child: SizedBox(
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(state.toCriteria());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004BFE),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26.r),
                              ),
                            ),
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
