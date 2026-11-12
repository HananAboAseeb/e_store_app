import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../../shared/widgets/modal_close_button.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/payment_card_entity.dart';

class AddEditCardSheet extends StatefulWidget {
  final PaymentCardEntity? initialCard;

  const AddEditCardSheet({
    super.key,
    this.initialCard,
  });

  static Future<PaymentCardEntity?> show(
    BuildContext context, {
    PaymentCardEntity? initialCard,
  }) {
    return showGeneralDialog<PaymentCardEntity>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.25),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: AddEditCardSheet(initialCard: initialCard),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
    );
  }

  @override
  State<AddEditCardSheet> createState() => _AddEditCardSheetState();
}

class _AddEditCardSheetState extends State<AddEditCardSheet> {
  late final TextEditingController _holderController;
  late final TextEditingController _numberController;
  late final TextEditingController _expiryController;
  late final TextEditingController _cvvController;

  @override
  void initState() {
    super.initState();
    final card = widget.initialCard;
    _holderController = TextEditingController(text: card?.cardholderName ?? '');
    _numberController =
        TextEditingController(text: card?.maskedCardNumber ?? '');
    _expiryController = TextEditingController(text: card?.expirationDate ?? '');
    _cvvController = TextEditingController(text: card?.cvv ?? '');
  }

  @override
  void dispose() {
    _holderController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _onSave() {
    final holder = _holderController.text.trim();
    final number = _numberController.text.trim();
    final expiry = _expiryController.text.trim();
    final cvv = _cvvController.text.trim();

    if (holder.isEmpty || number.isEmpty || expiry.isEmpty || cvv.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required card fields')),
      );
      return;
    }

    final card = PaymentCardEntity(
      id: widget.initialCard?.id ??
          'card_${DateTime.now().millisecondsSinceEpoch}',
      cardBrand: number.startsWith('4') ? CardType.visa : CardType.mastercard,
      cardholderName: holder,
      maskedCardNumber: number,
      expirationDate: expiry,
      cvv: cvv,
      isDefault: widget.initialCard?.isDefault ?? false,
    );

    Navigator.of(context).pop(card);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialCard != null;
    final title = isEditing ? 'Edit Card' : 'Add Card';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      padding: EdgeInsets.only(
        top: 24.h,
        left: 24.w,
        right: 24.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  title,
                  style: AppTypography.h2,
                ),
                ModalCloseButton(
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 18.h),

            // Card Holder Field
            _buildField(
              label: 'Card Holder',
              controller: _holderController,
              placeholder: 'Required',
            ),
            SizedBox(height: 14.h),

            // Card Number Field
            _buildField(
              label: 'Card Number',
              controller: _numberController,
              placeholder: 'Required',
            ),
            SizedBox(height: 14.h),

            // Expiration Date & CVV Row
            Row(
              children: [
                Expanded(
                  child: _buildField(
                    label: 'Expiration Date',
                    controller: _expiryController,
                    placeholder: 'Required',
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: _buildField(
                    label: 'CVV',
                    controller: _cvvController,
                    placeholder: 'Required',
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Save Changes Button (Exact Figma specs: 342x48, r:24)
            PrimaryButton(
              text: 'Save Changes',
              height: 48.h,
              borderRadius: BorderRadius.circular(24.r),
              onPressed: _onSave,
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          style: AppTypography.fieldLabel,
        ),
        SizedBox(height: 4.h),
        Container(
          height: 38.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardFieldBg,
            borderRadius: BorderRadius.circular(55.r),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            style: AppTypography.body.copyWith(
              fontFamily: 'Raleway',
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              fillColor: Colors.transparent,
              filled: false,
              hintText: placeholder,
              hintStyle: AppTypography.body.copyWith(
                fontFamily: 'Raleway',
                color: AppColors.cardFieldRequired,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
