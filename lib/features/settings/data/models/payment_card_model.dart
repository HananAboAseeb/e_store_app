import '../../domain/entities/payment_card_entity.dart';

class PaymentCardModel extends PaymentCardEntity {
  const PaymentCardModel({
    required super.id,
    required super.cardBrand,
    required super.cardholderName,
    required super.maskedCardNumber,
    required super.expirationDate,
    required super.cvv,
    super.isDefault = false,
  });

  factory PaymentCardModel.fromEntity(PaymentCardEntity entity) {
    return PaymentCardModel(
      id: entity.id,
      cardBrand: entity.cardBrand,
      cardholderName: entity.cardholderName,
      maskedCardNumber: entity.maskedCardNumber,
      expirationDate: entity.expirationDate,
      cvv: entity.cvv,
      isDefault: entity.isDefault,
    );
  }

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) {
    return PaymentCardModel(
      id: json['id'] as String? ?? '',
      cardBrand:
          json['cardBrand'] == 'visa' ? CardType.visa : CardType.mastercard,
      cardholderName: json['cardholderName'] as String? ?? '',
      maskedCardNumber: json['maskedCardNumber'] as String? ?? '',
      expirationDate: json['expirationDate'] as String? ?? '',
      cvv: json['cvv'] as String? ?? '',
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardBrand': cardBrand == CardType.visa ? 'visa' : 'mastercard',
      'cardholderName': cardholderName,
      'maskedCardNumber': maskedCardNumber,
      'expirationDate': expirationDate,
      'cvv': cvv,
      'isDefault': isDefault,
    };
  }
}
