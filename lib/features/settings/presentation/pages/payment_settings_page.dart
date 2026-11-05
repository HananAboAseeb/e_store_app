import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_text.dart';
import '../../../payment/presentation/widgets/payment_card_item.dart';
import '../cubits/payment_settings_cubit.dart';
import '../cubits/payment_settings_state.dart';
import '../widgets/add_edit_card_sheet.dart';
import '../widgets/payment_history_row.dart';

class PaymentSettingsPage extends StatelessWidget {
  const PaymentSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PaymentSettingsCubit>()..loadPaymentData(),
      child: const _PaymentSettingsView(),
    );
  }
}

class _PaymentSettingsView extends StatelessWidget {
  const _PaymentSettingsView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentSettingsCubit, PaymentSettingsState>(
      listener: (context, state) {
        if (state.status == PaymentSettingsStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment card saved successfully')),
          );
        } else if (state.status == PaymentSettingsStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        final isHistoryMode = state.viewMode == PaymentViewMode.history;

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
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
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
                    'Payment Methods',
                    style: AppTypography.h3.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),

                  // ── Card Section Header ────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        'Card',
                        style: AppTypography.h3.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          // History Toggle Button (↺)
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<PaymentSettingsCubit>()
                                  .toggleViewMode();
                            },
                            child: Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: isHistoryMode
                                    ? AppColors.primary
                                    : AppColors.surfaceAnnouncement,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.history,
                                size: 20.sp,
                                color: isHistoryMode
                                    ? AppColors.white
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),

                          // Add Card Button (+)
                          GestureDetector(
                            onTap: () async {
                              final newCard =
                                  await AddEditCardSheet.show(context);
                              if (newCard != null && context.mounted) {
                                context
                                    .read<PaymentSettingsCubit>()
                                    .addCard(newCard);
                              }
                            },
                            child: Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: const BoxDecoration(
                                color: AppColors.surfaceAnnouncement,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 20.sp,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),

                  // ── Card Carousel ──────────────────────────────────────
                  SizedBox(
                    height: 159.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.cards.length,
                      separatorBuilder: (_, __) => SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        final card = state.cards[index];
                        return PaymentCardItem(
                          width: 284.w,
                          height: 159.h,
                          card: card.toPaymentMethodEntity(),
                          onTap: () {},
                          onSettingsTap: () async {
                            final updated = await AddEditCardSheet.show(
                              context,
                              initialCard: card,
                            );
                            if (updated != null && context.mounted) {
                              context
                                  .read<PaymentSettingsCubit>()
                                  .updateCard(updated);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: AppSpacing.xl),

                  // ── Mode-Specific Bottom Section ───────────────────────
                  if (!isHistoryMode) ...[
                    // Screen 89: PayPal Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          'PayPal',
                          style: AppTypography.h3.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: const BoxDecoration(
                            color: AppColors.surfaceAnnouncement,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 20.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: const BoxDecoration(
                            color: AppColors.paypalBlue,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'P',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: AppText(
                            'There is no account yet',
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    // Screen 92: Payment History Section
                    AppText(
                      'Payment History',
                      style: AppTypography.h3.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.history.length,
                      itemBuilder: (context, index) {
                        return PaymentHistoryRow(
                          transaction: state.history[index],
                        );
                      },
                    ),
                  ],
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
