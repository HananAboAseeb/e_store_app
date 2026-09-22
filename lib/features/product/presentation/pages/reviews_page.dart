import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/reviews_cubit.dart';
import '../cubit/reviews_state.dart';
import '../widgets/review_card.dart';

class ReviewsPage extends StatelessWidget {
  final String productId;

  const ReviewsPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReviewsCubit>()..loadReviews(productId),
      child: const _ReviewsView(),
    );
  }
}

class _ReviewsView extends StatefulWidget {
  const _ReviewsView();

  @override
  State<_ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<_ReviewsView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ReviewsCubit>().loadMoreReviews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: const BoxDecoration(
                        color: Color(0x12000000),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 18.sp,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: BlocBuilder<ReviewsCubit, ReviewsState>(
                builder: (context, state) {
                  if (state is ReviewsLoading || state is ReviewsInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ReviewsError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 44.sp,
                              color: AppColors.error,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              state.failure.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is ReviewsLoaded) {
                    if (state.reviews.isEmpty) {
                      return Center(
                        child: Text(
                          'No reviews yet.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<ReviewsCubit>()
                            .loadReviews('caviar-jacket');
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        itemCount: state.reviews.length +
                            (state.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.reviews.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final review = state.reviews[index];
                          return ReviewCard(
                            review: review,
                            onLikeTap: () => context
                                .read<ReviewsCubit>()
                                .toggleLike(review.id),
                            onDislikeTap: () => context
                                .read<ReviewsCubit>()
                                .toggleDislike(review.id),
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
