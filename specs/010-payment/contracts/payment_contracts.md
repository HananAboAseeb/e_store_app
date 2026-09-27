# Interface Contracts: Payment Feature (Screens 51, 52, 53, 54, 55, 56)

**Feature**: `specs/010-payment` | **Date**: 2026-09-25

This document formalizes the interface contracts across Clean Architecture layers for the **Payment** feature.

---

## 1. Domain Repository Contract (`lib/features/payment/domain/repositories/payment_repository.dart`)

```dart
abstract class PaymentRepository {
  /// Fetches saved payment methods (cards and digital wallet options).
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods();

  /// Processes payment through the payment gateway for the given method and amount.
  Future<Either<Failure, PaymentResultEntity>> processPayment(
    PaymentMethodEntity method,
    double amount,
  );

  /// Adds a new payment method (placeholder for Phase 1).
  Future<Either<Failure, void>> addPaymentMethod(PaymentMethodEntity method);
}
```

---

## 2. Domain UseCases (`lib/features/payment/domain/usecases/`)

```dart
class GetPaymentMethodsUseCase implements UseCase<List<PaymentMethodEntity>, NoParams> {
  final PaymentRepository repository;
  GetPaymentMethodsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> call(NoParams params) {
    return repository.getPaymentMethods();
  }
}

class ProcessPaymentParams extends Equatable {
  final PaymentMethodEntity method;
  final double amount;

  const ProcessPaymentParams({
    required this.method,
    required this.amount,
  });

  @override
  List<Object?> get props => [method, amount];
}

class ProcessPaymentUseCase implements UseCase<PaymentResultEntity, ProcessPaymentParams> {
  final PaymentRepository repository;
  ProcessPaymentUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentResultEntity>> call(ProcessPaymentParams params) {
    return repository.processPayment(params.method, params.amount);
  }
}

class AddPaymentMethodUseCase implements UseCase<void, PaymentMethodEntity> {
  final PaymentRepository repository;
  AddPaymentMethodUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(PaymentMethodEntity params) {
    return repository.addPaymentMethod(params);
  }
}
```

---

## 3. Data Source Contract (`lib/features/payment/data/datasources/payment_mock_data_source.dart`)

```dart
abstract class PaymentMockDataSource {
  /// Returns mock saved cards (Mastercard, Visa) and PayPal option.
  Future<List<PaymentMethodModel>> getPaymentMethods();

  /// Simulates 2-3 second payment processing with configurable/alternating success or failure.
  Future<PaymentResultModel> processPayment(PaymentMethodModel method, double amount);

  /// Adds a new payment method to mock store.
  Future<void> addPaymentMethod(PaymentMethodModel method);
}
```

---

## 4. Cubit Contract (`lib/features/payment/presentation/manager/payment_cubit.dart`)

```dart
class PaymentCubit extends Cubit<PaymentState> {
  final GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  final ProcessPaymentUseCase processPaymentUseCase;

  PaymentCubit({
    required this.getPaymentMethodsUseCase,
    required this.processPaymentUseCase,
  }) : super(PaymentInitial());

  /// Loads saved payment methods and transitions to PaymentMethodSelection.
  Future<void> loadPaymentMethods();

  /// Sets the currently selected payment method.
  void selectPaymentMethod(PaymentMethodEntity method);

  /// Initiates payment processing with simulated delay.
  Future<void> processPayment(PaymentMethodEntity method, double amount);

  /// Retries the last attempted payment (from Screen 55 "Try Again").
  Future<void> retryPayment();

  /// Re-opens payment method selection (from Screen 55 "Change").
  void changePaymentMethod();

  /// Resets payment state to initial.
  void reset();
}
```
