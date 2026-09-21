import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/shop_cubit.dart';
import '../cubit/shop_state.dart';
import '../widgets/shop_app_bar.dart';
import '../widgets/shop_category_grid.dart';
import '../widgets/shop_product_card.dart';
import '../widgets/shop_shimmer_loading.dart';
import 'filter_modal_sheet.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ShopCubit>()..loadShopData(),
      child: const _ShopView(),
    );
  }
}

class _ShopView extends StatelessWidget {
  const _ShopView();

  void _openFilter(BuildContext context, ShopLoaded state) async {
    final newCriteria = await FilterModalSheet.show(
      context,
      categories: state.categories,
      initialCriteria: state.filterCriteria,
    );

    if (newCriteria != null && context.mounted) {
      context.read<ShopCubit>().applyFilter(newCriteria);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading || state is ShopInitial) {
            return const SafeArea(
              child: Column(
                children: [
                  ShopAppBar(),
                  Expanded(child: ShopShimmerLoading()),
                ],
              ),
            );
          }

          if (state is ShopError) {
            return SafeArea(
              child: Column(
                children: [
                  const ShopAppBar(),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48.sp,
                              color: AppColors.error,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<ShopCubit>().loadShopData(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              child: const Text(
                                'Retry',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ShopLoaded) {
            final activeCategoryTitle = state.selectedSubCategory ??
                (state.filterCriteria.selectedSubCategories.isNotEmpty
                    ? state.filterCriteria.selectedSubCategories.first
                    : null);

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Frosted Glass Sticky App Bar (Screen 25 & Screen 26)
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: Colors.transparent,
                  toolbarHeight: 58.h,
                  automaticallyImplyLeading: false,
                  flexibleSpace: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black.withOpacity(0.04),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: SafeArea(
                          bottom: false,
                          child: ShopAppBar(
                            activeCategory: activeCategoryTitle,
                            onDismissCategory: () =>
                                context.read<ShopCubit>().clearFilter(),
                            onCameraTap: () =>
                                context.push(RouteNames.kImageSearchPage),
                            onFilterTap: () => _openFilter(context, state),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Sub-Categories 2-Row Grid
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                    child: ShopCategoryGrid(
                      categories: state.categories,
                      selectedCategory: state.selectedSubCategory,
                      onCategorySelected: (categoryName) => context
                          .read<ShopCubit>()
                          .selectSubCategory(categoryName),
                    ),
                  ),
                ),

                // "All Items" Section Header with Gear Filter Icon
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 4.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Items',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings_outlined,
                            size: 22.sp,
                            color: AppColors.textPrimary,
                          ),
                          onPressed: () => _openFilter(context, state),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                  ),
                ),

                // Product Grid or Empty State
                if (state.products.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 56.sp,
                              color: AppColors.gray400,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'No products match your filter criteria',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Try clearing some filters to see more results.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<ShopCubit>().clearFilter(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 12.h,
                                ),
                              ),
                              child: const Text(
                                'Reset Filters',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 96.h),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 14.w,
                        childAspectRatio: 0.58,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = state.products[index];
                          return ShopProductCard(
                            product: product,
                            onTap: () {
                              context.push('/product/${product.id}');
                            },
                          );
                        },
                        childCount: state.products.length,
                      ),
                    ),
                  ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
