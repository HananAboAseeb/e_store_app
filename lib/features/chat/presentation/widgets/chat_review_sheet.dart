import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/modal_close_button.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/chat_agent_entity.dart';
import '../cubit/chat_review_cubit.dart';
import '../cubit/chat_review_state.dart';

class ChatReviewSheet extends StatefulWidget {
  final ChatAgentEntity agent;

  const ChatReviewSheet({
    super.key,
    required this.agent,
  });

  static Future<bool?> show(
    BuildContext context, {
    required ChatAgentEntity agent,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (sheetContext) => SizedBox(
        height: MediaQuery.of(sheetContext).size.height,
        child: Stack(
          children: [
            // Full-screen frosted blur overlay (Screen 80)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.black.withOpacity(0.18),
                ),
              ),
            ),

            // Tap outside to dismiss
            GestureDetector(
              onTap: () => Navigator.of(sheetContext).pop(false),
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),

            // Floating Review Card (Screen 80: width 342, floating above bottom)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 36.h,
                ),
                child: ChatReviewSheet(agent: agent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<ChatReviewSheet> createState() => _ChatReviewSheetState();
}

class _ChatReviewSheetState extends State<ChatReviewSheet> {
  late final ChatReviewCubit _cubit;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = sl<ChatReviewCubit>()..init(widget.agent);
  }

  @override
  void dispose() {
    _commentController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<ChatReviewCubit, ChatReviewState>(
        listener: (context, state) {
          if (state.status == ChatReviewStatus.submitted) {
            Navigator.of(context).pop(true);
          } else if (state.status == ChatReviewStatus.error &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          return Container(
            width: 342.w,
            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 24.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header: "Rate our Service" on LEFT + Close on RIGHT
                  Row(
                    children: [
                      Expanded(
                        child: AppText.h2(
                          'Rate our Service',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      ModalCloseButton(
                        onTap: () => Navigator.of(context).pop(false),
                        size: 34.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Agent Row (Horizontal: Avatar on left, Name in BLUE + role in BLACK on right)
                  Row(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            widget.agent.avatarUrl.isNotEmpty
                                ? widget.agent.avatarUrl
                                : 'assets/images/profile_picture.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.person,
                              size: 24.sp,
                              color: AppColors.primary400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.body(
                              widget.agent.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary400,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            AppText.caption(
                              widget.agent.role,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black, // Pure black as requested
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),

                  // 5 Interactive Gold Outlined Rating Stars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starValue = index + 1;
                      final isFilled = starValue <= state.rating;

                      return GestureDetector(
                        onTap: () => _cubit.setRating(starValue),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Icon(
                            isFilled
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 36.sp,
                            color: AppColors.chatReviewStar,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 18.h),

                  // Comment Input Field (width: 294, height: 144, border-radius: 20, background: #004CFF1A)
                  Container(
                    width: 294.w,
                    height: 144.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x1A004CFF), // #004CFF1A
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: TextField(
                      controller: _commentController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      onChanged: _cubit.setComment,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 14.sp,
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Your comment',
                        hintStyle: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        filled: false,
                        fillColor: Colors.transparent,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Send Review Button (width: 294, height: 48, radius: 24)
                  PrimaryButton(
                    text: 'Send Review',
                    height: 48.h,
                    borderRadius: BorderRadius.circular(24.r),
                    onPressed: () => _cubit.submit(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
