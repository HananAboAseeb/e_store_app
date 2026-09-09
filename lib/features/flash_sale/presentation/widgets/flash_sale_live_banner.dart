import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/live_stream_entity.dart';

class FlashSaleLiveBanner extends StatelessWidget {
  final LiveStreamEntity liveStream;
  final VoidCallback? onTap;

  const FlashSaleLiveBanner({
    super.key,
    required this.liveStream,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top: Multi-Model Collage Image with Centered Play Button
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    liveStream.bannerUrl.isNotEmpty
                        ? liveStream.bannerUrl
                        : 'assets/images/live_stream_collage.png',
                    width: double.infinity,
                    height: 140.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                      'assets/images/live_stream_collage.png',
                      width: double.infinity,
                      height: 140.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                        height: 140.h,
                        color: const Color(0xFFF0F1F5),
                      ),
                    ),
                  ),

                  // Translucent White Circular Play Button (Figma)
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.55),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 26.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // Bottom: White Bar Area Below the Images (Figma)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title: ARTICALE REIMAGINED (Figma tracked uppercase text)
                    Expanded(
                      child: Text(
                        liveStream.title.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A1A),
                          letterSpacing: 1.6,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),

                    // LIVE Green Pill Badge (Figma)
                    if (liveStream.isLive)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A638), // Figma Vibrant Green
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'LIVE',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
