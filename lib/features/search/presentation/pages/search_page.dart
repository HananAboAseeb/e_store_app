import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../widgets/search_discover_carousel.dart';
import '../widgets/search_header.dart';
import '../widgets/search_history_section.dart';
import '../widgets/search_recommendations_section.dart';
import '../widgets/search_shimmer_loading.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>()..loadSearchData(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
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

  void _navigateToResults(BuildContext context, String query) {
    final cleanQuery = query.trim();
    if (cleanQuery.isNotEmpty) {
      context.push(
        '${RouteNames.kSearchResultsPage}?q=${Uri.encodeComponent(cleanQuery)}',
      );
    }
  }

  void _navigateToImageSearch(BuildContext context) {
    context.push(RouteNames.kImageSearchPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                    child: SearchHeader(
                      controller: _searchController,
                      onSubmitted: (query) =>
                          _navigateToResults(context, query),
                      onCameraTap: () => _navigateToImageSearch(context),
                      onCloseTap: () {
                        if (_searchController.text.isNotEmpty) {
                          _searchController.clear();
                        } else if (context.canPop()) {
                          context.pop();
                        }
                      },
                    ),
                  ),
                ),
                if (state is SearchLoading || state is SearchInitial) ...[
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: SearchShimmerLoading(),
                  ),
                ] else if (state is SearchError) ...[
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
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
                            state.failure.message,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<SearchCubit>().loadSearchData(),
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else if (state is SearchLoaded) ...[
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 32.h),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SearchHistorySection(
                          history: state.data.history,
                          onClearHistory: () =>
                              context.read<SearchCubit>().clearHistory(),
                          onChipTap: (query) =>
                              _navigateToResults(context, query),
                        ),
                        if (state.data.history.isNotEmpty)
                          SizedBox(height: 20.h),
                        SearchRecommendationsSection(
                          recommendations: state.data.recommendations,
                          onChipTap: (label) =>
                              _navigateToResults(context, label),
                        ),
                        SizedBox(height: 20.h),
                        SearchDiscoverCarousel(
                          products: state.data.discoverProducts,
                          onProductTap: (product) {
                            context.push('/product/${product.id}');
                          },
                        ),
                      ]),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
