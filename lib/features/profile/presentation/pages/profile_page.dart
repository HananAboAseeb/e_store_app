import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/no_data_found_widget.dart';
import '../../domain/entities/profile_enums.dart';
import '../manager/profile/profile_cubit.dart';
import '../manager/profile/profile_state.dart';
import '../widgets/announcement_card.dart';
import '../widgets/my_orders_tabs.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_shimmer_loading.dart';
import '../widgets/recently_viewed_horizontal_list.dart';
import '../widgets/stories_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => sl<ProfileCubit>()..loadProfile(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading || state is ProfileInitial) {
                return const ProfileShimmerLoading();
              }

              if (state is ProfileError) {
                return Center(
                  child: NoDataFoundWidget(
                    title: 'Failed to load profile',
                    message: state.failure.message,
                  ),
                );
              }

              if (state is ProfileLoaded) {
                return RefreshIndicator(
                  onRefresh: () => context.read<ProfileCubit>().loadProfile(),
                  color: AppColors.primary400,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    children: [
                      // Header with scan to rewards & menu to cycle announcement
                      ProfileHeader(
                        avatarUrl: state.user.avatarUrl,
                        onMenuPressed: () {
                          final cubit = context.read<ProfileCubit>();
                          cubit.cycleAnnouncementType();
                          final updatedState = cubit.state;
                          if (updatedState is ProfileLoaded) {
                            final typeName =
                                switch (updatedState.announcement.type) {
                              ProfileAnnouncementType.regular =>
                                'Screen 62: Regular Announcement',
                              ProfileAnnouncementType.rewardEarned =>
                                'Screen 81: Reward Notification',
                              ProfileAnnouncementType.voucherExpiring =>
                                'Screen 85: Voucher Expiring Reminder',
                            };
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Active: $typeName'),
                                duration: const Duration(milliseconds: 1500),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Greeting
                      AppText.h1(
                        state.user.greeting,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.28,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Announcement Banner (Screens 62, 81, 85 - 340x74px)
                      Center(
                        child: AnnouncementCard(
                          announcement: state.announcement,
                          onLongPress: () {
                            final cubit = context.read<ProfileCubit>();
                            cubit.cycleAnnouncementType();
                            final updatedState = cubit.state;
                            if (updatedState is ProfileLoaded) {
                              final typeName =
                                  switch (updatedState.announcement.type) {
                                ProfileAnnouncementType.regular =>
                                  'Screen 62: Regular Announcement',
                                ProfileAnnouncementType.rewardEarned =>
                                  'Screen 81: Reward Notification',
                                ProfileAnnouncementType.voucherExpiring =>
                                  'Screen 85: Voucher Expiring Reminder',
                              };
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Switched to $typeName'),
                                  duration: const Duration(milliseconds: 1500),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 22.h),

                      // Recently Viewed Section
                      RecentlyViewedHorizontalList(
                        items: state.recentlyViewed,
                      ),
                      SizedBox(height: 22.h),

                      // My Orders Tabs Section
                      MyOrdersTabs(
                        announcementType: state.announcement.type,
                      ),
                      SizedBox(height: 22.h),

                      // Stories Section
                      StoriesSection(
                        stories: state.stories,
                      ),
                      SizedBox(height: 24.h),
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
