import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlashSaleAppBar extends StatefulWidget {
  final Duration initialDuration;

  const FlashSaleAppBar({
    super.key,
    this.initialDuration = const Duration(hours: 0, minutes: 36, seconds: 58),
  });

  @override
  State<FlashSaleAppBar> createState() => _FlashSaleAppBarState();
}

class _FlashSaleAppBarState extends State<FlashSaleAppBar> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.initialDuration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && _remaining.inSeconds > 0) {
        setState(() {
          _remaining = _remaining - const Duration(seconds: 1);
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildTimeBox(String value) {
    return Container(
      width: 28.w,
      height: 28.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF1A1A1A),
          height: 1.1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remaining.inHours.toString().padLeft(2, '0');
    final minutes = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: "Flash Sale" Title on Left + Stopwatch Icon and White Timer Boxes on Right
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title: Flash Sale
              Text(
                'Flash Sale',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A1A),
                  letterSpacing: -0.5,
                ),
              ),
              const Spacer(),

              // Countdown Timer
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 22.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 6.w),
                  _buildTimeBox(hours),
                  SizedBox(width: 4.w),
                  _buildTimeBox(minutes),
                  SizedBox(width: 4.w),
                  _buildTimeBox(seconds),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Subtitle: Choose Your Discount (directly below title with tight spacing)
          Text(
            'Choose Your Discount',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF333333),
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
