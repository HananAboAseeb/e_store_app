import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/home_data_entity.dart';
import 'home_section_header.dart';
import 'product_card_standard.dart';

class StuffForYouSection extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<HomeProductEntity> products;
  final ValueChanged<HomeProductEntity>? onProductTap;

  const StuffForYouSection({
    super.key,
    this.title = 'Stuff for you',
    this.leading,
    required this.products,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionHeader(
          title: title,
          leading: leading ??
              Icon(
                Icons.star_rounded,
                size: 22.sp,
                color: const Color(0xFF004BFE),
              ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              for (int i = 0; i < products.length; i += 2) ...[
                if (i > 0) SizedBox(height: 14.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ProductCardStandard(
                        product: products[i],
                        onTap: () => onProductTap?.call(products[i]),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    if (i + 1 < products.length)
                      Expanded(
                        child: ProductCardStandard(
                          product: products[i + 1],
                          onTap: () => onProductTap?.call(products[i + 1]),
                        ),
                      )
                    else
                      const Expanded(child: SizedBox.shrink()),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
