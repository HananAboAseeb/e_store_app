import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routing/route_names.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../manager/payment_cubit.dart';
import '../manager/payment_state.dart';
import '../widgets/payment_failure_modal.dart';
import '../widgets/payment_method_sheet.dart';
import '../widgets/payment_processing_modal.dart';
import '../widgets/payment_shimmer_loading.dart';
import '../widgets/payment_success_modal.dart';

class PaymentPage extends StatelessWidget {
  final double amount;

  const PaymentPage({
    super.key,
    this.amount = 34.00,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentCubit>(
      create: (context) => sl<PaymentCubit>()..loadPaymentMethods(),
      child: PaymentView(amount: amount),
    );
  }
}

class PaymentView extends StatelessWidget {
  final double amount;

  const PaymentView({
    super.key,
    required this.amount,
  });

  void _onDismiss(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(RouteNames.kCheckoutPage);
    }
  }

  void _onTrackOrder(BuildContext context, String orderId) {
    try {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order #$orderId placed successfully!'),
            backgroundColor: AppColors.primary,
          ),
        );
        context.go(RouteNames.kHomePage);
      }
    } catch (_) {
      if (context.mounted) {
        context.go(RouteNames.kHomePage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        final canDismissByBack = state is! PaymentProcessing;

        return PopScope(
          canPop: canDismissByBack,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && canDismissByBack) {
              _onDismiss(context);
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: Stack(
              children: [
                // 1. Frosted Glass Blurred Backdrop (Screen 51 background)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: canDismissByBack ? () => _onDismiss(context) : null,
                    behavior: HitTestBehavior.opaque,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        color: AppColors.background.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ),

                // 2. Bottom Sheet: Loading Shimmer, Payment Method Selection, or Error
                if (state is PaymentInitial ||
                    state is PaymentLoadingMethods ||
                    state is PaymentMethodSelection ||
                    state is PaymentError)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.12),
                            blurRadius: 24.r,
                            offset: const Offset(0, -6),
                          ),
                        ],
                      ),
                      child: _buildSheetContent(context, state),
                    ),
                  ),

                // 3. Modals Overlay Layer (Processing, Failure, Success)
                if (state is PaymentProcessing)
                  Positioned.fill(
                    child: Container(
                      color: AppColors.black.withValues(alpha: 0.25),
                      child: const Center(
                        child: PaymentProcessingModal(),
                      ),
                    ),
                  ),

                if (state is PaymentFailureState)
                  Positioned.fill(
                    child: Container(
                      color: AppColors.black.withValues(alpha: 0.25),
                      child: Center(
                        child: PaymentFailureModal(
                          onTryAgain: () {
                            context.read<PaymentCubit>().retryPayment();
                          },
                          onChange: () {
                            context.read<PaymentCubit>().changePaymentMethod();
                          },
                        ),
                      ),
                    ),
                  ),

                if (state is PaymentSuccessState)
                  Positioned.fill(
                    child: Container(
                      color: AppColors.black.withValues(alpha: 0.25),
                      child: Center(
                        child: PaymentSuccessModal(
                          onTrackOrder: () {
                            _onTrackOrder(context, state.result.orderId);
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSheetContent(BuildContext context, PaymentState state) {
    if (state is PaymentLoadingMethods || state is PaymentInitial) {
      return const PaymentShimmerLoading();
    }

    if (state is PaymentError) {
      return Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.message,
              style: AppTypography.body.copyWith(
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.sm),
            ElevatedButton(
              onPressed: () =>
                  context.read<PaymentCubit>().loadPaymentMethods(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'Retry',
                style: AppTypography.buttonText.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (state is PaymentMethodSelection) {
      return PaymentMethodSheet(
        methods: state.methods,
        selectedMethod: state.selectedMethod,
        onMethodSelected: (method) {
          context.read<PaymentCubit>().processPayment(method, amount);
        },
        onClose: () => _onDismiss(context),
      );
    }

    return const SizedBox.shrink();
  }
}
