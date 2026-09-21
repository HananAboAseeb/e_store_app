import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../shop/domain/entities/filter_criteria_entity.dart';
import '../../../shop/domain/entities/shop_category_entity.dart';
import '../../../shop/domain/usecases/get_shop_categories_usecase.dart';
import '../../../shop/presentation/pages/filter_modal_sheet.dart';
import '../../../shop/presentation/widgets/shop_product_card.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../widgets/search_results_header.dart';

class SearchResultsPage extends StatelessWidget {
  final String query;

  const SearchResultsPage({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>()..submitQuery(query),
      child: _SearchResultsView(initialQuery: query),
    );
  }
}

class _SearchResultsView extends StatefulWidget {
  final String initialQuery;

  const _SearchResultsView({required this.initialQuery});

  @override
  State<_SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<_SearchResultsView> {
  late final TextEditingController _controller;
  List<ShopCategoryEntity> _categories = const [];
  FilterCriteriaEntity _currentFilter = const FilterCriteriaEntity();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    if (sl.isRegistered<GetShopCategoriesUseCase>()) {
      final result = await sl<GetShopCategoriesUseCase>()();
      result.fold(
        (_) {},
        (categories) {
          if (mounted) {
            setState(() {
              _categories = categories;
            });
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    final cleanQuery = query.trim();
    if (cleanQuery.isNotEmpty) {
      context
          .read<SearchCubit>()
          .submitQuery(cleanQuery, filter: _currentFilter);
    }
  }

  Future<void> _openFilter(BuildContext context) async {
    final searchCubit = context.read<SearchCubit>();
    final newCriteria = await FilterModalSheet.show(
      context,
      categories: _categories,
      initialCriteria: _currentFilter,
    );

    if (newCriteria != null && mounted) {
      setState(() {
        _currentFilter = newCriteria;
      });
      searchCubit.applyFilter(newCriteria);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              SearchResultsHeader(
                controller: _controller,
                onSubmitted: _onSearchSubmitted,
                onClear: () {
                  _controller.clear();
                  context.read<SearchCubit>().clearQuery();
                },
                onFilterTap: () => _openFilter(context),
                onBackTap: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchResultsLoading ||
                        state is SearchLoading ||
                        state is SearchInitial) {
                      return _buildShimmerGrid();
                    }

                    if (state is SearchError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48.sp,
                              color: AppColors.error,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              state.failure.message,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () =>
                                  _onSearchSubmitted(_controller.text),
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is SearchResultsLoaded) {
                      final products = state.results;
                      if (products.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 54.sp,
                                color: AppColors.gray400,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'No results found for "${state.query}"',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Try checking for spelling errors or using general terms',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return GridView.builder(
                        itemCount: products.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.h,
                          crossAxisSpacing: 14.w,
                          childAspectRatio: 0.62,
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ShopProductCard(
                            product: product,
                            onTap: () {
                              context.push('/product/${product.id}');
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return Shimmer.fromColors(
      baseColor: AppColors.gray200,
      highlightColor: AppColors.gray50,
      child: GridView.builder(
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 14.w,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.gray200,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: 120.w,
                height: 14.h,
                color: AppColors.gray200,
              ),
              SizedBox(height: 6.h),
              Container(
                width: 60.w,
                height: 16.h,
                color: AppColors.gray200,
              ),
            ],
          );
        },
      ),
    );
  }
}
