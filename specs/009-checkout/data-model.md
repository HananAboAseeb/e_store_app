# Data Model: Checkout Feature (Screens 47, 48, 49, 50)

**Feature**: `specs/009-checkout` | **Date**: 2026-09-24

This document defines domain entities, data transfer models, and UI state representations for the **Checkout** feature.

---

## 1. Domain Entities (`lib/features/checkout/domain/entities/`)

### `OrderItemEntity`
Represents an item ready for checkout.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Line item identifier (e.g., `checkout-item-1`) |
| `productId` | `String` | Associated product identifier |
| `title` | `String` | Product title (e.g., "Lorem ipsum dolor sit amet...") |
| `imageUrl` | `String` | Asset path for item photo |
| `quantity` | `int` | Ordered quantity |
| `size` | `String` | Selected variant size (e.g., "M") |
| `color` | `String` | Selected variant color (e.g., "Pink") |
| `unitPrice` | `double` | Price per single unit (e.g., 17.00) |
| `totalPrice` | `double` | Computed: `unitPrice * quantity` |

### `ShippingAddressEntity`
Represents the delivery destination.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique address identifier |
| `country` | `String` | Country name (e.g., "United States" or "Iran") |
| `city` | `String` | City name (e.g., "New York") |
| `street` | `String` | Street address (e.g., "110 W 44th Street") |
| `zipCode` | `String` | Postal/ZIP code (e.g., "10036" / "10012") |
| `formattedAddress` | `String` | Computed multi-line or slash-separated address line |

### `ContactInfoEntity`
Represents the customer contact details.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique contact identifier |
| `phone` | `String` | Telephone number (e.g., "+1-866-922-8694") |
| `email` | `String` | Email address (e.g., "design.blackside@gmail.com") |

### `ShippingOptionEntity`
Represents a selectable shipping method.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Option identifier (`standard`, `express`) |
| `name` | `String` | Method name (e.g., "Standard", "Express") |
| `duration` | `String` | Duration pill text (e.g., "5 - 7 Days", "1 - 2 Days") |
| `price` | `double` | Shipping cost (e.g., 3.00, 12.00) |
| `estimatedDate` | `String` | Delivery date text (e.g., "Delivered on or before Thursday, 23 April 2020") |
| `isSelected` | `bool` | Whether option is currently selected |

### `VoucherEntity`
Represents a promotional voucher coupon.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Voucher identifier (`voucher-1`, `voucher-2`) |
| `title` | `String` | Header title (e.g., "From Customer Care", "First Purchase") |
| `description` | `String` | Discount description (e.g., "15% off your next purchase") |
| `discountPercentage` | `double` | Percentage discount (e.g., 15.0, 5.0) |
| `validUntil` | `String` | Expiration date string (e.g., "5.16.20", "6.20.20") |
| `code` | `String` | Coupon code |
| `iconType` | `String` | Icon variant (`careRosette`, `shoppingBag`) |

### `CheckoutSummaryEntity`
Aggregate root entity representing the complete checkout state.

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Checkout session identifier |
| `shippingAddress` | `ShippingAddressEntity` | Delivery destination |
| `contactInfo` | `ContactInfoEntity` | Contact details |
| `items` | `List<OrderItemEntity>` | Items in checkout |
| `shippingOptions` | `List<ShippingOptionEntity>` | Available delivery methods |
| `selectedShippingOption` | `ShippingOptionEntity` | Currently chosen shipping method |
| `appliedVoucher` | `VoucherEntity?` | Currently active voucher or `null` |
| `selectedPaymentMethod` | `String` | Selected method preview (`card`, `paypal`) |
| `subtotal` | `double` | Computed: sum of item totals |
| `discountAmount` | `double` | Computed: `subtotal * (discountPercentage / 100)` |
| `shippingFee` | `double` | Cost from `selectedShippingOption.price` |
| `total` | `double` | Computed: `subtotal - discountAmount + shippingFee` |

---

## 2. Data Models (`lib/features/checkout/data/models/`)

Each model extends its respective domain entity and implements `fromJson`, `toJson`, `fromEntity`, and `toEntity`.

- `OrderItemModel` extends `OrderItemEntity`
- `ShippingAddressModel` extends `ShippingAddressEntity`
- `ContactInfoModel` extends `ContactInfoEntity`
- `ShippingOptionModel` extends `ShippingOptionEntity`
- `VoucherModel` extends `VoucherEntity`
- `CheckoutSummaryModel` extends `CheckoutSummaryEntity`

---

## 3. Presentation State (`lib/features/checkout/presentation/manager/`)

### `CheckoutState` (extends `Equatable`)

```dart
abstract class CheckoutState extends Equatable {
  const CheckoutState();
  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

class CheckoutLoaded extends CheckoutState {
  final CheckoutSummaryEntity summary;

  const CheckoutLoaded({required this.summary});

  bool get hasVoucher => summary.appliedVoucher != null;

  @override
  List<Object?> get props => [summary];
}

class CheckoutError extends CheckoutState {
  final String message;
  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}
```
