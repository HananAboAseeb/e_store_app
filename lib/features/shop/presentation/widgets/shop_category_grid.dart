import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/shop_category_entity.dart';
import 'shop_category_tile.dart';

class ShopCategoryGrid extends StatelessWidget {
  final List<ShopCategoryEntity> categories;
  final String? selectedCategory;
  final ValueChanged<String>? onCategorySelected;

  const ShopCategoryGrid({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    // Split into 2 rows: first 5 items, remaining items
    final row1Count = (categories.length > 5) ? 5 : categories.length;
    final row1 = categories.sublist(0, row1Count);
    final row2 =
        categories.length > 5 ? categories.sublist(5) : <ShopCategoryEntity>[];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: row1.map((category) {
              final isSelected = selectedCategory?.toLowerCase() ==
                  category.name.toLowerCase();
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: ShopCategoryTile(
                  category: category,
                  isSelected: isSelected,
                  onTap: () => onCategorySelected?.call(category.name),
                ),
              );
            }).toList(),
          ),
          if (row2.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              children: row2.map((category) {
                final isSelected = selectedCategory?.toLowerCase() ==
                    category.name.toLowerCase();
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: ShopCategoryTile(
                    category: category,
                    isSelected: isSelected,
                    onTap: () => onCategorySelected?.call(category.name),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
