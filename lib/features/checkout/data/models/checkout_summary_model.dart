import '../../domain/entities/checkout_summary_entity.dart';
import 'contact_info_model.dart';
import 'order_item_model.dart';
import 'shipping_address_model.dart';
import 'shipping_option_model.dart';
import 'voucher_model.dart';

class CheckoutSummaryModel extends CheckoutSummaryEntity {
  const CheckoutSummaryModel({
    required super.id,
    required super.shippingAddress,
    required super.contactInfo,
    required super.items,
    required super.shippingOptions,
    required super.selectedShippingOption,
    super.appliedVoucher,
    super.selectedPaymentMethod,
  });

  factory CheckoutSummaryModel.fromJson(Map<String, dynamic> json) {
    final itemsList = (json['items'] as List<dynamic>? ?? [])
        .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final optionsList = (json['shippingOptions'] as List<dynamic>? ?? [])
        .map((e) => ShippingOptionModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return CheckoutSummaryModel(
      id: json['id'] as String? ?? '',
      shippingAddress: ShippingAddressModel.fromJson(
        json['shippingAddress'] as Map<String, dynamic>? ?? {},
      ),
      contactInfo: ContactInfoModel.fromJson(
        json['contactInfo'] as Map<String, dynamic>? ?? {},
      ),
      items: itemsList,
      shippingOptions: optionsList,
      selectedShippingOption: json['selectedShippingOption'] != null
          ? ShippingOptionModel.fromJson(
              json['selectedShippingOption'] as Map<String, dynamic>,
            )
          : optionsList.firstWhere(
              (o) => o.isSelected,
              orElse: () => optionsList.first,
            ),
      appliedVoucher: json['appliedVoucher'] != null
          ? VoucherModel.fromJson(
              json['appliedVoucher'] as Map<String, dynamic>,
            )
          : null,
      selectedPaymentMethod: json['selectedPaymentMethod'] as String? ?? 'card',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shippingAddress':
          ShippingAddressModel.fromEntity(shippingAddress).toJson(),
      'contactInfo': ContactInfoModel.fromEntity(contactInfo).toJson(),
      'items': items.map((e) => OrderItemModel.fromEntity(e).toJson()).toList(),
      'shippingOptions': shippingOptions
          .map((e) => ShippingOptionModel.fromEntity(e).toJson())
          .toList(),
      'selectedShippingOption':
          ShippingOptionModel.fromEntity(selectedShippingOption).toJson(),
      'appliedVoucher': appliedVoucher != null
          ? VoucherModel.fromEntity(appliedVoucher!).toJson()
          : null,
      'selectedPaymentMethod': selectedPaymentMethod,
    };
  }

  factory CheckoutSummaryModel.fromEntity(CheckoutSummaryEntity entity) {
    return CheckoutSummaryModel(
      id: entity.id,
      shippingAddress: entity.shippingAddress,
      contactInfo: entity.contactInfo,
      items: entity.items,
      shippingOptions: entity.shippingOptions,
      selectedShippingOption: entity.selectedShippingOption,
      appliedVoucher: entity.appliedVoucher,
      selectedPaymentMethod: entity.selectedPaymentMethod,
    );
  }

  CheckoutSummaryEntity toEntity() => this;
}
