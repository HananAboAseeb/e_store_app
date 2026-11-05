import '../../domain/entities/payment_history_entity.dart';

class PaymentHistoryModel extends PaymentHistoryEntity {
  const PaymentHistoryModel({
    required super.id,
    required super.orderNumber,
    required super.transactionDate,
    required super.amount,
    required super.isDebit,
  });

  factory PaymentHistoryModel.fromEntity(PaymentHistoryEntity entity) {
    return PaymentHistoryModel(
      id: entity.id,
      orderNumber: entity.orderNumber,
      transactionDate: entity.transactionDate,
      amount: entity.amount,
      isDebit: entity.isDebit,
    );
  }

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryModel(
      id: json['id'] as String? ?? '',
      orderNumber: json['orderNumber'] as String? ?? '',
      transactionDate: json['transactionDate'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      isDebit: json['isDebit'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'transactionDate': transactionDate,
      'amount': amount,
      'isDebit': isDebit,
    };
  }
}
