import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/shipping_address_entity.dart';
import '../cubits/shipping_settings_cubit.dart';
import '../cubits/shipping_settings_state.dart';
import '../widgets/shipping_field_group.dart';

class ShippingAddressPage extends StatelessWidget {
  const ShippingAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ShippingSettingsCubit>()..loadAddress(),
      child: const _ShippingAddressView(),
    );
  }
}

class _ShippingAddressView extends StatefulWidget {
  const _ShippingAddressView();

  @override
  State<_ShippingAddressView> createState() => _ShippingAddressViewState();
}

class _ShippingAddressViewState extends State<_ShippingAddressView> {
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _postcodeController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _postcodeController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _postcodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _syncControllers(ShippingAddressEntity address) {
    _addressController.text = address.addressLine;
    _cityController.text = address.city;
    _postcodeController.text = address.postcode;
    _phoneController.text = address.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShippingSettingsCubit, ShippingSettingsState>(
      listener: (context, state) {
        if (state.address != null && _addressController.text.isEmpty) {
          _syncControllers(state.address!);
        }
        if (state.status == ShippingSettingsStatus.saveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Shipping address updated successfully')),
          );
        }
      },
      builder: (context, state) {
        final address = state.address;
        final isEditing = state.isEditing;
        final countryValue = isEditing
            ? (address?.country ?? 'Iran')
            : (address?.country.isNotEmpty == true
                ? address!.country
                : 'Choose your country');

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
                    style: AppTypography.h1,
                  ),
                  SizedBox(height: 4.h),
                  AppText(
                    'Shipping Address',
                    style: AppTypography.h3.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ── Country Selector Row (342x60, r:15) ────────────────
                  GestureDetector(
                    onTap: () async {
                      if (isEditing) {
                        final selectedCountry = await context.push<String>(
                          RouteNames.kSettingsCountryPage,
                        );
                        if (selectedCountry != null && context.mounted) {
                          context
                              .read<ShippingSettingsCubit>()
                              .updateCountry(selectedCountry);
                        }
                      }
                    },
                    child: Container(
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.language,
                            size: 26.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  'Country',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                AppText(
                                  countryValue,
                                  style: AppTypography.body.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 22.sp,
                            color: AppColors.gray400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),

                  // ── Address Fields (342x38, r:55) ──────────────────────
                  ShippingFieldGroup(
                    label: 'Address',
                    value:
                        address?.addressLine ?? '110 W 44th Street, NY 10036',
                    isEditing: isEditing,
                    controller: _addressController,
                  ),
                  ShippingFieldGroup(
                    label: 'Town / City',
                    value: address?.city ?? 'New York',
                    isEditing: isEditing,
                    controller: _cityController,
                  ),
                  ShippingFieldGroup(
                    label: 'Postcode',
                    value: address?.postcode ?? '10012',
                    isEditing: isEditing,
                    controller: _postcodeController,
                  ),
                  ShippingFieldGroup(
                    label: 'Phone Number',
                    value: address?.phoneNumber ?? '+98*******22',
                    isEditing: isEditing,
                    controller: _phoneController,
                  ),
                  SizedBox(height: 24.h),

                  // ── Bottom Button (Edit Information vs Save Changes) ──
                  if (!isEditing)
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (address != null) {
                            _syncControllers(address);
                          }
                          context
                              .read<ShippingSettingsCubit>()
                              .toggleEditMode();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.profileEditButtonBg,
                          foregroundColor: AppColors.textPrimary,
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          'Edit Information',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  else
                    PrimaryButton(
                      text: 'Save Changes',
                      height: 48.h,
                      borderRadius: BorderRadius.circular(24.r),
                      onPressed: () {
                        final updated = ShippingAddressEntity(
                          id: address?.id ?? 'addr_01',
                          country: address?.country ?? 'Iran',
                          addressLine: _addressController.text.trim(),
                          city: _cityController.text.trim(),
                          postcode: _postcodeController.text.trim(),
                          phoneNumber: _phoneController.text.trim(),
                        );
                        context
                            .read<ShippingSettingsCubit>()
                            .saveAddress(updated);
                      },
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
