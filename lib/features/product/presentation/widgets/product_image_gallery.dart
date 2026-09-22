import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ProductImageGallery extends StatefulWidget {
  final List<String> images;

  const ProductImageGallery({
    super.key,
    required this.images,
  });

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images.isNotEmpty
        ? widget.images
        : const ['assets/images/jact.png'];

    return Column(
      children: [
        // Main Image Area
        Container(
          height: 380.h,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFF5F5F5),
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 64.sp,
                        color: AppColors.gray400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Page Indicator Dots
        if (images.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(images.length, (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: isActive ? 12.w : 6.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : const Color(0xFFD1D1D6),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              );
            }),
          ),
      ],
    );
  }
}
