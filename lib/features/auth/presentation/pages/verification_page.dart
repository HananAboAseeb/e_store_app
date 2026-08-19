import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_scaffold.dart';
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
    context.read<AuthCubit>().forgotPassword(widget.email, 'email');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new verification code has been sent.'),
        backgroundColor: AppColors.primary400,
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
          Future.delayed(const Duration(milliseconds: 700), () {
            if (mounted) {
              router.go('/welcome');
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
                        const AuthHeader(
                          title: 'Verification',
                          subtitle:
                              'We sent a code to your Email\nAddress, Enter it below.',
                          isCentered: true,
                        ),
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

                        // Custom Numeric Keypad
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
