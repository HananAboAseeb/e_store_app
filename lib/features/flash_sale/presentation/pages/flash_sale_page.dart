import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../home/domain/entities/home_data_entity.dart';
import '../../../home/presentation/widgets/home_section_header.dart';
import '../../../home/presentation/widgets/popular_product_card.dart';
import '../cubit/flash_sale_cubit.dart';
import '../cubit/flash_sale_state.dart';
import '../widgets/discount_filter_bar.dart';
import '../widgets/flash_sale_app_bar.dart';
import '../widgets/flash_sale_live_banner.dart';
import '../widgets/flash_sale_product_card.dart';
import '../widgets/flash_sale_promo_banner.dart';
import '../widgets/flash_sale_shimmer_loading.dart';

class FlashSalePage extends StatelessWidget {
  const FlashSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FlashSaleCubit>()..loadFlashSaleData(),
      child: const _FlashSaleView(),
    );
  }
}

class _FlashSaleView extends StatelessWidget {
  const _FlashSaleView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Top Blue Aura Bubble Background (Figma: full width, heavy blue on top-right fading to white)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 240.h,
            child: IgnorePointer(
              child: Image.asset(
                'assets/images/Bubbles_flash_sale.png',
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.topRight,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
          ),
          SafeArea(
            child: BlocBuilder<FlashSaleCubit, FlashSaleState>(
              builder: (context, state) {
                if (state is FlashSaleLoading || state is FlashSaleInitial) {
                  return const FlashSaleShimmerLoading();
                }

                if (state is FlashSaleError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: AppTypography.body.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () => context
                                .read<FlashSaleCubit>()
                                .loadFlashSaleData(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary400,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is FlashSaleLoaded) {
                  final discountTitle = state.selectedDiscount != null
                      ? '${state.selectedDiscount}% Discount'
                      : 'All Discounts';

                  return RefreshIndicator(
                    color: AppColors.primary400,
                    backgroundColor: Colors.white,
                    onRefresh: () => context.read<FlashSaleCubit>().refresh(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section 1: Flash Sale Custom AppBar with Countdown (No Back Button)
                          FlashSaleAppBar(
                            initialDuration: state.countdownDuration,
                          ),
                          SizedBox(height: 12.h),

                          // Section 2: Discount Filter Bar
                          DiscountFilterBar(
                            selectedDiscount: state.selectedDiscount,
                            onDiscountSelected: (val) {
                              context
                                  .read<FlashSaleCubit>()
                                  .selectDiscountFilter(val);
                            },
                          ),
                          SizedBox(height: 18.h),

                          // Section 3: Live Stream Showcase Banner
                          FlashSaleLiveBanner(
                            liveStream: state.liveStream,
                            onTap: () {},
                          ),
                          SizedBox(height: 22.h),

                          // Section 4: Discount Section Header with Filter Settings Gear (Figma: Standalone gray gear)
                          HomeSectionHeader(
                            title: discountTitle,
                            trailing: GestureDetector(
                              onTap: () {
                                // Filter settings action
                              },
                              child: Icon(
                                Icons.settings_outlined,
                                size: 22.sp,
                                color: const Color(0xFF8E8E93),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),

                          // Section 5: 2-Column Product Grid (Fixed childAspectRatio: 0.65 for zero overflow)
                          if (state.filteredProducts.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 40.h,
                              ),
                              child: Center(
                                child: Text(
                                  'No products found for this discount tier.',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.filteredProducts.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.h,
                                  crossAxisSpacing: 14.w,
                                  childAspectRatio: 0.65,
                                ),
                                itemBuilder: (context, index) {
                                  return FlashSaleProductCard(
                                    product: state.filteredProducts[index],
                                    onTap: () {},
                                  );
                                },
                              ),
                            ),
                          SizedBox(height: 24.h),

                          // Section 6: Big Sale Promotional Split Banner
                          FlashSalePromoBanner(
                            onTap: () {},
                          ),
                          SizedBox(height: 24.h),

                          // Section 7: Most Popular Section Header
                          HomeSectionHeader(
                            title: 'Most Popular',
                            showSeeAll: true,
                            onSeeAllTap: () {},
                          ),
                          SizedBox(height: 12.h),

                          // Section 8: Most Popular Horizontal Product Carousel (Compact height 140.h)
                          SizedBox(
                            height: 140.h,
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              scrollDirection: Axis.horizontal,
                              itemCount: state.popularProducts.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 12.w),
                              itemBuilder: (context, index) {
                                final prod = state.popularProducts[index];
                                // Adapt to HomeProductEntity for PopularProductCard reuse
                                final homeProduct = HomeProductEntity(
                                  id: prod.id,
                                  title: prod.title,
                                  price: prod.currentPrice,
                                  imageUrl: prod.imageUrl,
                                  discountPercentage: prod.discountPercentage,
                                  likeCount: prod.likeCount,
                                  tag: prod.tag,
                                );

                                return PopularProductCard(
                                  product: homeProduct,
                                  onTap: () {},
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
