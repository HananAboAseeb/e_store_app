import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class ChatBottomInput extends StatefulWidget {
  final ValueChanged<String> onSend;
  final bool isEnabled;

  const ChatBottomInput({
    super.key,
    required this.onSend,
    this.isEnabled = true,
  });

  @override
  State<ChatBottomInput> createState() => _ChatBottomInputState();
}

class _ChatBottomInputState extends State<ChatBottomInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _handleSend() {
    final text = _textController.text.trim();
    if (text.isNotEmpty && widget.isEnabled) {
      widget.onSend(text);
      _textController.clear();
    }
  }

  void _showFeatureNotice(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName attachment is a demo placeholder'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _textController.text.trim().isNotEmpty;

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Message input field on the LEFT
            Expanded(
              child: TextField(
                controller: _textController,
                enabled: widget.isEnabled,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSend(),
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: widget.isEnabled ? 'Message' : 'Connecting...',
                  hintStyle: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF8E8E93),
                  ),
                  filled: false,
                  fillColor: Colors.transparent,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(width: 8.w),

            // Gallery / Image button (Figma outline rounded square)
            GestureDetector(
              onTap:
                  widget.isEnabled ? () => _showFeatureNotice('Gallery') : null,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: _GalleryIcon(
                  color: widget.isEnabled
                      ? AppColors.primary400
                      : AppColors.gray300,
                ),
              ),
            ),
            SizedBox(width: 4.w),

            // Document button (Figma outline rounded square with 2 bars)
            GestureDetector(
              onTap: widget.isEnabled
                  ? () => _showFeatureNotice('Document')
                  : null,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: _DocumentIcon(
                  color: widget.isEnabled
                      ? AppColors.primary400
                      : AppColors.gray300,
                ),
              ),
            ),

            // Send button if text is entered
            if (hasText) ...[
              SizedBox(width: 6.w),
              GestureDetector(
                onTap: widget.isEnabled ? _handleSend : null,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 34.w,
                  height: 34.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary400,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    size: 18.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _GalleryIcon extends StatelessWidget {
  final Color color;
  const _GalleryIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color, width: 1.8.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: Stack(
          children: [
            Positioned(
              right: 3.w,
              top: 3.h,
              child: Container(
                width: 3.5.w,
                height: 3.5.w,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: 2.w,
              bottom: 1.h,
              child: Icon(
                Icons.terrain_rounded,
                size: 13.sp,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentIcon extends StatelessWidget {
  final Color color;
  const _DocumentIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color, width: 1.8.w),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 11.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
          SizedBox(height: 3.h),
          Container(
            width: 11.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
        ],
      ),
    );
  }
}
