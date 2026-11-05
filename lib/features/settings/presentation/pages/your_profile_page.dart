import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';
import '../cubits/account_cubit.dart';
import '../cubits/account_state.dart';

class YourProfilePage extends StatelessWidget {
  const YourProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AccountCubit>()..loadProfile(),
      child: const _YourProfileView(),
    );
  }
}

class _YourProfileView extends StatefulWidget {
  const _YourProfileView();

  @override
  State<_YourProfileView> createState() => _YourProfileViewState();
}

class _YourProfileViewState extends State<_YourProfileView> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state.userProfile != null) {
          if (_usernameController.text.isEmpty) {
            _usernameController.text = state.userProfile!.username;
            _emailController.text = state.userProfile!.email;
            _passwordController.text = state.userProfile!.passwordMasked;
          }
        }
        if (state.status == AccountStatus.updateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        }
      },
      builder: (context, state) {
        final profile = state.userProfile;
        final username = profile?.username ?? 'Romina';
        final email = profile?.email ?? 'gmail@example.com';
        final password = profile?.passwordMasked ?? '***************';
        final avatarUrl =
            profile?.avatarUrl ?? 'assets/images/profile_picture.png';

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Settings',
                    style: AppTypography.h1.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  AppText(
                    'Your Profile',
                    style: AppTypography.h3.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Avatar (Left-aligned)
                  Container(
                    width: 84.w,
                    height: 84.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          size: 40,
                          color: AppColors.gray400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Username Field
                  AppText(
                    'Username',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.infinity,
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardFieldBg,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    alignment: Alignment.centerLeft,
                    child: state.isEditing
                        ? TextField(
                            controller: _usernameController,
                            cursorColor: AppColors.primary,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              fillColor: Colors.transparent,
                              filled: false,
                            ),
                          )
                        : AppText(
                            username,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                            ),
                          ),
                  ),
                  SizedBox(height: 16.h),

                  // Email Address Field
                  AppText(
                    'Email Address',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.infinity,
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardFieldBg,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    alignment: Alignment.centerLeft,
                    child: state.isEditing
                        ? TextField(
                            controller: _emailController,
                            cursorColor: AppColors.primary,
                            keyboardType: TextInputType.emailAddress,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              fillColor: Colors.transparent,
                              filled: false,
                            ),
                          )
                        : AppText(
                            email,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                            ),
                          ),
                  ),
                  SizedBox(height: 16.h),

                  // Password Field
                  AppText(
                    'Password',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.infinity,
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardFieldBg,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    alignment: Alignment.centerLeft,
                    child: state.isEditing
                        ? TextField(
                            controller: _passwordController,
                            cursorColor: AppColors.primary,
                            obscureText: true,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                              letterSpacing: 2.0,
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              fillColor: Colors.transparent,
                              filled: false,
                            ),
                          )
                        : AppText(
                            password,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                              letterSpacing: 2.0,
                            ),
                          ),
                  ),
                  SizedBox(height: 36.h),

                  // Edit Information Button (Exact Figma specs: 342x48, r:15, bg: #00000026)
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.isEditing) {
                          final updated = profile?.copyWith(
                            username: _usernameController.text.trim(),
                            email: _emailController.text.trim(),
                          );
                          if (updated != null) {
                            context.read<AccountCubit>().updateProfile(updated);
                          }
                        } else {
                          context.read<AccountCubit>().toggleEditMode();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.profileEditButtonBg,
                        foregroundColor: AppColors.textPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      child: Text(
                        state.isEditing ? 'Save Changes' : 'Edit Information',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
