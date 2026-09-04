import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/home_data_entity.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const containerColor = Color(0xFFE5E6EA);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dual Image Preview Boxes (Figma: W:72 H:105, radius:10, fill:#000000 10% with Darken Blend Mode)
            SizedBox(
              height: 94.h,
              child: Row(
                children: [
                  Expanded(
                    child: _buildImageBox(
                      category.previewImageUrls.isNotEmpty
                          ? category.previewImageUrls[0]
                          : null,
                      containerColor,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: _buildImageBox(
                      category.previewImageUrls.length > 1
                          ? category.previewImageUrls[1]
                          : null,
                      containerColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),

            // Bottom: Name (Deep Bold Black) + Count Badge (Blue Pill #004CFF)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF000000),
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF1FF),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${category.itemCount}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF004CFF),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBox(String? imageUrl, Color containerColor) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      alignment: Alignment.center,
      child: imageUrl != null
          ? Padding(
              padding: EdgeInsets.all(4.w),
              child: Image.asset(
                imageUrl,
                color: containerColor,
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
