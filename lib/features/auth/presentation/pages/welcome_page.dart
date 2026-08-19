import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/primary_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Hello',
      'subtitle':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.',
      'type': 'info',
    },
    {
      'title': 'Ready?',
      'subtitle':
          'Explore thousands of products and start your shopping journey today with ShopX.',
      'type': 'action',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // Soft blue gradient radial blur at top
            Positioned(
              top: -120.h,
              left: 0,
              right: 0,
              child: Container(
                height: 450.h,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.85,
                    colors: [
                      AppColors.primary400.withOpacity(0.18),
                      AppColors.primary200.withOpacity(0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  // Card Carousel
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _slides.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final slide = _slides[index];
                        final isActionSlide = slide['type'] == 'action';

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(28.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Shopping illustration image
                                Expanded(
                                  flex: 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: Container(
                                      width: double.infinity,
                                      color: const Color(0xFFFFC0D3), // Pink shopping background
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.shopping_bag_rounded,
                                            size: 100.sp,
                                            color: AppColors.primary400.withOpacity(0.25),
                                          ),
                                          Positioned(
                                            bottom: 24.h,
                                            child: Text(
                                              '🛍️✨',
                                              style: TextStyle(fontSize: 48.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24.h),

                                // Title
                                Text(
                                  slide['title']!,
                                  style: AppTypography.h1.copyWith(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 12.h),

                                // Subtitle or action
                                if (!isActionSlide) ...[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Text(
                                      slide['subtitle']!,
                                      textAlign: TextAlign.center,
                                      style: AppTypography.bodySmall.copyWith(
                                        fontSize: 15.sp,
                                        color: AppColors.textSecondary,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ] else ...[
                                  const Spacer(),
                                  PrimaryButton(
                                    text: "Let's Start",
                                    onPressed: () {
                                      context.go('/home');
                                    },
                                  ),
                                  SizedBox(height: 8.h),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Dot Indicators (4 dots matching Figma design)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        final bool isActive = index == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive
                                ? AppColors.primary400
                                : AppColors.primary50,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
