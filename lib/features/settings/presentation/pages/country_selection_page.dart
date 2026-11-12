import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/verified_check_badge.dart';
import '../cubits/preferences_cubit.dart';
import '../cubits/preferences_state.dart';
import '../widgets/country_list_item.dart';

class CountrySelectionPage extends StatelessWidget {
  const CountrySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<PreferencesCubit>()..loadPreferences(),
      child: const _CountrySelectionView(),
    );
  }
}

class _CountrySelectionView extends StatefulWidget {
  const _CountrySelectionView();

  @override
  State<_CountrySelectionView> createState() => _CountrySelectionViewState();
}

class _CountrySelectionViewState extends State<_CountrySelectionView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, state) {
        final selectedCountry = state.selectedCountry?.name ?? 'Iran';
        final filteredCountries = state.filteredCountries;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.textPrimary),
              onPressed: () => context.pop(state.selectedCountry?.name),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Settings',
                    style: AppTypography.h1,
                  ),
                  SizedBox(height: 4.h),
                  AppText(
                    'Country',
                    style: AppTypography.h3.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),

                  // ── Selected Country Highlight Card (342x60, r:15, bg: #004CFF26)
                  Container(
                    height: 60.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.selectedOptionBg,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          selectedCountry,
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        VerifiedCheckBadge(size: 24.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ── Search Bar (342x48, r:15) ──────────────────────────
                  Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 20.sp,
                          color: AppColors.gray400,
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (val) {
                              context
                                  .read<PreferencesCubit>()
                                  .searchCountry(val);
                            },
                            style: AppTypography.body.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'Search between countries',
                              hintStyle: AppTypography.body.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),

                  // ── Alphabetical Countries List ────────────────────────
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 80.h),
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return CountryListItem(
                          country: country,
                          onTap: () {
                            context
                                .read<PreferencesCubit>()
                                .selectCountry(country);
                            context.pop(country.name);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
