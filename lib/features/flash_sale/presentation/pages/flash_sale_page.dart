import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../home/presentation/widgets/home_section_header.dart';
import '../cubit/flash_sale_cubit.dart';
import '../cubit/flash_sale_state.dart';
import '../widgets/discount_filter_bar.dart';
import '../widgets/flash_sale_product_card.dart';
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
      body: SafeArea(
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
                        onPressed: () =>
                            context.read<FlashSaleCubit>().loadFlashSaleData(),
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

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),

                    // Section: Discount Filter Bar
                    DiscountFilterBar(
                      selectedDiscount: state.selectedDiscount,
                      onDiscountSelected: (val) {
                        context
                            .read<FlashSaleCubit>()
                            .selectDiscountFilter(val);
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Section: Discount Header
                    HomeSectionHeader(
                      title: discountTitle,
                    ),
                    SizedBox(height: 12.h),

                    // Section: 2-Column Product Grid
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
                            childAspectRatio: 0.72,
                          ),
                          itemBuilder: (context, index) {
                            return FlashSaleProductCard(
                              product: state.filteredProducts[index],
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                  ],
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
