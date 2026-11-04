import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/verified_check_badge.dart';
import '../../domain/entities/chat_attachment_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import 'chat_order_card.dart';
import 'chat_voucher_bubble.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessageEntity message;
  final bool showUserAvatar;
  final bool showTimestamp;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.showUserAvatar = false,
    this.showTimestamp = true,
  });

  @override
  Widget build(BuildContext context) {
    // 1. If message has voucher attachment, delegate to ChatVoucherBubble
    if (message.attachment?.type == ChatAttachmentType.voucher &&
        message.attachment?.voucher != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.text.isNotEmpty)
            _buildStandardBubble(context, suppressTimestamp: true),
          ChatVoucherBubble(
            voucher: message.attachment!.voucher!,
            timestamp: message.timestamp,
            showTimestamp: showTimestamp,
          ),
        ],
      );
    }

    // 2. If message has order attachment, render ChatOrderCard right-aligned
    if (message.attachment?.type == ChatAttachmentType.order &&
        message.attachment?.order != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 0.88.sw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ChatOrderCard(
                  order: message.attachment!.order!,
                  isInteractive: false,
                ),
                if (showTimestamp && message.timestamp.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 2.h),
                    child: AppText.caption(
                      message.timestamp,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return _buildStandardBubble(context);
  }

  Widget _buildStandardBubble(
    BuildContext context, {
    bool suppressTimestamp = false,
  }) {
    final isUser = message.sender == ChatMessageSender.user;
    final isBot = message.sender == ChatMessageSender.bot;
    final isAgent = message.sender == ChatMessageSender.agent;

    // Check if this is a user triage selection chip message (Screens 71, 72)
    // ANY option chosen during triage bot flow MUST render as a blue pill with verified checkmark
    final isUserChip = isUser &&
        (message.id == 'msg_1' ||
            message.id == 'msg_2' ||
            message.id.startsWith('triage_') ||
            message.text.startsWith('✓') ||
            _isTriageChoice(message.text));

    if (isUserChip) {
      return _buildUserChipBubble(context);
    }

    // Agent messages: Solid blue background with white text (Screens 73–79)
    // Bot messages: Soft blue tint #004CFF26 (Screens 68–71)
    // User typed messages: White background with dark text (Screens 74, 76, 77)
    final Color bgColor;
    final Color textColor;
    if (isAgent) {
      bgColor = AppColors.primary400;
      textColor = AppColors.white;
    } else if (isBot) {
      bgColor = AppColors.botBubbleBg;
      textColor = AppColors.textPrimary;
    } else {
      // User typed message
      bgColor = AppColors.white;
      textColor = AppColors.textPrimary;
    }

    final alignment =
        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    final double maxWidth;
    final EdgeInsets bubblePadding;
    if (isAgent) {
      maxWidth = 221.w;
      bubblePadding = EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h);
    } else if (isBot) {
      maxWidth = 240.w;
      bubblePadding = EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h);
    } else {
      maxWidth = 220.w;
      bubblePadding = EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),
              child: Container(
                padding: bubblePadding,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: isUser
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 6.r,
                            offset: Offset(0, 2.h),
                          ),
                        ]
                      : null,
                ),
                child: AppText.body(
                  message.text,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                    height: 1.35,
                  ),
                ),
              ),
            ),
            if (!suppressTimestamp &&
                showTimestamp &&
                message.timestamp.isNotEmpty) ...[
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.only(
                  left: isUser ? 2.w : 0,
                  right: isUser ? 0 : 4.w,
                ),
                child: AppText.caption(
                  message.timestamp,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUserChipBubble(BuildContext context) {
    final cleanText = message.text.replaceFirst('✓', '').trim();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.primary400,
              borderRadius: BorderRadius.circular(42.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                VerifiedCheckBadge(
                  size: 18.w,
                  backgroundColor: AppColors.white,
                  checkColor: AppColors.primary400,
                ),
                SizedBox(width: 8.w),
                AppText.body(
                  cleanText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textWhite,
                  ),
                ),
              ],
            ),
          ),

          // User avatar on first user message if requested
          if (showUserAvatar) ...[
            SizedBox(width: 8.w),
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD3D8FE),
                border: Border.all(
                  color: AppColors.primary400.withOpacity(0.3),
                  width: 1.5.w,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/image1.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.person,
                    size: 20.sp,
                    color: AppColors.primary400,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool _isTriageChoice(String text) {
    final lower = text.toLowerCase().trim();
    const categories = [
      'order issues',
      'item quality',
      'payment issues',
      'technical assistance',
      'other',
      "i didn't receive my order",
      "i didn't recieve my order",
      'i want to cancel my order',
      'i want to return my order',
      'package was damages',
    ];
    return categories.any((cat) => lower == cat || lower.contains(cat));
  }
}
