import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/auth_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/phone_input_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedCountryFlag = '🇬🇧';
  String _selectedDialCode = '+44';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      final fullPhoneNumber = '$_selectedDialCode${_phoneController.text.trim()}';
      context.read<AuthCubit>().register(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            fullPhoneNumber,
          );
    }
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        final countries = [
          {'flag': '🇬🇧', 'code': '+44', 'name': 'United Kingdom'},
          {'flag': '🇺🇸', 'code': '+1', 'name': 'United States'},
          {'flag': '🇸🇦', 'code': '+966', 'name': 'Saudi Arabia'},
          {'flag': '🇪🇬', 'code': '+20', 'name': 'Egypt'},
          {'flag': '🇦🇪', 'code': '+971', 'name': 'United Arab Emirates'},
        ];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Country',
                style: AppTypography.h2.copyWith(fontSize: 18.sp),
              ),
              SizedBox(height: 16.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: countries.length,
                separatorBuilder: (_, __) => const Divider(color: AppColors.border),
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return ListTile(
                    leading: Text(
                      country['flag']!,
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    title: Text(
                      country['name']!,
                      style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
                    ),
                    trailing: Text(
                      country['code']!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedCountryFlag = country['flag']!;
                        _selectedDialCode = country['code']!;
                      });
                      context.pop();
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
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
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // Blue gradient blob at top matching Figma register screen
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 380.h,
                child: CustomPaint(
                  painter: _RegisterGradientPainter(),
                  size: Size(double.infinity, 380.h),
                ),
              ),
            ),
            // Screen Content
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
                            SizedBox(height: 200.h),
                            // Title with line break matching Figma design
                            Text(
                              'Create\nAccount',
                              style: AppTypography.h1.copyWith(
                                fontSize: 34.sp,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
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
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email address';
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
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12.h),
                            // Phone Input Field
                            PhoneInputField(
                              controller: _phoneController,
                              selectedCountryFlag: _selectedCountryFlag,
                              selectedDialCode: _selectedDialCode,
                              onCountryTap: _showCountryPicker,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bottom Actions
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return PrimaryButton(
                              text: 'Next',
                              isLoading: state is AuthLoading,
                              onPressed: state is AuthLoading ? null : _onRegister,
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

/// Custom painter for the registration screen gradient blobs
class _RegisterGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Gradient blob from top-right down
    final Paint topGradientBlob = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.8, -0.4),
        radius: 1.3,
        colors: [
          const Color(0xFF004BFE),
          const Color(0xFF2968FF).withOpacity(0.7),
          const Color(0xFF5184FF).withOpacity(0.2),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), topGradientBlob);

    // Left side soft glow
    final Paint leftGlow = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-1.2, 0.1),
        radius: 0.9,
        colors: [
          const Color(0xFF004BFE).withOpacity(0.4),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), leftGlow);

    // White fade transition at the bottom
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
