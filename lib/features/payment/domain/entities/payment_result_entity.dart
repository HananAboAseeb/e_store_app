import 'package:equatable/equatable.dart';

enum PaymentStatus {
  success,
  failure,
}

class PaymentResultEntity extends Equatable {
  final String id;
  final String orderId;
  final PaymentStatus status;
  final String message;
  final double amount;
  final DateTime timestamp;

  const PaymentResultEntity({
    required this.id,
    required this.orderId,
    required this.status,
    required this.message,
    required this.amount,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        orderId,
        status,
        message,
        amount,
        timestamp,
      ];
}
