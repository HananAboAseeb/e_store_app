import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/selection_card.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String email;

  const ForgotPasswordPage({
    super.key,
    required this.email,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // 'email' or 'sms'
  String _selectedMethod = 'sms';

  void _onNext() {
    context.read<AuthCubit>().forgotPassword(widget.email, _selectedMethod);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpSent) {
          // Navigate to OTP verification screen passing the email
          context.push('/verification', extra: state.email);
        } else if (state is AuthError) {
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
                      
                      // Avatar Header (matching 3D avatar on pink bg in Figma)
                      Center(
                        child: Container(
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFB2D9), // Pink background
                            border: Border.all(color: Colors.white, width: 4.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 16.r,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '👩‍💼', // Premium 3D-style business woman avatar emoji matching Figma girl with glasses
                            style: TextStyle(fontSize: 64.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      
                      // Title
                      Text(
                        'Password Recovery',
                        style: AppTypography.h2.copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      
                      // Subtitle
                      Text(
                        'How would you like to Restore\nyour Password?',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 36.h),
                      
                      // Selection choices (SMS / Email)
                      SelectionCard(
                        title: 'SMS',
                        subtitle: 'Send verification code via SMS text message',
                        icon: Icons.sms_rounded,
                        isSelected: _selectedMethod == 'sms',
                        onTap: () {
                          setState(() {
                            _selectedMethod = 'sms';
                          });
                        },
                      ),
                      SizedBox(height: 12.h),
                      SelectionCard(
                        title: 'Email',
                        subtitle: 'Send verification code via email address',
                        icon: Icons.email_rounded,
                        isSelected: _selectedMethod == 'email',
                        onTap: () {
                          setState(() {
                            _selectedMethod = 'email';
                          });
                        },
                      ),
                      
                      const Spacer(flex: 2),
                      
                      // Next Button
                      PrimaryButton(
                        text: 'Next',
                        isLoading: isLoading,
                        onPressed: isLoading ? null : _onNext,
                      ),
                      SizedBox(height: 16.h),
                      
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
