import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/use_cases/use_case.dart';
import '../../domain/entities/shipping_address_entity.dart';
import '../../domain/usecases/apply_voucher_usecase.dart';
import '../../domain/usecases/get_active_vouchers_usecase.dart';
import '../../domain/usecases/get_checkout_summary_usecase.dart';
import '../../domain/usecases/remove_voucher_usecase.dart';
import '../../domain/usecases/update_shipping_address_usecase.dart';
import '../../domain/usecases/update_shipping_option_usecase.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final GetCheckoutSummaryUseCase getCheckoutSummaryUseCase;
  final GetActiveVouchersUseCase getActiveVouchersUseCase;
  final ApplyVoucherUseCase applyVoucherUseCase;
  final RemoveVoucherUseCase removeVoucherUseCase;
  final UpdateShippingOptionUseCase updateShippingOptionUseCase;
  final UpdateShippingAddressUseCase updateShippingAddressUseCase;

  CheckoutCubit({
    required this.getCheckoutSummaryUseCase,
    required this.getActiveVouchersUseCase,
    required this.applyVoucherUseCase,
    required this.removeVoucherUseCase,
    required this.updateShippingOptionUseCase,
    required this.updateShippingAddressUseCase,
  }) : super(const CheckoutInitial());

  Future<void> loadCheckoutSummary() async {
    emit(const CheckoutLoading());
    final summaryResult = await getCheckoutSummaryUseCase(NoParam());
    final vouchersResult = await getActiveVouchersUseCase(NoParam());

    summaryResult.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (summary) {
        final vouchers = vouchersResult.fold(
          (failure) => <dynamic>[],
          (vouchersList) => vouchersList,
        );
        emit(CheckoutLoaded(
          summary: summary,
          activeVouchers: vouchers.cast(),
        ));
      },
    );
  }

  Future<void> applyVoucher(String voucherId) async {
    final currentState = state;
    if (currentState is! CheckoutLoaded) return;

    final result = await applyVoucherUseCase(voucherId);
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (updatedSummary) => emit(
        currentState.copyWith(summary: updatedSummary),
      ),
    );
  }

  Future<void> removeVoucher() async {
    final currentState = state;
    if (currentState is! CheckoutLoaded) return;

    final result = await removeVoucherUseCase(NoParam());
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (updatedSummary) => emit(
        currentState.copyWith(
          summary: updatedSummary,
          activeVouchers: currentState.activeVouchers,
        ),
      ),
    );
  }

  Future<void> selectShippingOption(String optionId) async {
    final currentState = state;
    if (currentState is! CheckoutLoaded) return;

    final result = await updateShippingOptionUseCase(optionId);
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (updatedSummary) => emit(
        currentState.copyWith(summary: updatedSummary),
      ),
    );
  }

  Future<void> updateShippingAddress(ShippingAddressEntity address) async {
    final currentState = state;
    if (currentState is! CheckoutLoaded) return;

    final result = await updateShippingAddressUseCase(address);
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (updatedSummary) => emit(
        currentState.copyWith(summary: updatedSummary),
      ),
    );
  }

  void selectPaymentMethod(String method) {
    final currentState = state;
    if (currentState is! CheckoutLoaded) return;

    final updated =
        currentState.summary.copyWith(selectedPaymentMethod: method);
    emit(currentState.copyWith(summary: updated));
  }
}
