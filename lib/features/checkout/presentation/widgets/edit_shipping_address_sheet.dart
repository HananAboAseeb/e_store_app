import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/shipping_address_entity.dart';

class EditShippingAddressSheet extends StatefulWidget {
  final ShippingAddressEntity initialAddress;
  final ValueChanged<ShippingAddressEntity> onSave;
  final VoidCallback? onClose;

  const EditShippingAddressSheet({
    super.key,
    required this.initialAddress,
    required this.onSave,
    this.onClose,
  });

  static Future<void> show({
    required BuildContext context,
    required ShippingAddressEntity address,
    required ValueChanged<ShippingAddressEntity> onSave,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.08),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: const SizedBox.expand(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: EditShippingAddressSheet(
                initialAddress: address,
                onSave: onSave,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<EditShippingAddressSheet> createState() =>
      _EditShippingAddressSheetState();
}

class _EditShippingAddressSheetState extends State<EditShippingAddressSheet> {
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _postcodeController;
  late String _country;

  @override
  void initState() {
    super.initState();
    _country = widget.initialAddress.country;
    _addressController =
        TextEditingController(text: widget.initialAddress.street);
    _cityController = TextEditingController(text: widget.initialAddress.city);
    _postcodeController =
        TextEditingController(text: widget.initialAddress.zipCode);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _postcodeController.dispose();
    super.dispose();
  }

  void _saveAndClose() {
    final updated = widget.initialAddress.copyWith(
      country: _country.isNotEmpty ? _country : widget.initialAddress.country,
      street: _addressController.text.trim().isNotEmpty
          ? _addressController.text.trim()
          : widget.initialAddress.street,
      city: _cityController.text.trim().isNotEmpty
          ? _cityController.text.trim()
          : widget.initialAddress.city,
      zipCode: _postcodeController.text.trim().isNotEmpty
          ? _postcodeController.text.trim()
          : widget.initialAddress.zipCode,
    );
    widget.onSave(updated);
    if (widget.onClose != null) {
      widget.onClose!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: 16.h,
        bottom: 16.h + bottomInset,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Title + Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Shipping Address',
                      style: AppTypography.h2.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _saveAndClose,
                    child: Container(
                      width: 36.h,
                      height: 36.h,
                      decoration: const BoxDecoration(
                        color: AppColors.gray100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 20.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Country Field (Grey background, 38h, 55r radius)
              _buildFieldLabel('Country'),
              SizedBox(height: 6.h),
              Container(
                width: double.infinity,
                height: 38.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.surfaceOption,
                  borderRadius: BorderRadius.circular(55.r),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _country,
                      style: AppTypography.body.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Icon(
                      Icons.info_outline,
                      size: 18.sp,
                      color: AppColors.gray500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Address Field (Soft Blue background AppColors.primarySoft, 38h, 55r radius)
              _buildFieldLabel('Address'),
              SizedBox(height: 6.h),
              _buildTextInput(
                controller: _addressController,
                hintText: 'Street Address',
              ),
              SizedBox(height: 12.h),

              // Town / City Field (Soft Blue background AppColors.primarySoft, 38h, 55r radius)
              _buildFieldLabel('Town / City'),
              SizedBox(height: 6.h),
              _buildTextInput(
                controller: _cityController,
                hintText: 'City',
              ),
              SizedBox(height: 12.h),

              // Postcode Field (Soft Blue background AppColors.primarySoft, 38h, 55r radius)
              _buildFieldLabel('Postcode'),
              SizedBox(height: 6.h),
              _buildTextInput(
                controller: _postcodeController,
                hintText: 'Postal Code',
              ),
              SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
      ),
    );
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      width: double.infinity,
      height: 38.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(55.r),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        style: AppTypography.body.copyWith(
          fontSize: 13.sp,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          hintStyle: AppTypography.bodySmall.copyWith(
            color: AppColors.gray400,
            fontSize: 13.sp,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
