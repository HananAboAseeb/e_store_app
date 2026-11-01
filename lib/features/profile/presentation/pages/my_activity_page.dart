import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/no_data_found_widget.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../manager/my_activity/my_activity_cubit.dart';
import '../manager/my_activity/my_activity_state.dart';
import '../widgets/category_legend_pills.dart';
import '../widgets/donut_chart.dart';
import '../widgets/month_selector.dart';
import '../widgets/order_stats_circles.dart';
import '../widgets/profile_header.dart';

class MyActivityPage extends StatelessWidget {
  const MyActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyActivityCubit>(
      create: (context) => sl<MyActivityCubit>()..loadActivity(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: BlocBuilder<MyActivityCubit, MyActivityState>(
            builder: (context, state) {
              if (state is MyActivityLoading || state is MyActivityInitial) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary400,
                  ),
                );
              }

              if (state is MyActivityError) {
                return Center(
                  child: NoDataFoundWidget(
                    title: 'Failed to load activity',
                    message: state.failure.message,
                  ),
                );
              }

              if (state is MyActivityLoaded) {
                final summary = state.summary;
                final cubit = context.read<MyActivityCubit>();

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    children: [
                      // Header Row: Avatar + Title "My Activity" + 3 Circular Action Icons
                      const ProfileHeader(
                        avatarUrl: 'assets/images/profile_picture.png',
                        showActivityButton: false,
                        customTitle: 'My Activity',
                      ),
                      SizedBox(height: 16.h),

                      // Month Selector Pill (FIX 3)
                      MonthSelector(month: summary.month),
                      SizedBox(height: 20.h),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Donut Chart with Arrows & Center Total (FIX 5)
                              DonutChart(
                                totalAmount: summary.totalAmount,
                                categories: summary.categories,
                                onPreviousMonth: () => cubit.changeMonth(-1),
                                onNextMonth: () => cubit.changeMonth(1),
                              ),
                              SizedBox(height: 20.h),

                              // 2x2 Category Legend Pills
                              CategoryLegendPills(
                                categories: summary.categories,
                              ),
                              SizedBox(height: 28.h),

                              // 3 Order Stats Circles
                              OrderStatsCircles(
                                orderStats: summary.orderStats,
                              ),
                              SizedBox(height: 28.h),
                            ],
                          ),
                        ),
                      ),

                      // Order History CTA Button (FIX 4: 335x48px pill)
                      PrimaryButton(
                        text: 'Order History',
                        width: 335.w,
                        height: 48.h,
                        borderRadius: BorderRadius.circular(24.r),
                        onPressed: () =>
                            context.push(RouteNames.kOrderHistoryPage),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
