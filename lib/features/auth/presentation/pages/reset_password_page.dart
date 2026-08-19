import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/auth_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_action_section.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_scaffold.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;

  const ResetPasswordPage({
    super.key,
    required this.email,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().resetPassword(
            widget.email,
            _newPasswordController.text.trim(),
            _confirmPasswordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordReset) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password updated successfully! Please login with your new password.'),
              backgroundColor: AppColors.success,
            ),
          );
          context.go('/login');
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
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
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
                          title: 'Setup New Password',
                          subtitle: 'Please, setup a new password for\nyour account',
                          isCentered: true,
                          titleFontSize: 24,
                        ),
                        SizedBox(height: 28.h),

                        AuthTextField(
                          hintText: 'New Password',
                          controller: _newPasswordController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12.h),
                        AuthTextField(
                          hintText: 'Repeat New Password',
                          controller: _confirmPasswordController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please repeat your new password';
                            }
                            if (value != _newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AuthActionSection(
                buttonText: 'Save',
                isLoading: state is AuthLoading,
                onButtonPressed: state is AuthLoading ? null : _onSave,
              ),
            ],
          ),
        );
      },
    );
  }
}
