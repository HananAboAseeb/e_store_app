import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/payment_method_entity.dart';
import 'add_card_button.dart';
import 'payment_card_item.dart';
import 'paypal_redirect_content.dart';

class PaymentMethodSheet extends StatefulWidget {
  final List<PaymentMethodEntity> methods;
  final PaymentMethodEntity? selectedMethod;
  final ValueChanged<PaymentMethodEntity> onMethodSelected;
  final VoidCallback? onClose;
  final VoidCallback? onAddCard;

  const PaymentMethodSheet({
    super.key,
    required this.methods,
    this.selectedMethod,
    required this.onMethodSelected,
    this.onClose,
    this.onAddCard,
  });

  static Future<void> show({
    required BuildContext context,
    required List<PaymentMethodEntity> methods,
    PaymentMethodEntity? selectedMethod,
    required ValueChanged<PaymentMethodEntity> onMethodSelected,
    VoidCallback? onClose,
    VoidCallback? onAddCard,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      barrierColor: AppColors.black.withOpacity(0.15),
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
              child: PaymentMethodSheet(
                methods: methods,
                selectedMethod: selectedMethod,
                onMethodSelected: onMethodSelected,
                onClose: onClose,
                onAddCard: onAddCard,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<PaymentMethodSheet> createState() => _PaymentMethodSheetState();
}

class _PaymentMethodSheetState extends State<PaymentMethodSheet> {
  bool _showPayPal = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedMethod?.type == PaymentMethodType.paypal) {
      _showPayPal = true;
    }
  }

  void _handleClose() {
    if (widget.onClose != null) {
      widget.onClose!();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardMethods =
        widget.methods.where((m) => m.type == PaymentMethodType.card).toList();

    final paypalMethod = widget.methods.firstWhere(
      (m) => m.type == PaymentMethodType.paypal,
      orElse: () => const PaymentMethodEntity(
        id: 'paypal-1',
        type: PaymentMethodType.paypal,
      ),
    );

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sheet Header: Title + Circular Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Payment Methods',
                    style: AppTypography.h2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _handleClose,
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceOption,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 18.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),

            // Sheet Body: PayPal redirect view (Screen 53) or Card List (Screens 51 & 52)
            if (_showPayPal)
              PayPalRedirectContent(
                onOkPressed: () {
                  widget.onMethodSelected(paypalMethod);
                },
              )
            else
              SizedBox(
                height: 145.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cardMethods.length + 1,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    if (index < cardMethods.length) {
                      final card = cardMethods[index];
                      return PaymentCardItem(
                        card: card,
                        onTap: () {
                          widget.onMethodSelected(card);
                        },
                        onSettingsTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Card settings coming soon'),
                            ),
                          );
                        },
                      );
                    } else {
                      return AddCardButton(
                        onTap: () {
                          if (widget.onAddCard != null) {
                            widget.onAddCard!();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Add Card functionality coming soon'),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ),

            SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
