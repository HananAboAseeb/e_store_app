import 'package:equatable/equatable.dart';

enum PaymentMethodType {
  card,
  paypal,
}

enum CardBrand {
  mastercard,
  visa,
  none,
}

class PaymentMethodEntity extends Equatable {
  final String id;
  final PaymentMethodType type;
  final CardBrand cardBrand;
  final String maskedCardNumber;
  final String cardholderName;
  final String expiryDate;
  final bool isDefault;

  const PaymentMethodEntity({
    required this.id,
    required this.type,
    this.cardBrand = CardBrand.none,
    this.maskedCardNumber = '',
    this.cardholderName = '',
    this.expiryDate = '',
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        cardBrand,
        maskedCardNumber,
        cardholderName,
        expiryDate,
        isDefault,
      ];
}
