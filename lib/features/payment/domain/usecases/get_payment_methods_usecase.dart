import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/payment_method_entity.dart';
import '../repositories/payment_repository.dart';

class GetPaymentMethodsUseCase
    implements UseCase<List<PaymentMethodEntity>, NoParam> {
  final PaymentRepository repository;

  GetPaymentMethodsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> call([NoParam? param]) =>
      repository.getPaymentMethods();
}
