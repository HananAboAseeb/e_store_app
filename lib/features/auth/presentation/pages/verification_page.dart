import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/numeric_keyboard.dart';
import '../widgets/pin_input.dart';

class VerificationPage extends StatefulWidget {
  final String email;

  const VerificationPage({
    super.key,
    required this.email,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String _pin = '';
  bool _hasError = false;
  bool _isSuccess = false;

  void _onNumberPressed(int number) {
    if (_pin.length < 4) {
      setState(() {
        _hasError = false;
        _pin += number.toString();
      });

      if (_pin.length == 4) {
        // Auto-submit OTP verification
        context.read<AuthCubit>().verifyOtp(widget.email, _pin);
      }
    }
  }

  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _hasError = false;
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _onResendPressed() {
    // Call forgotPassword use case mock to simulate OTP resend
    context.read<AuthCubit>().forgotPassword(widget.email, 'email');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification code resent to your email address.'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpVerified) {
          setState(() {
            _isSuccess = true;
            _hasError = false;
          });
          final router = GoRouter.of(context);
          Future.delayed(const Duration(milliseconds: 600), () {
            if (!mounted) return;
            router.go('/welcome');
          });
        } else if (state is AuthError) {
          setState(() {
            _hasError = true;
            _pin = ''; // Clear PIN on error
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
          context.read<AuthCubit>().resetState();
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              // Soft blue gradient glow at top matching Figma design
              Positioned(
                top: -100.h,
                left: 0,
                right: 0,
                child: Container(
                  height: 400.h,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.8,
                      colors: [
                        AppColors.primary400.withOpacity(0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      // Back Button Header Area
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.textPrimary,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Verification Title
                      Text(
                        'Verification',
                        style: AppTypography.h1.copyWith(
                          fontSize: 34.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Subtitle
                      Text(
                        'We sent a code to your Email\nAddress, Enter it below.',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      // Pin Input Boxes
                      if (isLoading)
                        SizedBox(
                          height: 64.w,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary400,
                            ),
                          ),
                        )
                      else
                        PinInput(
                          pin: _pin,
                          hasError: _hasError,
                          isSuccess: _isSuccess,
                        ),
                      const Spacer(flex: 2),
                      // Numeric Custom Keyboard
                      NumericKeyboard(
                        onNumberPressed: isLoading ? (_) {} : _onNumberPressed,
                        onBackspacePressed: isLoading ? () {} : _onBackspacePressed,
                        onResendPressed: isLoading ? () {} : _onResendPressed,
                      ),
                      SizedBox(height: 24.h),
                      // Cancel bottom link
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            'Cancel',
                            style: AppTypography.body.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
