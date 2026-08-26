import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../models/verification_mode.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/numeric_keyboard.dart';
import '../widgets/pin_input.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  final VerificationMode mode;
  final String? phoneNumber;

  const VerificationPage({
    super.key,
    required this.email,
    this.mode = VerificationMode.register,
    this.phoneNumber,
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
        _pin += number.toString();
        _hasError = false;
      });

      if (_pin.length == 4) {
        context.read<AuthCubit>().verifyOtp(widget.email, _pin);
      }
    }
  }

  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _hasError = false;
        _isSuccess = false;
      });
    }
  }

  void _onResendPressed() {
    context.read<AuthCubit>().forgotPassword(
          widget.email,
          widget.mode == VerificationMode.passwordRecovery ? 'sms' : 'email',
        );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new verification code has been sent.'),
        backgroundColor: AppColors.primary400,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRecovery = widget.mode == VerificationMode.passwordRecovery;
    final phoneText = widget.phoneNumber ?? '+98*******22';

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpVerified) {
          setState(() {
            _isSuccess = true;
            _hasError = false;
          });
          final router = GoRouter.of(context);
          Future.delayed(const Duration(milliseconds: 600), () {
            if (mounted) {
              if (isRecovery) {
                router.push('/reset-password', extra: widget.email);
              } else {
                router.go('/welcome');
              }
            }
          });
        } else if (state is AuthError) {
          setState(() {
            _hasError = true;
            _isSuccess = false;
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

        return AuthScaffold(
          backgroundImage: 'assets/images/bubbles3.png',
          backgroundHeight: 250.0,
          showBackButton: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const Spacer(flex: 1),

                        // Header Matching Figma 08
                        AuthHeader(
                          title: isRecovery ? 'Password Recovery' : 'Verification',
                          subtitle: isRecovery
                              ? 'Enter 4-digits code we sent you\non your phone number'
                              : 'We sent a code to your Email\nAddress, Enter it below.',
                          isCentered: true,
                          titleFontSize: isRecovery ? 28.0 : 34.0,
                        ),

                        if (isRecovery) ...[
                          SizedBox(height: 8.h),
                          Text(
                            phoneText,
                            style: AppTypography.body.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                        SizedBox(height: 32.h),

                        // PIN Boxes (Scale-safe, Zero Overflow)
                        if (isLoading)
                          SizedBox(
                            height: 56.h,
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

                        // Custom Numeric Keypad (Background #E5E5E5)
                        NumericKeyboard(
                          onNumberPressed:
                              isLoading ? (_) {} : _onNumberPressed,
                          onBackspacePressed:
                              isLoading ? () {} : _onBackspacePressed,
                          onResendPressed:
                              isLoading ? () {} : _onResendPressed,
                        ),
                        SizedBox(height: 20.h),

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
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
