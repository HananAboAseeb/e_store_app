import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/no_data_found_widget.dart';
import '../../domain/entities/profile_enums.dart';
import '../manager/rewards/rewards_cubit.dart';
import '../manager/rewards/rewards_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/reward_milestone_card.dart';
import '../widgets/rewards_tabs.dart';
import '../widgets/voucher_card.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RewardsCubit>(
      create: (context) => sl<RewardsCubit>()..loadRewards(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: BlocBuilder<RewardsCubit, RewardsState>(
            builder: (context, state) {
              if (state is RewardsLoading || state is RewardsInitial) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary400,
                  ),
                );
              }

              if (state is RewardsError) {
                return Center(
                  child: NoDataFoundWidget(
                    title: 'Failed to load rewards',
                    message: state.failure.message,
                  ),
                );
              }

              if (state is RewardsLoaded) {
                final cubit = context.read<RewardsCubit>();

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    children: [
                      // Header Row: Avatar + My Activity Button + 3 Circular Action Icons
                      const ProfileHeader(
                        avatarUrl: 'assets/images/profile_picture.png',
                        isScanActive: true,
                      ),
                      SizedBox(height: 16.h),

                      // Tabs: Active Rewards vs Progress
                      RewardsTabs(
                        activeTab: state.activeTab,
                        onTabChanged: cubit.switchTab,
                      ),
                      SizedBox(height: 20.h),

                      // Tab Content
                      Expanded(
                        child: state.activeTab == RewardsTab.activeRewards
                            ? _buildActiveRewardsList(state)
                            : _buildRewardsProgressGrid(state),
                      ),
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

  Widget _buildActiveRewardsList(RewardsLoaded state) {
    if (state.vouchers.isEmpty) {
      return const Center(
        child: NoDataFoundWidget(
          title: 'No active vouchers',
          message: 'You do not have any active reward vouchers at the moment.',
        ),
      );
    }

    return ListView.separated(
      itemCount: state.vouchers.length,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final voucher = state.vouchers[index];
        return VoucherCard(voucher: voucher);
      },
    );
  }

  Widget _buildRewardsProgressGrid(RewardsLoaded state) {
    if (state.rewards.isEmpty) {
      return const Center(
        child: NoDataFoundWidget(
          title: 'No rewards progress',
          message: 'Achievement progress is currently unavailable.',
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
      itemCount: state.rewards.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.67,
      ),
      itemBuilder: (context, index) {
        final reward = state.rewards[index];
        return RewardMilestoneCard(reward: reward);
      },
    );
  }
}
