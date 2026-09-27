# Data Model: Payment Feature (Screens 51, 52, 53, 54, 55, 56)

**Feature**: `specs/010-payment` | **Date**: 2026-09-25

This document defines domain entities, data transfer models, and UI state representations for the **Payment** feature.

---

## 1. Domain Entities (`lib/features/payment/domain/entities/`)

### `PaymentMethodType` (Enum)
```dart
enum PaymentMethodType {
  card,
  paypal,
}
```

### `CardBrand` (Enum)
```dart
enum CardBrand {
  mastercard,
  visa,
  none,
}
```

### `PaymentStatus` (Enum)
```dart
enum PaymentStatus {
  success,
  failure,
}
```

### `PaymentMethodEntity`
Represents a customer's saved payment method (Card or PayPal).

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier (e.g., `pm-card-mastercard-1`) |
| `type` | `PaymentMethodType` | Method type (`card` or `paypal`) |
| `cardBrand` | `CardBrand` | Brand if type is card (`mastercard`, `visa`, or `none`) |
| `maskedCardNumber` | `String` | Formatted masked number (e.g., `* * * *   * * * *   * * * *   1579`) |
| `cardholderName` | `String` | Name on card (e.g., `AMANDA`) |
| `expiryDate` | `String` | Expiration date string (e.g., `12/22`) |
| `isDefault` | `bool` | Whether this is the default payment method |

### `PaymentResultEntity`
Represents the outcome of a processed payment attempt.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Transaction/Payment attempt ID (e.g., `tx-89412`) |
| `orderId` | `String` | Associated order identifier (e.g., `order-2026-001`) |
| `status` | `PaymentStatus` | Payment outcome (`success` or `failure`) |
| `message` | `String` | Status message or failure reason |
| `amount` | `double` | Charged amount in USD (e.g., 34.00) |
| `timestamp` | `DateTime` | Transaction timestamp |

---

## 2. Data Models (`lib/features/payment/data/models/`)

### `PaymentMethodModel`
Extends `PaymentMethodEntity` with JSON serialization:
- `fromJson(Map<String, dynamic> json)`
- `toJson()`
- `fromEntity(PaymentMethodEntity entity)`
- `toEntity()`

### `PaymentResultModel`
Extends `PaymentResultEntity` with JSON serialization:
- `fromJson(Map<String, dynamic> json)`
- `toJson()`
- `fromEntity(PaymentResultEntity entity)`
- `toEntity()`

---

## 3. Presentation State (`lib/features/payment/presentation/manager/`)

```dart
abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoadingMethods extends PaymentState {}

class PaymentMethodSelection extends PaymentState {
  final List<PaymentMethodEntity> methods;
  final PaymentMethodEntity? selectedMethod;

  const PaymentMethodSelection({
    required this.methods,
    this.selectedMethod,
  });

  @override
  List<Object?> get props => [methods, selectedMethod];

  PaymentMethodSelection copyWith({
    List<PaymentMethodEntity>? methods,
    PaymentMethodEntity? selectedMethod,
  }) {
    return PaymentMethodSelection(
      methods: methods ?? this.methods,
      selectedMethod: selectedMethod ?? this.selectedMethod,
    );
  }
}

class PaymentProcessing extends PaymentState {
  final PaymentMethodEntity method;
  final double amount;

  const PaymentProcessing({
    required this.method,
    required this.amount,
  });

  @override
  List<Object?> get props => [method, amount];
}

class PaymentFailureState extends PaymentState {
  final PaymentMethodEntity method;
  final double amount;
  final String message;

  const PaymentFailureState({
    required this.method,
    required this.amount,
    required this.message,
  });

  @override
  List<Object?> get props => [method, amount, message];
}

class PaymentSuccessState extends PaymentState {
  final PaymentResultEntity result;

  const PaymentSuccessState({required this.result});

  @override
  List<Object?> get props => [result];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError({required this.message});

  @override
  List<Object?> get props => [message];
}
```
