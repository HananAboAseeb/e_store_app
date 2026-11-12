import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';
import '../cubits/preferences_cubit.dart';
import '../cubits/preferences_state.dart';
import '../widgets/preference_option_tile.dart';

class SizesSelectionPage extends StatelessWidget {
  const SizesSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<PreferencesCubit>()..loadPreferences(),
      child: const _SizesSelectionView(),
    );
  }
}

class _SizesSelectionView extends StatelessWidget {
  const _SizesSelectionView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, state) {
        final sizes = state.sizes;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.textPrimary),
              onPressed: () => context.pop(),
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
                    'Sizes',
                    style: AppTypography.h3.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 80.h),
                      itemCount: sizes.length,
                      itemBuilder: (context, index) {
                        final size = sizes[index];
                        final isSelected = state.selectedSize?.id == size.id ||
                            size.isSelected;
                        return PreferenceOptionTile(
                          label: size.label,
                          isSelected: isSelected,
                          onTap: () {
                            context.read<PreferencesCubit>().selectSize(size);
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
