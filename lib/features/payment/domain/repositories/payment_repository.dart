import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/payment_method_entity.dart';
import '../entities/payment_result_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods();

  Future<Either<Failure, PaymentResultEntity>> processPayment(
    PaymentMethodEntity method,
    double amount,
  );

  Future<Either<Failure, void>> addPaymentMethod(PaymentMethodEntity method);
}
