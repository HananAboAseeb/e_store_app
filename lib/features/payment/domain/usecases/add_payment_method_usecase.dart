import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/payment_method_entity.dart';
import '../repositories/payment_repository.dart';

class AddPaymentMethodUseCase implements UseCase<void, PaymentMethodEntity> {
  final PaymentRepository repository;

  AddPaymentMethodUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call([PaymentMethodEntity? param]) {
    if (param == null) {
      return Future.value(
        const Left(ServerFailure('Missing payment method details')),
      );
    }
    return repository.addPaymentMethod(param);
  }
}
