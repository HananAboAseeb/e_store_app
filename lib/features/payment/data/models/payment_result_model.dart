import '../../domain/entities/payment_result_entity.dart';

class PaymentResultModel extends PaymentResultEntity {
  const PaymentResultModel({
    required super.id,
    required super.orderId,
    required super.status,
    required super.message,
    required super.amount,
    required super.timestamp,
  });

  factory PaymentResultModel.fromJson(Map<String, dynamic> json) {
    final statusStr = json['status'] as String? ?? 'success';
    final timestampStr = json['timestamp'] as String?;

    return PaymentResultModel(
      id: json['id'] as String? ?? '',
      orderId: json['orderId'] as String? ?? '',
      status: statusStr == 'failure'
          ? PaymentStatus.failure
          : PaymentStatus.success,
      message: json['message'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      timestamp: timestampStr != null
          ? DateTime.tryParse(timestampStr) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'status': status == PaymentStatus.failure ? 'failure' : 'success',
      'message': message,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory PaymentResultModel.fromEntity(PaymentResultEntity entity) {
    return PaymentResultModel(
      id: entity.id,
      orderId: entity.orderId,
      status: entity.status,
      message: entity.message,
      amount: entity.amount,
      timestamp: entity.timestamp,
    );
  }

  PaymentResultEntity toEntity() => this;
}
