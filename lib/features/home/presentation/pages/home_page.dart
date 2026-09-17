import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routing/route_names.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/category_card.dart';
import '../widgets/flash_sale_card.dart';
import '../widgets/flash_sale_timer.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_hero_banner.dart';
import '../widgets/home_section_header.dart';
import '../widgets/home_shimmer_loading.dart';
import '../widgets/new_items_section.dart';
import '../widgets/popular_product_card.dart';
import '../widgets/stuff_for_you_section.dart';
import '../widgets/top_products_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getHomeData(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const HomeShimmerLoading();
            }

            if (state is HomeError) {
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
                        onPressed: () =>
                            context.read<HomeCubit>().getHomeData(),
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

            if (state is HomeLoaded) {
              final data = state.data;

              return RefreshIndicator(
                color: AppColors.primary400,
                backgroundColor: Colors.white,
                onRefresh: () => context.read<HomeCubit>().refresh(),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1: Top AppBar / Search Header
                      HomeAppBar(
                        onTitleTap: _scrollToTop,
                        onSearchTap: () => context.push(RouteNames.kSearchPage),
                        onCameraTap: () =>
                            context.push(RouteNames.kImageSearchPage),
                      ),
                      SizedBox(height: 12.h),

                      // Section 2: Big Sale Hero Banner & Carousel Dots
                      HomeHeroBanner(banners: data.banners),
                      SizedBox(height: 24.h),

                      // Section 3: Categories Section
                      HomeSectionHeader(
                        title: 'Categories',
                        showSeeAll: true,
                        onSeeAllTap: () =>
                            context.push(RouteNames.kCategoriesPage),
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.categories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: 1.14,
                          ),
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              category: data.categories[index],
                              onTap: () =>
                                  context.push(RouteNames.kCategoriesPage),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Section 4: Top Products Section
                      const HomeSectionHeader(title: 'Top Products'),
                      SizedBox(height: 12.h),
                      TopProductsBar(products: data.topProducts),
                      SizedBox(height: 24.h),

                      // Section 5: New Items Section
                      NewItemsSection(products: data.newItems),
                      SizedBox(height: 24.h),

                      // Section 6: Flash Sale Section (With Live Timer)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => GoRouter.of(context)
                            .push(RouteNames.kFlashSalePage),
                        child: HomeSectionHeader(
                          title: 'Flash Sale',
                          trailing: const FlashSaleTimer(),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // 3-column grid for Flash Sale cards (110 x 115)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => GoRouter.of(context)
                            .push(RouteNames.kFlashSalePage),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.flashSaleProducts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12.h,
                              crossAxisSpacing: 12.w,
                              childAspectRatio: 0.95,
                            ),
                            itemBuilder: (context, index) {
                              return FlashSaleCard(
                                product: data.flashSaleProducts[index],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Section 7: Most Popular Section
                      HomeSectionHeader(
                        title: 'Most Popular',
                        showSeeAll: true,
                        onSeeAllTap: () {},
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        height: 140.h,
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: data.popularProducts.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 12.w),
                          itemBuilder: (context, index) {
                            final prod = data.popularProducts[index];
                            return PopularProductCard(product: prod);
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Section 8: Stuff For You Section
                      StuffForYouSection(products: data.stuffForYouProducts),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
