import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/auth_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go('/home');
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
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // Blue gradient blob - top area matching Figma
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 380.h,
                child: CustomPaint(
                  painter: _LoginGradientPainter(),
                  size: Size(double.infinity, 380.h),
                ),
              ),
            ),
            // Content
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 260.h),
                            // Title
                            Text(
                              'Login',
                              style: AppTypography.h1.copyWith(
                                fontSize: 34.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 36.h),
                            // Email Field
                            AuthTextField(
                              hintText: 'Email',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12.h),
                            // Password Field
                            AuthTextField(
                              hintText: 'Password',
                              controller: _passwordController,
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bottom actions
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return PrimaryButton(
                              text: 'Next',
                              isLoading: state is AuthLoading,
                              onPressed: state is AuthLoading ? null : _onLogin,
                            );
                          },
                        ),
                        SizedBox(height: 16.h),
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
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the blue gradient blob background matching Figma login screen.
class _LoginGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Main large blue blob - top-left area
    final Paint mainBlob = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.6),
        radius: 1.2,
        colors: [
          const Color(0xFF004BFE),
          const Color(0xFF2968FF).withOpacity(0.8),
          const Color(0xFF5184FF).withOpacity(0.3),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), mainBlob);

    // Secondary blob - right side
    final Paint rightBlob = Paint()
      ..shader = RadialGradient(
        center: const Alignment(1.2, 0.2),
        radius: 0.8,
        colors: [
          const Color(0xFF004BFE).withOpacity(0.9),
          const Color(0xFF2968FF).withOpacity(0.4),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), rightBlob);

    // White fade at bottom for smooth transition
    final Paint whiteFade = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.white,
        ],
        stops: [0.6, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), whiteFade);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
