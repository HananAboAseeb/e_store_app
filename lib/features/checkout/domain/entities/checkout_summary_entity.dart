import 'package:equatable/equatable.dart';

import 'contact_info_entity.dart';
import 'order_item_entity.dart';
import 'shipping_address_entity.dart';
import 'shipping_option_entity.dart';
import 'voucher_entity.dart';

class CheckoutSummaryEntity extends Equatable {
  final String id;
  final ShippingAddressEntity shippingAddress;
  final ContactInfoEntity contactInfo;
  final List<OrderItemEntity> items;
  final List<ShippingOptionEntity> shippingOptions;
  final ShippingOptionEntity selectedShippingOption;
  final VoucherEntity? appliedVoucher;
  final String selectedPaymentMethod;

  const CheckoutSummaryEntity({
    required this.id,
    required this.shippingAddress,
    required this.contactInfo,
    required this.items,
    required this.shippingOptions,
    required this.selectedShippingOption,
    this.appliedVoucher,
    this.selectedPaymentMethod = 'card',
  });

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get discountAmount => appliedVoucher != null
      ? subtotal * (appliedVoucher!.discountPercentage / 100)
      : 0.0;

  double get shippingFee => selectedShippingOption.price;

  double get total => subtotal - discountAmount + shippingFee;

  int get itemCount => items.fold(0, (count, item) => count + item.quantity);

  CheckoutSummaryEntity copyWith({
    String? id,
    ShippingAddressEntity? shippingAddress,
    ContactInfoEntity? contactInfo,
    List<OrderItemEntity>? items,
    List<ShippingOptionEntity>? shippingOptions,
    ShippingOptionEntity? selectedShippingOption,
    VoucherEntity? appliedVoucher,
    bool clearVoucher = false,
    String? selectedPaymentMethod,
  }) {
    return CheckoutSummaryEntity(
      id: id ?? this.id,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      contactInfo: contactInfo ?? this.contactInfo,
      items: items ?? this.items,
      shippingOptions: shippingOptions ?? this.shippingOptions,
      selectedShippingOption:
          selectedShippingOption ?? this.selectedShippingOption,
      appliedVoucher:
          clearVoucher ? null : (appliedVoucher ?? this.appliedVoucher),
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }

  @override
  List<Object?> get props => [
        id,
        shippingAddress,
        contactInfo,
        items,
        shippingOptions,
        selectedShippingOption,
        appliedVoucher,
        selectedPaymentMethod,
      ];
}
