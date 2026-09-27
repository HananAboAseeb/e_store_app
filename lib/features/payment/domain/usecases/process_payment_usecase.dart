import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/payment_method_entity.dart';
import '../entities/payment_result_entity.dart';
import '../repositories/payment_repository.dart';

class ProcessPaymentParams extends Equatable {
  final PaymentMethodEntity method;
  final double amount;

  const ProcessPaymentParams({
    required this.method,
    required this.amount,
  });

  @override
  List<Object?> get props => [method, amount];
}

class ProcessPaymentUseCase
    implements UseCase<PaymentResultEntity, ProcessPaymentParams> {
  final PaymentRepository repository;

  ProcessPaymentUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentResultEntity>> call(
      [ProcessPaymentParams? param]) {
    if (param == null) {
      return Future.value(
        const Left(ServerFailure('Missing payment parameters')),
      );
    }
    return repository.processPayment(param.method, param.amount);
  }
}
