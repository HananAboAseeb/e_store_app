import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/modal_close_button.dart';

class ChatHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avatarUrl;
  final bool isBot;
  final VoidCallback onClose;

  const ChatHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
    required this.isBot,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Avatar / Logo (48x48)
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isBot ? AppColors.chatBubbleBg : Colors.transparent,
              border: isBot
                  ? Border.all(
                      color: AppColors.white,
                      width: 2.w,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary400.withOpacity(0.08),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: ClipOval(
              child: isBot
                  ? Padding(
                      padding: EdgeInsets.all(7.w),
                      child: Image.asset(
                        'assets/images/ShopX_logo.png',
                        fit: BoxFit.contain,
                      ),
                    )
                  : Image.asset(
                      avatarUrl.isNotEmpty
                          ? avatarUrl
                          : 'assets/images/profile_picture.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.person,
                        color: AppColors.primary400,
                        size: 24.sp,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 14.w),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title (Raleway, 700, 21sp, line-height 30, letter-spacing -0.21, primary blue)
                AppText.h3(
                  title,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700,
                    height: 30 / 21,
                    letterSpacing: -0.21,
                    color: AppColors.primary400,
                  ),
                ),
                // Subtitle (Raleway, 500, 14sp, line-height 18, letter-spacing -0.14, black)
                AppText.caption(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 18 / 14,
                    letterSpacing: -0.14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Close button (X)
          ModalCloseButton(
            onTap: onClose,
            size: 36.w,
          ),
        ],
      ),
    );
  }
}
