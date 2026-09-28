import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';
import '../widgets/categories_app_bar.dart';
import '../widgets/categories_shimmer_loading.dart';
import '../widgets/category_accordion_tile.dart';
import '../widgets/gender_tab_bar.dart';
import '../widgets/just_for_you_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesCubit>(
      create: (_) => GetIt.instance<CategoriesCubit>()..loadCategories(),
      child: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──
            CategoriesAppBar(
              onClose: () => context.pop(),
            ),

            // ── Content ──
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const CategoriesShimmerLoading();
                  }

                  if (state is CategoriesError) {
                    return _buildErrorState(context, state);
                  }

                  if (state is CategoriesLoaded) {
                    return _buildLoadedState(context, state);
                  }

                  // Initial state
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, CategoriesError state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: AppColors.textSecondary),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => context.read<CategoriesCubit>().loadCategories(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, CategoriesLoaded state) {
    final cubit = context.read<CategoriesCubit>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // ── Gender Tabs ──
          GenderTabBar(
            activeGender: state.activeGender,
            onGenderSelected: (gender) => cubit.selectGender(gender),
          ),

          SizedBox(height: 4.h),

          // ── Accordion Categories ──
          ...state.groups.map((group) {
            return CategoryAccordionTile(
              group: group,
              isExpanded: state.expandedGroupId == group.id,
              onToggle: () => cubit.toggleCategoryExpansion(group.id),
              onSubCategoryTap: (subCategoryName) {
                context.push(
                  RouteNames.kCategoryProductsPage,
                  extra: {'title': subCategoryName},
                );
              },
            );
          }),

          // ── Just for you ──
          JustForYouCard(
            onTap: () {
              context.push(RouteNames.kCategoriesJustForYouPage);
            },
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
