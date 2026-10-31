import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../generated/locale_keys.g.dart';
import '../manager/profile_cubit.dart';
import '../manager/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          LocaleKeys.navigation_profile.tr(context: context),
          style: AppTypography.h2.copyWith(color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 96.h),
              children: [
                // Profile Avatar & Info Card
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.cardShadow,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56.w,
                        height: 56.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primarySoft,
                            width: 2.w,
                          ),
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/profile_picture.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: AppTypography.body.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'john.doe@example.com',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Orders Section Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    'Orders & Tracking',
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // Navigation tile: My Orders (Screen 57)
                _buildMenuTile(
                  icon: Icons.local_shipping_outlined,
                  title: 'My Orders (To Receive)',
                  subtitle: 'Active orders, tracking & reviews',
                  onTap: () => context.push(RouteNames.kOrdersPage),
                ),

                SizedBox(height: 10.h),

                // Navigation tile: Order History (Screen 65)
                _buildMenuTile(
                  icon: Icons.history_rounded,
                  title: 'Order History',
                  subtitle: 'Past completed purchases & reviews',
                  onTap: () => context.push(RouteNames.kOrderHistoryPage),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 22.sp,
          ),
        ),
        title: Text(
          title,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14.sp,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
