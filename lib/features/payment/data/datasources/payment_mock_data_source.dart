import '../models/payment_method_model.dart';
import '../models/payment_result_model.dart';

abstract class PaymentMockDataSource {
  Future<List<PaymentMethodModel>> getPaymentMethods();

  Future<PaymentResultModel> processPayment(
    PaymentMethodModel method,
    double amount,
  );

  Future<void> addPaymentMethod(PaymentMethodModel method);
}
