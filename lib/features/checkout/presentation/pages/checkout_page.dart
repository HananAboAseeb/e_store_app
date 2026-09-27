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
import '../../../../shared/navigation/custom_bottom_nav_bar.dart';
import '../manager/checkout_cubit.dart';
import '../manager/checkout_state.dart';
import '../widgets/checkout_app_bar.dart';
import '../widgets/checkout_bottom_bar.dart';
import '../widgets/checkout_contact_info_card.dart';
import '../widgets/checkout_items_section.dart';
import '../widgets/checkout_shimmer_loading.dart';
import '../widgets/checkout_shipping_address_card.dart';
import '../widgets/edit_shipping_address_sheet.dart';
import '../widgets/payment_method_preview.dart';
import '../widgets/shipping_options_section.dart';
import '../widgets/voucher_bottom_sheet.dart';

enum CheckoutActiveSheet {
  none,
  voucher,
  shippingAddress,
}

class CheckoutPage extends StatelessWidget {
  final CheckoutCubit? cubit;

  const CheckoutPage({
    super.key,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    if (cubit != null) {
      return BlocProvider.value(
        value: cubit!,
        child: const _CheckoutPageView(),
      );
    }

    return BlocProvider(
      create: (context) => sl<CheckoutCubit>()..loadCheckoutSummary(),
      child: const _CheckoutPageView(),
    );
  }
}

class _CheckoutPageView extends StatefulWidget {
  const _CheckoutPageView();

  @override
  State<_CheckoutPageView> createState() => _CheckoutPageViewState();
}

class _CheckoutPageViewState extends State<_CheckoutPageView> {
  CheckoutActiveSheet _activeSheet = CheckoutActiveSheet.none;

  void _openSheet(CheckoutActiveSheet sheet) {
    setState(() {
      _activeSheet = sheet;
    });
  }

  void _closeSheet() {
    if (_activeSheet != CheckoutActiveSheet.none) {
      setState(() {
        _activeSheet = CheckoutActiveSheet.none;
      });
    }
  }

  void _onPay(BuildContext context, double total) {
    context.push(RouteNames.kPaymentPage, extra: total);
  }

  void _onNavTap(BuildContext context, int index) {
    _closeSheet();
    try {
      switch (index) {
        case 0:
          context.go(RouteNames.kHomePage);
          break;
        case 1:
          context.go(RouteNames.kWishlistPage);
          break;
        case 2:
          context.go(RouteNames.kCatalogPage);
          break;
        case 3:
          // Already in cart / checkout
          break;
        case 4:
          context.go(RouteNames.kProfilePage);
          break;
      }
    } catch (_) {
      // Graceful fallback for environments without GoRouter configured
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // Persistent Bottom Navigation Bar (Cart tab index 3 selected)
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: (index) => _onNavTap(context, index),
      ),
      body: PopScope(
        canPop: _activeSheet == CheckoutActiveSheet.none,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && _activeSheet != CheckoutActiveSheet.none) {
            _closeSheet();
          }
        },
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading || state is CheckoutInitial) {
              return const SafeArea(child: CheckoutShimmerLoading());
            }

            if (state is CheckoutError) {
              return SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          onPressed: () => context
                              .read<CheckoutCubit>()
                              .loadCheckoutSummary(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
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
                  ),
                ),
              );
            }

            if (state is CheckoutLoaded) {
              final cubit = context.read<CheckoutCubit>();
              final summary = state.summary;

              return Stack(
                children: [
                  // ── 1. Main Scrollable Checkout Content ───────────────────
                  Column(
                    children: [
                      // Top App Bar
                      CheckoutAppBar(
                        onClose: () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                        },
                      ),

                      // Scrollable Content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 6.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Shipping Address Card
                              CheckoutShippingAddressCard(
                                address: summary.shippingAddress,
                                onEdit: () => _openSheet(
                                    CheckoutActiveSheet.shippingAddress),
                              ),
                              SizedBox(height: 12.h),

                              // Contact Information Card
                              CheckoutContactInfoCard(
                                contactInfo: summary.contactInfo,
                                onEdit: () => _openSheet(
                                    CheckoutActiveSheet.shippingAddress),
                              ),
                              SizedBox(height: 20.h),

                              // Items Section
                              CheckoutItemsSection(
                                items: summary.items,
                                appliedVoucher: summary.appliedVoucher,
                                onAddVoucher: () =>
                                    _openSheet(CheckoutActiveSheet.voucher),
                                onRemoveVoucher: () => cubit.removeVoucher(),
                              ),
                              SizedBox(height: 20.h),

                              // Shipping Options Section
                              ShippingOptionsSection(
                                options: summary.shippingOptions,
                                selectedOptionId:
                                    summary.selectedShippingOption.id,
                                onSelectOption: (optionId) =>
                                    cubit.selectShippingOption(optionId),
                              ),
                              SizedBox(height: 20.h),

                              // Payment Method Preview
                              PaymentMethodPreview(
                                selectedMethod: summary.selectedPaymentMethod,
                                onSelectMethod: (method) {
                                  cubit.selectPaymentMethod(method);
                                  context.push(
                                    RouteNames.kPaymentPage,
                                    extra: summary.total,
                                  );
                                },
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                      ),

                      // Sticky Total & Pay Bottom Bar (Above Bottom Navigation Bar)
                      CheckoutBottomBar(
                        total: summary.total,
                        onPay: () => _onPay(context, summary.total),
                      ),
                    ],
                  ),

                  // ── 2. Heavy Frosted Backdrop Blur Overlay ────────────────
                  if (_activeSheet != CheckoutActiveSheet.none)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: _closeSheet,
                        behavior: HitTestBehavior.opaque,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                            child: Container(
                              color: Colors.black.withOpacity(0.08),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // ── 3. Bottom Sheet Sitting Above Navigation Bar ───────────
                  if (_activeSheet != CheckoutActiveSheet.none)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 24.r,
                              offset: const Offset(0, -6),
                            ),
                          ],
                        ),
                        child: _activeSheet == CheckoutActiveSheet.voucher
                            ? VoucherBottomSheet(
                                vouchers: state.activeVouchers,
                                onApplyVoucher: (voucherId) {
                                  cubit.applyVoucher(voucherId);
                                  _closeSheet();
                                },
                                onClose: _closeSheet,
                              )
                            : EditShippingAddressSheet(
                                initialAddress: summary.shippingAddress,
                                onSave: (updatedAddress) {
                                  cubit.updateShippingAddress(updatedAddress);
                                  _closeSheet();
                                },
                                onClose: _closeSheet,
                              ),
                      ),
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
