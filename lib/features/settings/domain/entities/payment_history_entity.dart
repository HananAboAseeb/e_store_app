import 'package:equatable/equatable.dart';

class PaymentHistoryEntity extends Equatable {
  final String id;
  final String orderNumber;
  final String transactionDate;
  final double amount;
  final bool isDebit;

  const PaymentHistoryEntity({
    required this.id,
    required this.orderNumber,
    required this.transactionDate,
    required this.amount,
    required this.isDebit,
  });

  String get formattedAmount =>
      '-\$${amount.toStringAsFixed(2).replaceAll('.', ',')}';

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        transactionDate,
        amount,
        isDebit,
      ];
}
