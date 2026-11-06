import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_container.dart';
import '../../../../shared/widgets/app_text.dart';
import '../cubits/preferences_cubit.dart';
import '../cubits/preferences_state.dart';
import '../cubits/settings_cubit.dart';
import '../cubits/settings_state.dart';
import '../widgets/delete_account_dialog.dart';
import '../widgets/settings_menu_item.dart';
import '../widgets/settings_section_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<SettingsCubit>(),
        ),
        BlocProvider.value(
          value: sl<PreferencesCubit>()..loadPreferences(),
        ),
      ],
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.status == SettingsStatus.accountDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account deleted successfully')),
          );
          context.go(RouteNames.kLoginPage);
        } else if (state.status == SettingsStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Page Header ──────────────────────────────────────────
                SizedBox(height: 8.h),
                AppText(
                  'Settings',
                  style: AppTypography.h1,
                ),
                SizedBox(height: 12.h),

                // ── Personal Section ─────────────────────────────────────
                const SettingsSectionHeader(title: 'Personal'),
                AppContainer(
                  backgroundColor: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(15.r),
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SettingsMenuItem(
                        title: 'Profile',
                        onTap: () =>
                            context.push(RouteNames.kSettingsProfilePage),
                      ),
                      SettingsMenuItem(
                        title: 'Shipping Address',
                        onTap: () =>
                            context.push(RouteNames.kSettingsShippingPage),
                      ),
                      SettingsMenuItem(
                        title: 'Payment Methods',
                        showDivider: false,
                        onTap: () =>
                            context.push(RouteNames.kSettingsPaymentPage),
                      ),
                    ],
                  ),
                ),

                // ── Shop Section ─────────────────────────────────────────
                const SettingsSectionHeader(title: 'Shop'),
                BlocBuilder<PreferencesCubit, PreferencesState>(
                  builder: (context, prefState) {
                    final countryName =
                        prefState.selectedCountry?.name ?? 'Iran';
                    final currencyLabel =
                        prefState.selectedCurrency?.label ?? '\$ USD';
                    final sizeLabel = prefState.selectedSize?.label ?? 'UK';

                    return AppContainer(
                      backgroundColor: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(15.r),
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          SettingsMenuItem(
                            title: 'Country',
                            subtitle: countryName,
                            onTap: () =>
                                context.push(RouteNames.kSettingsCountryPage),
                          ),
                          SettingsMenuItem(
                            title: 'Currency',
                            subtitle: currencyLabel,
                            onTap: () =>
                                context.push(RouteNames.kSettingsCurrencyPage),
                          ),
                          SettingsMenuItem(
                            title: 'Sizes',
                            subtitle: sizeLabel,
                            onTap: () =>
                                context.push(RouteNames.kSettingsSizesPage),
                          ),
                          SettingsMenuItem(
                            title: 'Terms and Conditions',
                            showDivider: false,
                            onTap: () {},
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // ── Account Section ──────────────────────────────────────
                const SettingsSectionHeader(title: 'Account'),
                BlocBuilder<PreferencesCubit, PreferencesState>(
                  builder: (context, prefState) {
                    final languageName =
                        prefState.selectedLanguage?.name ?? 'English';

                    return AppContainer(
                      backgroundColor: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(15.r),
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          SettingsMenuItem(
                            title: 'Language',
                            subtitle: languageName,
                            onTap: () =>
                                context.push(RouteNames.kSettingsLanguagePage),
                          ),
                          SettingsMenuItem(
                            title: 'About ShopX',
                            showDivider: false,
                            onTap: () =>
                                context.push(RouteNames.kSettingsAboutPage),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSpacing.lg),

                // ── Delete My Account Button ─────────────────────────────
                InkWell(
                  onTap: () async {
                    final confirmed = await DeleteAccountDialog.show(context);
                    if (confirmed == true && context.mounted) {
                      context.read<SettingsCubit>().deleteAccount();
                    }
                  },
                  borderRadius: BorderRadius.circular(15.r),
                  child: Container(
                    height: 60.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.deleteAccountBg,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            'Delete My Account',
                            style: AppTypography.body.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 20.sp,
                          color: AppColors.error,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.xl),

                // ── Version Footer ───────────────────────────────────────
                AppText(
                  'ShopX',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return AppText(
                      state.appVersion,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12.sp,
                      ),
                    );
                  },
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
