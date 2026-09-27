import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../../domain/entities/payment_result_entity.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_mock_data_source.dart';
import '../models/payment_method_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentMockDataSource mockDataSource;

  PaymentRepositoryImpl(this.mockDataSource);

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods() async {
    return await safeCall(() async {
      final models = await mockDataSource.getPaymentMethods();
      return List<PaymentMethodEntity>.from(models);
    });
  }

  @override
  Future<Either<Failure, PaymentResultEntity>> processPayment(
    PaymentMethodEntity method,
    double amount,
  ) async {
    final methodModel = PaymentMethodModel.fromEntity(method);
    return await safeCall(
      () => mockDataSource.processPayment(methodModel, amount),
    );
  }

  @override
  Future<Either<Failure, void>> addPaymentMethod(
    PaymentMethodEntity method,
  ) async {
    final methodModel = PaymentMethodModel.fromEntity(method);
    return await safeCall(
      () => mockDataSource.addPaymentMethod(methodModel),
    );
  }
}
