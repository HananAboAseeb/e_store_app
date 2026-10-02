import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../shop/presentation/widgets/shop_product_card.dart';
import '../cubit/recently_viewed_cubit.dart';
import '../cubit/recently_viewed_state.dart';
import '../widgets/recently_viewed_calendar.dart';
import '../widgets/recently_viewed_date_tabs.dart';
import '../widgets/recently_viewed_header.dart';
import '../widgets/recently_viewed_shimmer_loading.dart';

class RecentlyViewedPage extends StatelessWidget {
  const RecentlyViewedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecentlyViewedCubit>()..loadRecentlyViewed(),
      child: const _RecentlyViewedView(),
    );
  }
}

class _RecentlyViewedView extends StatelessWidget {
  const _RecentlyViewedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const RecentlyViewedHeader(),
            Expanded(
              child: BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
                builder: (context, state) {
                  if (state is RecentlyViewedLoading ||
                      state is RecentlyViewedInitial) {
                    return const RecentlyViewedShimmerLoading();
                  }

                  if (state is RecentlyViewedError) {
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
                            onPressed: () => context
                                .read<RecentlyViewedCubit>()
                                .loadRecentlyViewed(),
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

                  if (state is RecentlyViewedLoaded) {
                    final cubit = context.read<RecentlyViewedCubit>();

                    return Column(
                      children: [
                        if (state.isCalendarExpanded)
                          RecentlyViewedCalendar(
                            displayedMonth: state.displayedMonth,
                            selectedDate: state.selectedCalendarDate,
                            onDateSelected: (date) =>
                                cubit.selectCalendarDate(date),
                            onMonthChanged: (offset) =>
                                cubit.changeMonth(offset),
                            onCollapse: () => cubit.closeCalendar(),
                          )
                        else
                          RecentlyViewedDateTabs(
                            tabs: state.tabs,
                            activeTabId: state.activeTabId,
                            onTabSelected: (id) => cubit.selectTab(id),
                            onToggleCalendar: () => cubit.toggleCalendar(),
                            isCalendarExpanded: state.isCalendarExpanded,
                          ),
                        Expanded(
                          child: state.filteredProducts.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.history,
                                        size: 48.sp,
                                        color: AppColors.gray400,
                                      ),
                                      SizedBox(height: 12.h),
                                      Text(
                                        'No products viewed on this date',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                  itemCount: state.filteredProducts.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16.h,
                                    crossAxisSpacing: 14.w,
                                    childAspectRatio: 0.58,
                                  ),
                                  itemBuilder: (context, index) {
                                    final product =
                                        state.filteredProducts[index];
                                    return ShopProductCard(
                                      product: product,
                                      onTap: () => context
                                          .push('/product/${product.id}'),
                                    );
                                  },
                                ),
                        ),
                      ],
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
