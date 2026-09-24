import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/checkout_summary_entity.dart';
import '../repositories/checkout_repository.dart';

class RemoveVoucherUseCase implements UseCase<CheckoutSummaryEntity, NoParam> {
  final CheckoutRepository repository;

  RemoveVoucherUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutSummaryEntity>> call([NoParam? param]) =>
      repository.removeVoucher();
}
