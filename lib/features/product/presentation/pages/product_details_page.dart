import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';
import '../widgets/flash_sale_banner.dart';
import '../widgets/product_bottom_bar.dart';
import '../widgets/product_breadcrumb.dart';
import '../widgets/product_color_selector.dart';
import '../widgets/product_delivery_section.dart';
import '../widgets/product_image_gallery.dart';
import '../widgets/product_most_popular_carousel.dart';
import '../widgets/product_rating_row.dart';
import '../widgets/product_ratings_breakdown.dart';
import '../widgets/product_reviews_preview.dart';
import '../widgets/product_shimmer_loading.dart';
import '../widgets/product_size_selector.dart';
import '../widgets/product_specifications_section.dart';
import '../widgets/product_you_might_like_grid.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  final bool? isSale;

  const ProductDetailsPage({
    super.key,
    required this.productId,
    this.isSale,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ProductDetailsCubit>()..loadProduct(productId, forceSale: isSale),
      child: const _ProductDetailsView(),
    );
  }
}

class _ProductDetailsView extends StatelessWidget {
  const _ProductDetailsView();

  void _navigateToReviews(BuildContext context, String productId) {
    context.push(
      RouteNames.kProductReviewsPage.replaceAll(':id', productId),
    );
  }

  void _navigateToProduct(BuildContext context, String newProductId) {
    context.push(
      RouteNames.kProductDetailsPage.replaceAll(':id', newProductId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      extendBody: true,
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading ||
              state is ProductDetailsInitial) {
            return const SafeArea(child: ProductShimmerLoading());
          }

          if (state is ProductDetailsError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48.sp,
                      color: AppColors.error,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      state.failure.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<ProductDetailsCubit>()
                            .loadProduct('caviar-jacket');
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is ProductDetailsLoaded) {
            final product = state.product;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).padding.top + 8.h),

                      // Image Gallery (Screens 34 & 36)
                      ProductImageGallery(images: state.activeImages),
                      SizedBox(height: 16.h),

                      // Flash Sale Promotional Banner (Screen 35)
                      if (state.isFlashSaleActive)
                        FlashSaleBanner(
                          salePrice: product.salePrice ?? product.basePrice,
                          originalPrice: product.basePrice,
                          discountPercent: product.discountPercent ?? 20,
                          remainingSeconds: state.remainingSeconds,
                        ),

                      // White Details Sheet (Curved card with rounded top corners)
                      Container(
                        width: double.infinity,
                        transform: state.isFlashSaleActive
                            ? Matrix4.translationValues(0, -14.h, 0)
                            : null,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(top: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Breadcrumb Trail with Wishlist Heart & Share
                            ProductBreadcrumb(
                              breadcrumb: product.breadcrumb,
                              isWishlisted: state.isWishlisted,
                              onWishlistTap: () => context
                                  .read<ProductDetailsCubit>()
                                  .toggleWishlist(),
                              onShareTap: () {},
                            ),
                            SizedBox(height: 14.h),

                            // Title and Rating Row
                            ProductRatingRow(
                              title: product.title,
                              rating: product.rating,
                              reviewCount: product.reviewCount,
                              onReviewsTap: () =>
                                  _navigateToReviews(context, product.id),
                            ),
                            SizedBox(height: 18.h),

                            // Color Variant Selector
                            ProductColorSelector(
                              variants: product.variants,
                              selectedIndex: state.selectedVariantIndex,
                              onVariantSelected: (index) => context
                                  .read<ProductDetailsCubit>()
                                  .selectColorVariant(index),
                            ),
                            SizedBox(height: 18.h),

                            // Size Selector
                            ProductSizeSelector(
                              availableSizes: product.availableSizes,
                              selectedSize: state.selectedSize,
                              onSizeSelected: (size) => context
                                  .read<ProductDetailsCubit>()
                                  .selectSize(size),
                            ),
                            SizedBox(height: 20.h),

                            // Specifications Section
                            ProductSpecificationsSection(
                              specifications: product.specifications,
                              onSizeGuideTap: () {},
                            ),
                            SizedBox(height: 20.h),

                            // Delivery Section
                            ProductDeliverySection(
                              deliveryOptions: product.deliveryOptions,
                            ),
                            SizedBox(height: 20.h),

                            // Ratings Breakdown Section
                            ProductRatingsBreakdown(
                              rating: product.rating,
                              scoreCount: product.scoreCount,
                              breakdown: product.ratingsBreakdown,
                            ),
                            SizedBox(height: 20.h),

                            // Reviews Preview Section
                            ProductReviewsPreview(
                              reviews: product.reviewsPreview,
                              totalReviews: product.reviewCount,
                              onViewAllTap: () =>
                                  _navigateToReviews(context, product.id),
                            ),
                            SizedBox(height: 24.h),

                            // Most Popular Carousel (reusing MostPopularSection)
                            ProductMostPopularCarousel(
                              products: product.mostPopularProducts,
                              onSeeAllTap:
                                  null, // Disabled as requested to avoid red screen
                              onProductTap: (item) =>
                                  _navigateToProduct(context, item.id),
                            ),
                            SizedBox(height: 24.h),

                            // You Might Like 2-Column Grid (reusing StuffForYouSection)
                            ProductYouMightLikeGrid(
                              products: product.youMightLikeProducts,
                              onProductTap: (item) =>
                                  _navigateToProduct(context, item.id),
                            ),
                            SizedBox(height: 120.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoaded) {
            return Material(
              color: Colors.transparent,
              child: ProductBottomBar(
                currentPrice: state.currentPrice,
                originalPrice: state.product.basePrice,
                isDiscounted: state.isFlashSaleActive,
                onAddToBasket: () {
                  context.read<ProductDetailsCubit>().addToBasket();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added "${state.product.title}" (${state.activeVariant.name}, Size ${state.selectedSize}) to basket!',
                      ),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
