import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/image_search_cubit.dart';
import '../cubit/image_search_state.dart';
import '../widgets/image_search_controls.dart';
import '../widgets/image_search_results_sheet.dart';
import '../widgets/image_selection_frame.dart';

class ImageSearchPage extends StatelessWidget {
  const ImageSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ImageSearchCubit>(),
      child: const _ImageSearchView(),
    );
  }
}

class _ImageSearchView extends StatelessWidget {
  const _ImageSearchView();

  void _showResults(BuildContext context, ImageSearchRecognized state) {
    ImageSearchResultsSheet.show(
      context,
      result: state.result,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: BlocConsumer<ImageSearchCubit, ImageSearchState>(
        listener: (context, state) {
          if (state is ImageSearchRecognized) {
            // Automatically or upon user interaction reveal the results bottom sheet
            // We give user 500ms to see the recognized selection frame, then display results sheet
            Future.delayed(const Duration(milliseconds: 600), () {
              if (context.mounted &&
                  context.read<ImageSearchCubit>().state
                      is ImageSearchRecognized) {
                _showResults(context, state);
              }
            });
          }
        },
        builder: (context, state) {
          final imagePath = state is ImageSearchRecognized
              ? state.imagePath
              : ImageSearchCubit.defaultMockImage;

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Full-screen Camera / Mock Photo Viewport
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF2C2C2E),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 64.sp,
                      color: AppColors.gray400,
                    ),
                  ),
                ),
              ),

              // Subtle dark gradient for top/bottom visibility
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                    stops: const [0.0, 0.15, 0.75, 1.0],
                  ),
                ),
              ),

              // 2. Top App Bar with Dismiss Button
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.35),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.close,
                                color: AppColors.white,
                                size: 22.sp,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          state is ImageSearchRecognized
                              ? 'Recognized'
                              : 'Image Search',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 40.w), // Balance spacer
                      ],
                    ),
                  ),
                ),
              ),

              // 3. Screen 31: Recognized Bounding Frame & Retry
              if (state is ImageSearchRecognized) ...[
                ImageSelectionFrame(
                  onRetry: () => context.read<ImageSearchCubit>().retry(),
                  onViewResults: () => _showResults(context, state),
                ),
              ],

              // 4. Loading overlay while capturing
              if (state is ImageSearchCapturing) ...[
                Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary400),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Recognizing product...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // 5. Screen 30: Bottom Controls (Gallery, Camera, More)
              if (state is ImageSearchInitial ||
                  state is ImageSearchCapturing) ...[
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20.h,
                  child: SafeArea(
                    child: ImageSearchControls(
                      onGalleryTap: () =>
                          context.read<ImageSearchCubit>().pickFromGallery(),
                      onCameraTap: () =>
                          context.read<ImageSearchCubit>().captureImage(),
                      onMoreTap: () {
                        // Options menu placeholder
                      },
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
