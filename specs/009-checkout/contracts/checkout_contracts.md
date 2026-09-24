# Interface Contracts: Checkout Feature (Screens 47, 48, 49, 50)

**Feature**: `specs/009-checkout` | **Date**: 2026-09-24

This document formalizes the interface contracts across Clean Architecture layers for the **Checkout** feature.

---

## 1. Domain Repository Contract (`lib/features/checkout/domain/repositories/checkout_repository.dart`)

```dart
abstract class CheckoutRepository {
  /// Fetches the initial or current checkout summary.
  Future<Either<Failure, CheckoutSummaryEntity>> getCheckoutSummary();

  /// Fetches available active vouchers for Screen 48 bottom sheet.
  Future<Either<Failure, List<VoucherEntity>>> getActiveVouchers();

  /// Applies a voucher to the checkout session by voucher ID.
  Future<Either<Failure, CheckoutSummaryEntity>> applyVoucher(String voucherId);

  /// Removes the currently applied voucher from the checkout session.
  Future<Either<Failure, CheckoutSummaryEntity>> removeVoucher();

  /// Updates the selected shipping option (standard vs express).
  Future<Either<Failure, CheckoutSummaryEntity>> updateShippingOption(String optionId);

  /// Updates the destination shipping address (from Screen 50 bottom sheet).
  Future<Either<Failure, CheckoutSummaryEntity>> updateShippingAddress(ShippingAddressEntity address);

  /// Updates the selected payment method preview ('card' or 'paypal').
  Future<Either<Failure, CheckoutSummaryEntity>> updatePaymentMethod(String method);
}
```

---

## 2. Domain UseCases (`lib/features/checkout/domain/usecases/`)

```dart
class GetCheckoutSummaryUseCase implements UseCase<CheckoutSummaryEntity, NoParams> {
  final CheckoutRepository repository;
  GetCheckoutSummaryUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> call(NoParams params) {
    return repository.getCheckoutSummary();
  }
}

class GetActiveVouchersUseCase implements UseCase<List<VoucherEntity>, NoParams> {
  final CheckoutRepository repository;
  GetActiveVouchersUseCase(this.repository);

  @override
  Future<Either<Failure, List<VoucherEntity>>> call(NoParams params) {
    return repository.getActiveVouchers();
  }
}

class ApplyVoucherUseCase implements UseCase<CheckoutSummaryEntity, String> {
  final CheckoutRepository repository;
  ApplyVoucherUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> call(String voucherId) {
    return repository.applyVoucher(voucherId);
  }
}

class RemoveVoucherUseCase implements UseCase<CheckoutSummaryEntity, NoParams> {
  final CheckoutRepository repository;
  RemoveVoucherUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> call(NoParams params) {
    return repository.removeVoucher();
  }
}

class UpdateShippingOptionUseCase implements UseCase<CheckoutSummaryEntity, String> {
  final CheckoutRepository repository;
  UpdateShippingOptionUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> call(String optionId) {
    return repository.updateShippingOption(optionId);
  }
}

class UpdateShippingAddressUseCase implements UseCase<CheckoutSummaryEntity, ShippingAddressEntity> {
  final CheckoutRepository repository;
  UpdateShippingAddressUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> call(ShippingAddressEntity address) {
    return repository.updateShippingAddress(address);
  }
}
```

---

## 3. Data Source Contract (`lib/features/checkout/data/datasources/checkout_mock_data_source.dart`)

```dart
abstract class CheckoutMockDataSource {
  Future<CheckoutSummaryModel> getCheckoutSummary();
  Future<List<VoucherModel>> getActiveVouchers();
  Future<CheckoutSummaryModel> applyVoucher(String voucherId);
  Future<CheckoutSummaryModel> removeVoucher();
  Future<CheckoutSummaryModel> updateShippingOption(String optionId);
  Future<CheckoutSummaryModel> updateShippingAddress(ShippingAddressModel address);
  Future<CheckoutSummaryModel> updatePaymentMethod(String method);
}
```

---

## 4. Presentation Cubit Contract (`lib/features/checkout/presentation/manager/checkout_cubit.dart`)

```dart
abstract class CheckoutCubitContract {
  Future<void> loadCheckoutSummary();
  Future<void> applyVoucher(String voucherId);
  Future<void> removeVoucher();
  Future<void> selectShippingOption(String optionId);
  Future<void> updateShippingAddress(ShippingAddressEntity address);
  Future<void> selectPaymentMethod(String method);
  List<VoucherEntity> getAvailableVouchers();
}
```
