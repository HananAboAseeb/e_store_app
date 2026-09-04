import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/home_data_entity.dart';

class HomeHeroBanner extends StatefulWidget {
  final List<HomeBannerEntity> banners;
  final ValueChanged<HomeBannerEntity>? onBannerTap;

  const HomeHeroBanner({
    super.key,
    required this.banners,
    this.onBannerTap,
  });

  @override
  State<HomeHeroBanner> createState() => _HomeHeroBannerState();
}

class _HomeHeroBannerState extends State<HomeHeroBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        // Banner Slider
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.banners.length,
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GestureDetector(
                  onTap: () => widget.onBannerTap?.call(banner),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      // Fallback gradient behind background image
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF004BFE),
                          Color(0xFF001850),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/banner_Slid_background_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        // Left Text Content
                        Positioned(
                          left: 20.w,
                          top: 0,
                          bottom: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                banner.title,
                                style: AppTypography.h1.copyWith(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textWhite,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                banner.subtitle,
                                style: AppTypography.bodySmall.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.90),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Right Girl Image Overlay
                        Positioned(
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child: Image.asset(
                            banner.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12.h),

        // 6-Dot Carousel Indicator with Active Pill
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            final isActive = index == (_currentPage % 6);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.symmetric(horizontal: 2.5.w),
              width: isActive ? 24.w : 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.r),
                color: isActive
                    ? AppColors.primary400
                    : AppColors.primary50.withOpacity(0.8),
              ),
            );
          }),
        ),
      ],
    );
  }
}
