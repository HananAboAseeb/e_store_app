import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class NumericKeyboard extends StatefulWidget {
  final Function(int) onNumberPressed;
  final VoidCallback onBackspacePressed;
  final VoidCallback onResendPressed;
  final int initialCountdown;

  const NumericKeyboard({
    super.key,
    required this.onNumberPressed,
    required this.onBackspacePressed,
    required this.onResendPressed,
    this.initialCountdown = 47,
  });

  @override
  State<NumericKeyboard> createState() => _NumericKeyboardState();
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  late int _countdown;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _countdown = widget.initialCountdown;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
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

  void resetTimer() {
    setState(() {
      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Grid Rows
        _buildRow([1, 2, 3]),
        SizedBox(height: 12.h),
        _buildRow([4, 5, 6]),
        SizedBox(height: 12.h),
        _buildRow([7, 8, 9]),
        SizedBox(height: 12.h),
        // Bottom Row: Timer / Resend, 0, Backspace
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Timer or Resend Button
            _buildSpecialKey(
              child: Text(
                _countdown > 0 ? '${_countdown}S' : 'Resend',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: _countdown > 0 ? AppColors.textSecondary : AppColors.primary400,
                ),
              ),
              onTap: _countdown > 0
                  ? null
                  : () {
                      widget.onResendPressed();
                      resetTimer();
                    },
            ),
            // Digit 0
            _buildNumberKey(0),
            // Backspace Key
            _buildSpecialKey(
              child: Icon(
                Icons.backspace_outlined,
                color: AppColors.textPrimary,
                size: 22.sp,
              ),
              onTap: widget.onBackspacePressed,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(List<int> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: numbers.map((n) => _buildNumberKey(n)).toList(),
    );
  }

  Widget _buildNumberKey(int number) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        height: 60.h,
        child: ElevatedButton(
          onPressed: () => widget.onNumberPressed(number),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            number.toString(),
            style: AppTypography.h2.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey({required Widget child, required VoidCallback? onTap}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        height: 60.h,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.zero,
          ),
          child: child,
        ),
      ),
    );
  }
}
