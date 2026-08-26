import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/auth_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../models/country_code.dart';
import '../widgets/auth_action_section.dart';
import '../widgets/auth_form_container.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/country_picker_bottom_sheet.dart';
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
      final fullPhone = '$_selectedDialCode${_phoneController.text.trim()}';
      context.read<AuthCubit>().register(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            fullPhone,
          );
    }
  }

  void _showCountryPicker() {
    CountryPickerBottomSheet.show(
      context,
      onCountrySelected: (CountryCode country) {
        setState(() {
          _selectedCountryFlag = country.flag;
          _selectedDialCode = country.dialCode;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpSent) {
          context.push('/verification', extra: state.email);
        } else if (state is AuthSuccess) {
          context.push('/verification', extra: state.user.email);
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
          backgroundImage: 'assets/images/Bubbles.png',
          child: AuthFormContainer(
            formKey: _formKey,
            topSpacing: 190,
            header: const AuthHeader(
              title: 'Create\nAccount',
              titleHeight: 1.15,
            ),
            fields: [
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
            actions: AuthActionSection(
              buttonText: 'Next',
              isLoading: state is AuthLoading,
              onButtonPressed: state is AuthLoading ? null : _onRegister,
            ),
          ),
        );
      },
    );
  }
}
