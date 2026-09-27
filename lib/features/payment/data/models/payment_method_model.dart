import '../../domain/entities/payment_method_entity.dart';

class PaymentMethodModel extends PaymentMethodEntity {
  const PaymentMethodModel({
    required super.id,
    required super.type,
    super.cardBrand = CardBrand.none,
    super.maskedCardNumber = '',
    super.cardholderName = '',
    super.expiryDate = '',
    super.isDefault = false,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    final typeString = json['type'] as String? ?? 'card';
    final brandString = json['cardBrand'] as String? ?? 'none';

    return PaymentMethodModel(
      id: json['id'] as String? ?? '',
      type: typeString == 'paypal'
          ? PaymentMethodType.paypal
          : PaymentMethodType.card,
      cardBrand: brandString == 'mastercard'
          ? CardBrand.mastercard
          : brandString == 'visa'
              ? CardBrand.visa
              : CardBrand.none,
      maskedCardNumber: json['maskedCardNumber'] as String? ?? '',
      cardholderName: json['cardholderName'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type == PaymentMethodType.paypal ? 'paypal' : 'card',
      'cardBrand': cardBrand == CardBrand.mastercard
          ? 'mastercard'
          : cardBrand == CardBrand.visa
              ? 'visa'
              : 'none',
      'maskedCardNumber': maskedCardNumber,
      'cardholderName': cardholderName,
      'expiryDate': expiryDate,
      'isDefault': isDefault,
    };
  }

  factory PaymentMethodModel.fromEntity(PaymentMethodEntity entity) {
    return PaymentMethodModel(
      id: entity.id,
      type: entity.type,
      cardBrand: entity.cardBrand,
      maskedCardNumber: entity.maskedCardNumber,
      cardholderName: entity.cardholderName,
      expiryDate: entity.expiryDate,
      isDefault: entity.isDefault,
    );
  }

  PaymentMethodEntity toEntity() => this;
}
