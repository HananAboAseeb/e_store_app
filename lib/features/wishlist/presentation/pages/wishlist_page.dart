import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/wishlist_cubit.dart';
import '../cubit/wishlist_state.dart';
import '../widgets/wishlist_empty_view.dart';
import '../widgets/wishlist_header.dart';
import '../widgets/wishlist_item_row.dart';
import '../widgets/wishlist_shimmer_loading.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WishlistCubit>()..loadWishlist(),
      child: const _WishlistView(),
    );
  }
}

class _WishlistView extends StatelessWidget {
  const _WishlistView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const WishlistHeader(),
            Expanded(
              child: BlocConsumer<WishlistCubit, WishlistState>(
                listener: (context, state) {
                  if (state is WishlistLoaded && state.message != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message!,
                          style: const TextStyle(color: AppColors.white),
                        ),
                        backgroundColor: AppColors.textPrimary,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    context.read<WishlistCubit>().clearMessage();
                  }
                },
                builder: (context, state) {
                  if (state is WishlistLoading || state is WishlistInitial) {
                    return const WishlistShimmerLoading();
                  }

                  if (state is WishlistError) {
                    return Center(
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
                            state.message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<WishlistCubit>().loadWishlist(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is WishlistEmpty) {
                    return WishlistEmptyView(
                      popularProducts: state.popularProducts,
                    );
                  }

                  if (state is WishlistLoaded) {
                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<WishlistCubit>().loadWishlist(),
                      color: AppColors.primary,
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                        itemCount: state.items.length,
                        separatorBuilder: (_, __) => SizedBox(height: 4.h),
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return WishlistItemRow(
                            key: ValueKey(item.id),
                            item: item,
                            onDelete: () => context
                                .read<WishlistCubit>()
                                .removeItem(item.id),
                            onAddToCart: () =>
                                context.read<WishlistCubit>().addToCart(item),
                            onTap: () =>
                                context.push('/product/${item.productId}'),
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
