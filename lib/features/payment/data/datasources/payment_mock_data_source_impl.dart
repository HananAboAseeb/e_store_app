import 'dart:math';

import '../../domain/entities/payment_method_entity.dart';
import '../../domain/entities/payment_result_entity.dart';
import '../models/payment_method_model.dart';
import '../models/payment_result_model.dart';
import 'payment_mock_data_source.dart';

class PaymentMockDataSourceImpl implements PaymentMockDataSource {
  final List<PaymentMethodModel> _methods = [
    const PaymentMethodModel(
      id: 'card-mastercard-1',
      type: PaymentMethodType.card,
      cardBrand: CardBrand.mastercard,
      maskedCardNumber: '* * * *   * * * *   * * * *   1579',
      cardholderName: 'AMANDA',
      expiryDate: '12/22',
      isDefault: true,
    ),
    const PaymentMethodModel(
      id: 'card-visa-1',
      type: PaymentMethodType.card,
      cardBrand: CardBrand.visa,
      maskedCardNumber: '* * * *   * * * *   * * * *   1579',
      cardholderName: 'AMANDA',
      expiryDate: '12/22',
      isDefault: false,
    ),
    const PaymentMethodModel(
      id: 'paypal-1',
      type: PaymentMethodType.paypal,
      cardBrand: CardBrand.none,
      maskedCardNumber: '',
      cardholderName: 'Amanda PayPal',
      expiryDate: '',
      isDefault: false,
    ),
  ];

  final Random _random = Random();

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.from(_methods);
  }

  @override
  Future<PaymentResultModel> processPayment(
    PaymentMethodModel method,
    double amount,
  ) async {
    // Simulate gateway roundtrip delay (2 seconds)
    await Future.delayed(const Duration(seconds: 2));

    // 70% success rate per Phase 1 Mock Specification
    final isSuccess = _random.nextDouble() < 0.70;
    final txId = 'tx-${DateTime.now().millisecondsSinceEpoch}';
    final orderId = 'order-2026-${_random.nextInt(9000) + 1000}';

    if (isSuccess) {
      return PaymentResultModel(
        id: txId,
        orderId: orderId,
        status: PaymentStatus.success,
        message: 'Your card has been successfully charged',
        amount: amount,
        timestamp: DateTime.now(),
      );
    } else {
      return PaymentResultModel(
        id: txId,
        orderId: orderId,
        status: PaymentStatus.failure,
        message: "We couldn't proceed your payment",
        amount: amount,
        timestamp: DateTime.now(),
      );
    }
  }

  @override
  Future<void> addPaymentMethod(PaymentMethodModel method) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _methods.add(method);
  }
}
