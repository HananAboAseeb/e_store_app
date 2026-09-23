import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/domain/entities/home_data_entity.dart';
import '../../../home/presentation/widgets/most_popular_section.dart';
import '../manager/cart_cubit.dart';
import '../manager/cart_state.dart';
import '../widgets/cart_bottom_bar.dart';
import '../widgets/cart_header.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_shimmer_loading.dart';
import '../widgets/empty_cart_state.dart';
import '../widgets/from_your_wishlist_section.dart';
import '../widgets/shipping_address_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
      create: (context) => sl<CartCubit>()..loadCart(),
      child: const _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading || state is CartInitial) {
              return const CartShimmerLoading();
            }

            if (state is CartError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                        size: 48.sp,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () => context.read<CartCubit>().loadCart(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is CartLoaded) {
              final cubit = context.read<CartCubit>();

              if (state.items.isNotEmpty) {
                // ── Screen 44: Populated Cart ───────────────────────────
                return Column(
                  children: [
                    CartHeader(itemCount: state.itemCount),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShippingAddressCard(
                              address: state.shippingAddress,
                              onArrowTap: () => context
                                  .push(RouteNames.kCheckoutShippingPage),
                            ),
                            SizedBox(height: 8.h),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                final item = state.items[index];
                                return CartItemCard(
                                  item: item,
                                  onIncrement: () =>
                                      cubit.incrementQuantity(item.id),
                                  onDecrement: () =>
                                      cubit.decrementQuantity(item.id),
                                  onDelete: () => cubit.removeItem(item.id),
                                  onTap: () => context
                                      .push('/product/${item.productId}'),
                                );
                              },
                            ),
                            SizedBox(height: 16.h),
                            // Same unified wishlist section in both states
                            if (state.wishlistSuggestions.isNotEmpty)
                              FromYourWishlistSection(
                                items: state.wishlistSuggestions,
                                onAddToCart: (item) => cubit.addCartItem(item),
                                onDeleteFromWishlist: (id) =>
                                    cubit.removeFromWishlist(id),
                              ),
                          ],
                        ),
                      ),
                    ),
                    CartBottomBar(
                      total: state.subtotal,
                      isEnabled: true,
                      onCheckout: () => context.push(RouteNames.kCheckoutPage),
                    ),
                  ],
                );
              }

              // ── Empty Cart (Screen 45 or Screen 46) ───────────────────
              final bool showWishlist =
                  state.emptyContext == EmptyCartContext.wishlist &&
                      state.wishlistSuggestions.isNotEmpty;

              return Column(
                children: [
                  CartHeader(itemCount: 0),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const EmptyCartState(),
                          if (showWishlist)
                            // Screen 45: Same unified wishlist section
                            FromYourWishlistSection(
                              items: state.wishlistSuggestions,
                              onAddToCart: (item) => cubit.addCartItem(item),
                              onDeleteFromWishlist: (id) =>
                                  cubit.removeFromWishlist(id),
                            )
                          else
                            // Screen 46: Reuse MostPopularSection from Home
                            MostPopularSection(
                              products: state.popularSuggestions
                                  .map(
                                    (p) => HomeProductEntity(
                                      id: p.id,
                                      title: p.title,
                                      price: p.price,
                                      imageUrl: p.imageUrl,
                                      likeCount: 1780,
                                      tag: p.isDiscounted ? 'Sale' : 'New',
                                    ),
                                  )
                                  .toList(),
                              onSeeAllTap: () =>
                                  context.push(RouteNames.kCatalogPage),
                              onProductTap: (product) =>
                                  context.push('/product/${product.id}'),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const CartBottomBar(
                    total: 0.0,
                    isEnabled: false,
                    onCheckout: null,
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
