import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../domain/entities/story_entity.dart';

class StoriesSection extends StatelessWidget {
  final List<StoryEntity> stories;

  const StoriesSection({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    if (stories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.h2('Stories'),
        SizedBox(height: 6.h),
        SizedBox(
          height: 155.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: stories.length,
            separatorBuilder: (_, __) => SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final story = stories[index];
              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Playing ${story.creatorName}'s story"),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  width: 105.w,
                  height: 155.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.surfaceCardImage,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Image
                        Image.asset(
                          story.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.gray200,
                            child: Icon(
                              Icons.person,
                              color: AppColors.gray400,
                              size: 40.sp,
                            ),
                          ),
                        ),

                        // Center Play Button
                        Center(
                          child: Container(
                            width: 38.w,
                            height: 38.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.black.withOpacity(0.3),
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: AppColors.white.withOpacity(0.9),
                              size: 22.sp,
                            ),
                          ),
                        ),

                        // Top-left Live badge
                        if (story.isLive)
                          Positioned(
                            top: 8.h,
                            left: 8.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6.w,
                                    height: 6.w,
                                    decoration: const BoxDecoration(
                                      color: AppColors.storyLiveRed,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  AppText.caption(
                                    'Live',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.storyLiveRed,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
