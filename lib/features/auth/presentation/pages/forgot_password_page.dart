import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_action_section.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_scaffold.dart';
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
  String _selectedMethod = 'sms';

  void _onNext() {
    context.read<AuthCubit>().forgotPassword(widget.email, _selectedMethod);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpSent) {
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
        return AuthScaffold(
          backgroundImage: 'assets/images/bubbles3.png',
          showBackButton: true,
          child: Column(
            children: [
              const Spacer(flex: 1),

              // Avatar Header
              Center(
                child: Container(
                  width: 110.w,
                  height: 110.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFB2D9),
                    border: Border.all(color: Colors.white, width: 4.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16.r,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '👩‍💼',
                    style: TextStyle(fontSize: 56.sp),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              const AuthHeader(
                title: 'Password Recovery',
                subtitle: 'How would you like to Restore\nyour Password?',
                isCentered: true,
                titleFontSize: 24,
              ),
              SizedBox(height: 28.h),

              // Selection cards (SMS / Email)
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

              AuthActionSection(
                buttonText: 'Next',
                isLoading: state is AuthLoading,
                onButtonPressed: state is AuthLoading ? null : _onNext,
              ),
            ],
          ),
        );
      },
    );
  }
}
