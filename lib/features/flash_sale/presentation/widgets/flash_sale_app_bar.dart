import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../home/presentation/widgets/flash_sale_timer.dart';

class FlashSaleAppBar extends StatelessWidget {
  final VoidCallback? onBackTap;
  final Duration? timerDuration;

  const FlashSaleAppBar({
    super.key,
    this.onBackTap,
    this.timerDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF004BFE).withOpacity(0.09),
            const Color(0xFF004BFE).withOpacity(0.03),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: Back Button + "Flash Sale" Title + Embedded Countdown Timer
          Row(
            children: [
              // Back Button
              GestureDetector(
                onTap: onBackTap ?? () => context.pop(),
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16.sp,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Title: Flash Sale
              Text(
                'Flash Sale',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF000000),
                  letterSpacing: -0.6,
                ),
              ),
              const Spacer(),

              // Reused FlashSaleTimer countdown box
              FlashSaleTimer(
                initialDuration: timerDuration ??
                    const Duration(hours: 0, minutes: 36, seconds: 58),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Subtitle: Choose Your Discount
          Text(
            'Choose Your Discount',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF000000),
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}
