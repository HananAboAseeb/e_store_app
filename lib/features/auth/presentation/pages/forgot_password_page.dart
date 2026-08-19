import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_avatar_header.dart';
import '../widgets/auth_button_group.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_selection_list.dart';
import 'verification_page.dart';

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
  int _selectedIndex = 0;

  final List<SelectionItem> _recoveryOptions = const [
    SelectionItem(
      title: 'SMS',
      value: 'sms',
    ),
    SelectionItem(
      title: 'Email',
      value: 'email',
    ),
  ];

  void _onNext() {
    final selectedMethod = _recoveryOptions[_selectedIndex].value;
    context.read<AuthCubit>().forgotPassword(widget.email, selectedMethod);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpSent) {
          context.push(
            '/verification',
            extra: {
              'email': state.email,
              'mode': VerificationMode.passwordRecovery,
              'phoneNumber': '+1 234 *****56',
            },
          );
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
          backgroundImage: 'assets/images/Bubbles4.png',
          backgroundHeight: 260.0,
          showBackButton: true,
          child: Column(
            children: [
              const Spacer(flex: 1),
              const AuthAvatarHeader(
                title: 'Password Recovery',
                subtitle: 'How would you like to Restore\nyour Password?',
              ),
              SizedBox(height: 28.h),

              // Simple Figma-style Selection List
              AuthSelectionList(
                items: _recoveryOptions,
                selectedIndex: _selectedIndex,
                onSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),

              const Spacer(flex: 2),

              AuthButtonGroup(
                primaryText: 'Next',
                isLoading: state is AuthLoading,
                onPrimaryPressed: state is AuthLoading ? null : _onNext,
              ),
            ],
          ),
        );
      },
    );
  }
}
