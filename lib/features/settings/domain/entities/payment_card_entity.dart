import 'package:equatable/equatable.dart';
import '../../../payment/domain/entities/payment_method_entity.dart';

enum CardType { mastercard, visa, other }

class PaymentCardEntity extends Equatable {
  final String id;
  final CardType cardBrand;
  final String cardholderName;
  final String maskedCardNumber;
  final String expirationDate;
  final String cvv;
  final bool isDefault;

  const PaymentCardEntity({
    required this.id,
    required this.cardBrand,
    required this.cardholderName,
    required this.maskedCardNumber,
    required this.expirationDate,
    required this.cvv,
    this.isDefault = false,
  });

  PaymentCardEntity copyWith({
    String? id,
    CardType? cardBrand,
    String? cardholderName,
    String? maskedCardNumber,
    String? expirationDate,
    String? cvv,
    bool? isDefault,
  }) {
    return PaymentCardEntity(
      id: id ?? this.id,
      cardBrand: cardBrand ?? this.cardBrand,
      cardholderName: cardholderName ?? this.cardholderName,
      maskedCardNumber: maskedCardNumber ?? this.maskedCardNumber,
      expirationDate: expirationDate ?? this.expirationDate,
      cvv: cvv ?? this.cvv,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  PaymentMethodEntity toPaymentMethodEntity() {
    return PaymentMethodEntity(
      id: id,
      type: PaymentMethodType.card,
      cardBrand:
          cardBrand == CardType.visa ? CardBrand.visa : CardBrand.mastercard,
      maskedCardNumber: maskedCardNumber,
      cardholderName: cardholderName,
      expiryDate: expirationDate,
      isDefault: isDefault,
    );
  }

  @override
  List<Object?> get props => [
        id,
        cardBrand,
        cardholderName,
        maskedCardNumber,
        expirationDate,
        cvv,
        isDefault,
      ];
}
